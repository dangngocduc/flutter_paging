import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:paging/paging.dart' as paging;
import 'package:tuple/tuple.dart';

class ListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Demo ListView'),
      ),
      body: paging.ListView<String>(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, data, child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Text(data),
          );
        },
        pageDataSource: ListViewDataSource(),
      ),
    );
  }
}


class ListViewDataSource extends paging.PageKeyedDataSource<int, String> {
  ListViewDataSource() {
    isEndList = false;
  }

  @override
  Future<Tuple2<List<String>, int>> loadInitial() async {
    return Future.delayed(Duration(seconds: 2), () => Tuple2(
      [
        'item1',
        'item1',
        'item1',
        'item1',
        'item1',
        'item1',
      ],
      0
    ));
  }

  @override
  Future<Tuple2<List<String>, int>> loadPageAfter(int params) {
    if (params == 6) isEndList = true;
    return Future.delayed(Duration(seconds: 2), () => Tuple2(
        [
          'item1',
          'item1',
          'item1',
          'item1',
          'item1',
          'item1',
        ],
        params++
    ));
  }

}