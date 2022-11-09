
import 'package:example/data/models/note.dart';
import 'package:example/data/note_repository.dart';
import 'package:example/pages/list_view_page.dart';
import 'package:example/widgets/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_paging/fl_paging.dart' as paging;

class SliverAppBarListViewPage extends StatefulWidget {
  static const ROUTE_NAME = 'SliverAppBarListViewPage';
  @override
  _SliverAppBarListViewPageState createState() => _SliverAppBarListViewPageState();
}

class _SliverAppBarListViewPageState extends State<SliverAppBarListViewPage> {
  static const TAG = 'SliverAppBarListViewPage';
  late ListViewDataSource dataSource;
  @override
  void initState() {
    super.initState();
    dataSource = ListViewDataSource(NoteRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                expandedHeight: 250,
                collapsedHeight: kToolbarHeight+1,
                title: Text('Sliver Appbar'),
                snap: false,
                floating: false,
                leading: Container(
                  child: CircleAvatar(
                    child: Icon(Icons.person_outline),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                ),
              )
            ];
          },
          body: paging.PagingListView<Note>(
            padding: EdgeInsets.all(16),

            itemBuilder: (context, data, child) {
              return NoteWidget(data);
            },
            pageDataSource: dataSource,
          )
      ),
    );
  }
}
