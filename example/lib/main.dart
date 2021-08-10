import 'dart:developer' as developer;

import 'package:example/pages/list_view_page.dart';
import 'package:example/widgets/note_widget.dart';
import 'package:fl_paging/fl_paging.dart';
import 'package:flutter/material.dart';
import 'package:fl_paging/fl_paging.dart' as paging;

import 'data/models/note.dart';
import 'data/note_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListViewPage(),
    );
  }
}

class ListViewPage extends StatefulWidget {
  static const ROUTE_NAME = 'ListViewPage';
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  static const TAG = 'ListViewPage';
  final GlobalKey key = GlobalKey();
  late ListViewDataSource dataSource;
  @override
  void initState() {
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
      body: PagingListView<Note>(
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

