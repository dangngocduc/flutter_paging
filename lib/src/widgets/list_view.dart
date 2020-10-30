import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:paging/src/datasource/data_source.dart';
import 'package:paging/src/widgets/default/paging_default_loading.dart';
import 'package:paging/src/widgets/paging_state.dart';
import 'package:flutter/widgets.dart' as widgets;


import 'builder.dart';
import 'default/load_more_widget.dart';

class ListView<T> extends StatefulWidget {
  static const ROUTE_NAME = 'ListView';

  final WidgetBuilder emptyBuilder;

  final WidgetBuilder loadingBuilder;

  final ErrorBuilder errorBuilder;

  final ValueWidgetBuilder<T> itemBuilder;

  final DataSource<T> pageDataSource;

  final int pageSize;

  final  EdgeInsets padding;

  ListView({
    this.pageSize,
    this.emptyBuilder, this.loadingBuilder, this.errorBuilder,
    this.itemBuilder, this.pageDataSource, this.padding
});

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState<T> extends State<ListView<T>> {
  static const TAG = 'ListView';

  PagingState<T> _pagingState = PagingState.loading();

  Future _loadPage({bool isRefresh = false}) async {
    if (isRefresh == true) {
      try {
        final value = await widget.pageDataSource.loadPage(isRefresh: isRefresh);
        setState(() {
          _pagingState = PagingState(value, false, value.length < widget.pageSize);
        });
      } catch(error) {
        setState(() {
          _pagingState = PagingState.error(error);
        });
      }
    } else {
      if (_pagingState is PagingStateLoading<T>) {
        widget.pageDataSource.loadPage().then((value) {
          setState(() {
            _pagingState = PagingState(value, false, value.length < widget.pageSize);
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
              _pagingState = oldState.copyWith.call(isLoadMore: false, isEndList: true) as PagingState<T>;
            } else {
              _pagingState = oldState.copyWith.call(
                  isLoadMore: false,
                  isEndList: value.length <  widget.pageSize,
                  datas: oldState.datas..addAll(value)
              ) as PagingState<T>;
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
  Widget build(BuildContext context) {
    return _pagingState.when(
      (datas, isLoadMore, isEndList) {
        if (datas.length == 0) {
          return widget.emptyBuilder(context);
        } else {
          Widget child = widgets.ListView.separated(
            padding: widget.padding,
            separatorBuilder: (context, index) => SizedBox(height: 16,),
            itemBuilder: (context, index) {
              if (index == datas.length) {
                return LoadMoreWidget();
              } else {
                return widget.itemBuilder(context, datas[index], null);
              }
            },
            itemCount: !isEndList ? datas.length + 1 : datas.length,
          );

          return RefreshIndicator(
            child: NotificationListener<ScrollNotification>(
              child: child,
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (isEndList) return false;
                  if (_pagingState is PagingStateData) {
                    if (!isEndList && !isLoadMore) {
                      _loadPage();
                      setState(() {
                        _pagingState = (_pagingState as PagingStateData<T>).copyWith.call(isLoadMore: true);
                      });
                    }
                  }
                } else if (notification is ScrollUpdateNotification ) {
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
      },
      loading: () => PagingDefaultLoading(),
      error: (error) => ErrorWidget(error),
    );
  }
}
