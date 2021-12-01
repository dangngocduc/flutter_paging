import 'package:fl_paging/src/datasource/data_source.dart';
import 'package:fl_paging/src/widgets/base_widget.dart';
import 'package:fl_paging/src/widgets/default/empty_widget.dart';
import 'package:fl_paging/src/widgets/default/paging_default_loading.dart';
import 'package:fl_paging/src/widgets/paging_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:pull_to_refresh/pull_to_refresh.dart' as libPullToRefresh;
import 'builder.dart';
import 'default/load_more_widget.dart';

class PagingListView<T> extends BaseWidget<T> {
  final widgets.EdgeInsets padding;
  final IndexedWidgetBuilder? separatorBuilder;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool isEnablePullToRefresh;
  final bool materialRefreshIndicator;
  ///work only when materialRefreshIndicator = true
  final libPullToRefresh.CustomHeader? cupertinoCustomHeader;
  ///work only when materialRefreshIndicator = true
  final libPullToRefresh.CustomFooter? cupertinoCustomFooter;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final ValueChanged? errorWhenLoadMore;
  PagingListView(
      {Key? key,
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
      this.isEnablePullToRefresh = true,
      this.materialRefreshIndicator = true,
        this.cupertinoCustomHeader,
        this.cupertinoCustomFooter,
      this.cacheExtent,
      this.dragStartBehavior = DragStartBehavior.start,
      this.errorWhenLoadMore,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
        required ValueIndexWidgetBuilder<T> itemBuilder,
        WidgetBuilder? emptyBuilder,
        WidgetBuilder? loadingBuilder,
        ErrorBuilder?  errorBuilder,
      required DataSource<T> pageDataSource})
      : super(
            itemBuilder: itemBuilder,
      emptyBuilder: emptyBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      pageDataSource: pageDataSource, key: key);
  @override
  ListViewState<T> createState() => ListViewState<T>();
}

class ListViewState<T> extends State<PagingListView<T>> {
  static const TAG = 'ListView';
  CancelableOperation? cancelableOperation;
  PagingState<T> _pagingState = PagingState.loading();
  ScrollController scrollController = ScrollController();
  libPullToRefresh.RefreshController _refreshController = libPullToRefresh.RefreshController(initialRefresh: false);

  PagingState<T> get pagingState => _pagingState;
  List<T> getData() {
    return _pagingState.maybeWhen(
            (datas, isLoadMore, isEndList) => datas,
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
            false, widget.pageDataSource.isEndList));
      } catch (error) {
        emit(PagingState.error(error));
      }
    } else {
      if (_pagingState is PagingStateLoading<T>) {
        cancelableOperation = CancelableOperation.fromFuture(widget.pageDataSource.loadPage());
        cancelableOperation!.value.then((value) {
          emit(PagingState<T>(value, false, widget.pageDataSource.isEndList));
        }, onError: (error) {
          emit(PagingState.error(error));
        });
      } else {
        if(_pagingState is PagingStateError<T>) {
          emit(PagingState.loading());
        }
        cancelableOperation = CancelableOperation.fromFuture(widget.pageDataSource.loadPage());
        cancelableOperation!.value.then((value) {
          if (_pagingState is PagingStateData<T>) {
            final oldState = (_pagingState as PagingStateData<T>);
            if (value.length == 0) {
              emit(oldState.copyWith
                  .call(isLoadMore: false, isEndList: true));
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
  void initState() {
    super.initState();
    _loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return _pagingState.when((datas, isLoadMore, isEndList) {
      if(!isLoadMore){
        _refreshController.loadComplete();
      }
      if (datas.length == 0) {
        if (widget.emptyBuilder == null) {
          return EmptyWidget();
        }
        return widget.emptyBuilder!(context);
      } else {
        //region child
        Widget child = widgets.ListView.separated(
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
              Widget temp = widget.materialRefreshIndicator ? LoadMoreWidget() : Container();
              return index == datas.length
                  ? temp
                  : widget.itemBuilder(context, datas[index], index);
            },
            itemCount: !isEndList ? datas.length + 1 : datas.length,
          );
        //endregion
        if (!widget.isEnablePullToRefresh){
          return child;
        }else{
          //endregion
          if(widget.materialRefreshIndicator){
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
          }else{
            return libPullToRefresh.SmartRefresher(
              enablePullDown: true,
              enablePullUp: !widget.pageDataSource.isEndList,
              header: widget.cupertinoCustomHeader ?? libPullToRefresh.CustomHeader(
                builder: (context, status){
                  if(status == libPullToRefresh.RefreshStatus.refreshing || status == libPullToRefresh.RefreshStatus.canRefresh){
                    return CupertinoActivityIndicator();
                  }else{
                    return Container();
                  }
                },
              ),
              footer:widget.cupertinoCustomFooter ?? libPullToRefresh.CustomFooter(builder: (context, status){
                if(status == libPullToRefresh.LoadStatus.loading){
                  return CupertinoActivityIndicator();
                }else{
                  return Container();
                }

              }),
              onRefresh: cupertinoRefresh,
              onLoading: cupertinoLoadMore,
              controller: _refreshController,
              child: child,
            );
          }

        }

      }
    },
        loading: () => (widget.loadingBuilder != null)
            ? widget.loadingBuilder!(context)
            : PagingDefaultLoading(),
        error: (error) => widget.errorBuilder != null
            ? widget.errorBuilder!(context, error)
            : ErrorWidget(error));
  }


  cupertinoRefresh() {
    _loadPage(isRefresh: true).then((value) => _refreshController.refreshCompleted());
  }

  cupertinoLoadMore(){
    if(!widget.pageDataSource.isEndList){
      _loadPage();
    }else{
      _refreshController.loadComplete();
    }
  }
}
