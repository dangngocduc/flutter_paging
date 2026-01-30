import 'dart:developer' as developer;

import 'package:fl_paging/src/datasource/data_source.dart';
import 'package:fl_paging/src/widgets/builder.dart';
import 'package:fl_paging/src/widgets/default/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;

import 'base_widget.dart';
import 'default/load_more_widget.dart';
import 'default/paging_default_loading.dart';
import 'paging_state.dart';

class PagingGridView<T> extends BaseWidget<T> {
  static const ROUTE_NAME = 'GridView';
  final widgets.EdgeInsets? padding;
  final SliverGridDelegate delegate;
  final bool isEnablePullToRefresh;

  PagingGridView(
      {Key? key,
      this.padding,
      required this.delegate,
      this.isEnablePullToRefresh = true,
      required ValueIndexWidgetBuilder<T> itemBuilder,
      WidgetBuilder? emptyBuilder,
      WidgetBuilder? loadingBuilder,
      ErrorBuilder? errorBuilder,
      WidgetBuilder? loadmoreBuilder,
      ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
          ScrollViewKeyboardDismissBehavior.manual,
      required DataSource<T> pageDataSource})
      : super(
            itemBuilder: itemBuilder,
            emptyBuilder: emptyBuilder,
            loadingBuilder: loadingBuilder,
            errorBuilder: errorBuilder,
            loadmoreBuilder: loadmoreBuilder,
            keyboardDismissBehavior: keyboardDismissBehavior,
            pageDataSource: pageDataSource,
            key: key);

  @override
  GridViewState<T> createState() => GridViewState<T>();
}

class GridViewState<T> extends State<PagingGridView<T>> {
  static const TAG = 'GridView';

  PagingState<T> _pagingState = PagingState.loading();

  void retry() {
    _loadPage(isRefresh: false);
  }

  Future _loadPage({bool isRefresh = false}) async {
    developer.log('_loadPage [isRefresh]: [$isRefresh]', name: TAG);
    if (isRefresh == true) {
      try {
        final value =
            await widget.pageDataSource.loadPage(isRefresh: isRefresh);
        setState(() {
          _pagingState =
              PagingState(value, false, widget.pageDataSource.isEndList);
        });
      } catch (error) {
        setState(() {
          _pagingState = PagingState.error(error);
        });
      }
    } else {
      if (_pagingState is PagingStateLoading<T>) {
        widget.pageDataSource.loadPage().then((value) {
          setState(() {
            _pagingState =
                PagingState(value, false, widget.pageDataSource.isEndList);
          });
        }, onError: (error) {
          setState(() {
            _pagingState = PagingState.error(error);
          });
        });
      } else {
        if (_pagingState is PagingStateError<T>) {
          setState(() {
            _pagingState = PagingState.loading();
          });
        }
        widget.pageDataSource.loadPage().then((value) {
          final oldState = (_pagingState as PagingStateData);
          setState(() {
            if (value.length == 0) {
              _pagingState = oldState.copyWith
                  .call(isLoadMore: false, isEndList: true) as PagingState<T>;
            } else {
              _pagingState = oldState.copyWith.call(
                  isLoadMore: false,
                  isEndList: widget.pageDataSource.isEndList,
                  datas: oldState.datas..addAll(value)) as PagingState<T>;
            }
          });
        }, onError: (error) {
          setState(() {
            _pagingState = PagingState.error(error);
          });
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  void refresh() {
    _loadPage(isRefresh: true);
  }

  @override
  void didUpdateWidget(PagingGridView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.delegate is SliverGridDelegateWithFixedCrossAxisCount &&
        oldWidget.delegate is SliverGridDelegateWithFixedCrossAxisCount) {
      if ((widget.delegate as SliverGridDelegateWithFixedCrossAxisCount)
              .childAspectRatio !=
          (oldWidget.delegate as SliverGridDelegateWithFixedCrossAxisCount)
              .childAspectRatio) {
        setState(() {});
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _pagingState.when((datas, isLoadMore, isEndList) {
      if (datas.length == 0) {
        if (widget.emptyBuilder != null) {
          return widget.emptyBuilder!(context);
        } else {
          return EmptyWidget();
        }
      } else {
        Widget child = widgets.SliverGrid(
          gridDelegate: widget.delegate,
          delegate: SliverChildBuilderDelegate((context, index) {
            return widget.itemBuilder(context, datas[index], index);
          }, childCount: datas.length),
        );
        final body = NotificationListener<ScrollNotification>(
          child: CustomScrollView(
            keyboardDismissBehavior: widget.keyboardDismissBehavior,
            slivers: [
              widgets.SliverPadding(
                padding: widget.padding ?? EdgeInsets.zero,
                sliver: child,
              ),
              if (!isEndList)
                SliverToBoxAdapter(
                  child: widget.loadmoreBuilder?.call(context) ??
                      widget.loadingBuilder?.call(context) ??
                      LoadMoreWidget(),
                )
            ],
          ),
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
                if (isEndList) return false;
                if (_pagingState is PagingStateData) {
                  if (!isEndList && !isLoadMore) {
                    _loadPage();
                    setState(() {
                      _pagingState = (_pagingState as PagingStateData<T>)
                          .copyWith
                          .call(isLoadMore: true);
                    });
                  }
                }
              }
            } else if (notification is ScrollUpdateNotification) {
              //To show floating
            }
            return false;
          },
        );
        if (!widget.isEnablePullToRefresh) return body;
        return RefreshIndicator(
          child: body,
          onRefresh: () {
            return _loadPage(isRefresh: true);
          },
        );
      }
    }, loading: () {
      if (widget.loadingBuilder != null) {
        return widget.loadingBuilder!(context);
      } else {
        return PagingDefaultLoading();
      }
    }, error: (error) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(context, error);
      } else {
        return ErrorWidget(error);
      }
    });
  }
}
