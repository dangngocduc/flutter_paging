import 'package:example/pages/grid_view_page.dart';
import 'package:example/pages/list_view_page.dart';
import 'package:example/pages/sliver_app_bar_list_view_page.dart';
import 'package:flutter/material.dart';

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
      home: SliverAppBarListViewPage(),
    );
  }
}
