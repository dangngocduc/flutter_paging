import 'dart:developer' as developer;
import 'package:example/data/models/note.dart';
import 'package:example/data/note_repository.dart';
import 'package:example/widgets/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:paging/paging.dart' as paging;
import 'package:tuple/tuple.dart';

import 'dart:developer' as developer;
import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  static const ROUTE_NAME = 'ListViewPage';
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  static const TAG = 'ListViewPage';
  final GlobalKey key = GlobalKey();
  ListViewDataSource dataSource;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataSource = ListViewDataSource(NoteRepository());
  }
  @override
  Widget build(BuildContext context) {
    developer.log('build', name: 'ListViewPage');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Demo ListView'),
      ),
      body: paging.ListView<Note>(
        key: key,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, data, child) {
          return NoteWidget(data);
        },
        pageDataSource: dataSource,
      ),
    );
  }
}


class ListViewDataSource extends paging.PageKeyedDataSource<int, Note> {
  NoteRepository noteRepository;
  ListViewDataSource(this.noteRepository) {
    isEndList = false;
  }

  @override
  Future<Tuple2<List<Note>, int>> loadInitial() async {
    final result = await noteRepository.getNotes(0);
    return Tuple2(result, 0);
  }

  @override
  Future<Tuple2<List<Note>, int>> loadPageAfter(int params) async {
    if (params == 6) isEndList = true;
    final result = await noteRepository.getNotes(params + 1);
    return Tuple2(result, params + 1);
  }
}