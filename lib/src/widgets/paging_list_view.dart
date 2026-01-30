import 'dart:developer' as developer;

import 'package:async/async.dart';
import 'package:fl_paging/src/datasource/data_source.dart';
import 'package:fl_paging/src/widgets/base_widget.dart';
import 'package:fl_paging/src/widgets/default/empty_widget.dart';
import 'package:fl_paging/src/widgets/default/paging_default_loading.dart';
import 'package:fl_paging/src/widgets/paging_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;

import 'builder.dart';
import 'default/load_more_widget.dart';

enum StylePullToRefresh { ANDROID, IOS }

class PagingListView<T> extends BaseWidget<T> {
  final widgets.EdgeInsets padding;
  final IndexedWidgetBuilder? separatorBuilder;
  final Axis scrollDirection;
  final bool reverse;
  final bool isEnablePullToRefresh;
  final StylePullToRefresh stylePullToRefresh;
  final ScrollController? controller;
  final bool? primary;

  ///In Android pull to refresh only work
  /// if total height height  < height of screen => physics = [AlwaysScrollableScrollPhysics]
  /// if total height of item > height of screen => physics = [BouncingScrollPhysics] || [AlwaysScrollableScrollPhysics]
  /// default physics = [AlwaysScrollableScrollPhysics]
  final ScrollPhysics? physics;

  final bool shrinkWrap;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final ValueChanged? errorWhenLoadMore;
  PagingListView(
      {Key? key,
      this.isEnablePullToRefresh = true,
      this.stylePullToRefresh = StylePullToRefresh.ANDROID,
      this.padding = EdgeInsets.zero,
      this.separatorBuilder,
      this.scrollDirection = Axis.vertical,
      this.reverse = false,
      this.controller,
      this.primary,
      this.physics,
      this.shrinkWrap = false,
      this.addRepaintBoundaries = true,
      this.addAutomaticKeepAlives = true,
      this.addSemanticIndexes = true,
      this.cacheExtent,
      this.dragStartBehavior = DragStartBehavior.start,
      this.errorWhenLoadMore,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      required ValueIndexWidgetBuilder<T> itemBuilder,
      WidgetBuilder? emptyBuilder,
      WidgetBuilder? loadingBuilder,
      WidgetBuilder? loadmoreBuilder,
      ErrorBuilder? errorBuilder,
      required DataSource<T> pageDataSource})
      : super(
            itemBuilder: itemBuilder,
            emptyBuilder: emptyBuilder,
            loadingBuilder: loadingBuilder,
            loadmoreBuilder: loadmoreBuilder,
            errorBuilder: errorBuilder,
            pageDataSource: pageDataSource,
            key: key);
  @override
  ListViewState<T> createState() => ListViewState<T>();
}

class ListViewState<T> extends State<PagingListView<T>> {
  static const TAG = 'ListView';
  CancelableOperation? cancelableOperation;
  PagingState<T> _pagingState = PagingState.loading();
  PagingState<T> get pagingState => _pagingState;

  List<T> getData() {
    return _pagingState.maybeWhen((datas, isLoadMore, isEndList) => datas,
        orElse: () => []);
  }

  @override
  void dispose() {
    cancelableOperation?.cancel();
    super.dispose();
  }

  void emit(PagingState<T> state) {
    if (mounted) {
      setState(() {
        _pagingState = state;
      });
    }
  }

  void refresh() {
    _loadPage(isRefresh: true);
  }

  void retry() {
    _loadPage(isRefresh: false);
  }

