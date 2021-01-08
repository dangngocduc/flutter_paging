import 'dart:developer' as developer;

import 'package:fl_paging/src/datasource/data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;

import 'base_widget.dart';
import 'default/load_more_widget.dart';
import 'default/paging_default_loading.dart';
import 'paging_state.dart';

class GridView<T> extends BaseWidget<T> {
  static const ROUTE_NAME = 'GridView';
  final widgets.EdgeInsets padding;
  final SliverGridDelegate delegate;
  GridView(
      {Key key,
      this.padding,
      this.delegate,
        ValueIndexWidgetBuilder<T> itemBuilder,
      DataSource<T> pageDataSource})
      : super(
            itemBuilder: itemBuilder, pageDataSource: pageDataSource, key: key);

  @override
  _GridViewState<T> createState() => _GridViewState<T>();
}

class _GridViewState<T> extends State<GridView<T>> {
  static const TAG = 'GridView';

  PagingState<T> _pagingState = PagingState.loading();

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

  @override
  Widget build(BuildContext context) {
    return _pagingState.when((datas, isLoadMore, isEndList) {
      if (datas.length == 0) {
        return widget.emptyBuilder(context);
      } else {
        Widget child = widgets.SliverGrid(
          gridDelegate: widget.delegate,
          delegate: SliverChildBuilderDelegate((context, index) {
            return widget.itemBuilder(context, datas[index], null);
          }, childCount: datas.length),
        );
        return RefreshIndicator(
          child: NotificationListener<ScrollNotification>(
            child: CustomScrollView(
              slivers: [
                widgets.SliverPadding(
                  padding: widget.padding,
                  sliver: child,
                ),
                if (!isEndList)
                  SliverToBoxAdapter(
                    child: LoadMoreWidget(),
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
          ),
          onRefresh: () {
            return _loadPage(isRefresh: true);
          },
        );
      }
    }, loading: () {
      if (widget.loadingBuilder != null) {
        return widget.loadingBuilder(context);
      } else {
        return PagingDefaultLoading();
      }
    }, error: (error) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder(context, error);
      } else {
        return ErrorWidget(error);
      }
    });
  }
}