  Future _loadPage({bool isRefresh = false}) async {
    if (cancelableOperation != null && !cancelableOperation!.isCompleted) {
      cancelableOperation!.cancel();
    }
    if (isRefresh == true) {
      try {
        emit(PagingState<T>(
            await widget.pageDataSource.loadPage(isRefresh: isRefresh),
            false,
            widget.pageDataSource.isEndList));
      } catch (error) {
        emit(PagingState.error(error));
      }
    } else {
      if (_pagingState is PagingStateLoading<T>) {
        cancelableOperation =
            CancelableOperation.fromFuture(widget.pageDataSource.loadPage());
        cancelableOperation!.value.then((value) {
          emit(PagingState<T>(value, false, widget.pageDataSource.isEndList));
        }, onError: (error) {
          emit(PagingState.error(error));
        });
      } else {
        if (_pagingState is PagingStateError<T>) {
          emit(PagingState.loading());
        }
        cancelableOperation =
            CancelableOperation.fromFuture(widget.pageDataSource.loadPage());
        cancelableOperation!.value.then((value) {
          if (_pagingState is PagingStateData<T>) {
            final oldState = (_pagingState as PagingStateData<T>);
            if (value.length == 0) {
              emit(oldState.copyWith.call(isLoadMore: false, isEndList: true));
            } else {
              emit(oldState.copyWith.call(
                  isLoadMore: false,
                  isEndList: widget.pageDataSource.isEndList,
                  datas: oldState.datas..addAll(value)));
            }
          } else {
            emit(PagingState<T>(value, false, widget.pageDataSource.isEndList));
          }
        }, onError: (error) {
          if (widget.errorWhenLoadMore != null) {
            widget.errorWhenLoadMore!(error);
          } else {
            emit(PagingState.error(error));
          }
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant PagingListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageDataSource != widget.pageDataSource) {
      developer.log(
          'Your DataSource is updated. your ListView will reload, to avoid this case, we recommend define a variable for \n'
          'Datasource on `initState`',
          name: 'ListViewState');
      emit(PagingState.loading());
      _loadPage();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return _pagingState.when((datas, isLoadMore, isEndList) {
      if (datas.length == 0) {
        if (widget.emptyBuilder == null) {
          return EmptyWidget();
        }
        return widget.emptyBuilder!(context);
      } else {
        //region child
        Widget child;
        child = widgets.ListView.separated(
          padding: widget.padding,
          cacheExtent: widget.cacheExtent,
          scrollDirection: widget.scrollDirection,
          reverse: widget.reverse,
          primary: widget.primary,
          physics: widget.physics,
          controller: widget.controller,
          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
          addRepaintBoundaries: widget.addRepaintBoundaries,
          addSemanticIndexes: widget.addSemanticIndexes,
          dragStartBehavior: widget.dragStartBehavior,
          shrinkWrap: widget.shrinkWrap,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          separatorBuilder: (context, index) {
            return widget.separatorBuilder != null
                ? widget.separatorBuilder!(context, index)
                : const SizedBox(
                    height: 16,
                  );
          },
          itemBuilder: (context, index) {
            return index == datas.length
                ? widget.loadmoreBuilder?.call(context) ??
                    widget.loadingBuilder?.call(context) ??
                    LoadMoreWidget()
                : widget.itemBuilder(context, datas[index], index);
          },
          itemCount: !isEndList ? datas.length + 1 : datas.length,
        );
        if (widget.isEnablePullToRefresh) {
          if (widget.stylePullToRefresh == StylePullToRefresh.ANDROID) {
            return RefreshIndicator(
              child: NotificationListener<ScrollNotification>(
                child: child,
                onNotification: (notification) {
                  if (!isEndList &&
                      notification is ScrollEndNotification &&
                      (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent)) {
                    if (_pagingState is PagingStateData<T> &&
                        (!isEndList && !isLoadMore)) {
                      _loadPage();
                      emit((_pagingState as PagingStateData<T>)
                          .copyWith(isLoadMore: true));
                    }
                  }
                  return false;
                },
              ),
              onRefresh: () {
                return _loadPage(isRefresh: true);
              },
            );
          } else {
            Widget childListUpdate = SliverSafeArea(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final int itemIndex = index ~/ 2;
                    if (index.isEven) {
                      return itemIndex == datas.length
                          ? widget.loadmoreBuilder?.call(context) ??
                              widget.loadingBuilder?.call(context) ??
                              LoadMoreWidget()
                          : widget.itemBuilder(
                              context, datas[itemIndex], itemIndex);
                    }
                    return widget.separatorBuilder != null
                        ? widget.separatorBuilder!(context, itemIndex)
                        : const SizedBox(
                            height: 16,
                          );
                  },
                  semanticIndexCallback: (Widget widget, int localIndex) {
                    if (localIndex.isEven) {
                      return localIndex ~/ 2;
                    }
                    return null;
                  },
                  addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                  addRepaintBoundaries: widget.addRepaintBoundaries,
                  addSemanticIndexes: widget.addSemanticIndexes,
                  childCount:
                      !isEndList ? datas.length * 2 + 2 : datas.length * 2,
                ),
              ),
            );

            // ScrollPhysics physics = Platform.isIOS ? AlwaysScrollableScrollPhysics() : BouncingScrollPhysics();
            return NotificationListener<ScrollNotification>(
              child: Padding(
                padding: widget.padding,
                child: ScrollConfiguration(
                  behavior: CupertinoScrollBehavior(),
                  child: CustomScrollView(
                    shrinkWrap: widget.shrinkWrap,
                    physics: widget.physics ?? AlwaysScrollableScrollPhysics(),
                    cacheExtent: widget.cacheExtent,
                    scrollDirection: widget.scrollDirection,
                    reverse: widget.reverse,
                    primary: widget.primary,
                    controller: widget.controller,
                    dragStartBehavior: widget.dragStartBehavior,
                    keyboardDismissBehavior: widget.keyboardDismissBehavior,
                    slivers: [
                      CupertinoSliverRefreshControl(
                        refreshTriggerPullDistance: 100.0,
                        refreshIndicatorExtent: 60.0,
                        onRefresh: () async {
                          return _loadPage(isRefresh: true);
                        },
                      ),
                      childListUpdate
                    ],
                  ),
                ),
              ),
              onNotification: (notification) {
                if (!isEndList &&
                    notification is ScrollEndNotification &&
                    (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent)) {
                  if (_pagingState is PagingStateData<T> &&
                      (!isEndList && !isLoadMore)) {
                    _loadPage();
                    emit((_pagingState as PagingStateData<T>)
                        .copyWith(isLoadMore: true));
                  }
                }
                return false;
              },
            );
          }
        } else {
          return NotificationListener<ScrollNotification>(
            child: child,
            onNotification: (notification) {
              if (!isEndList &&
                  notification is ScrollEndNotification &&
                  (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent)) {
                if (_pagingState is PagingStateData<T> &&
                    (!isEndList && !isLoadMore)) {
                  _loadPage();
                  emit((_pagingState as PagingStateData<T>)
                      .copyWith(isLoadMore: true));
                }
              }
              return false;
            },
          );
        }

        //endregion
      }
    },
        loading: () => (widget.loadingBuilder != null)
            ? widget.loadingBuilder!(context)
            : PagingDefaultLoading(),
        error: (error) => widget.errorBuilder != null
            ? widget.errorBuilder!(context, error)
            : ErrorWidget(error));
  }
}
