import 'package:flutter/material.dart';
import 'package:paging/src/datasource/data_source.dart';

import 'builder.dart';

abstract class BaseWidget<T> extends StatefulWidget {
  final WidgetBuilder emptyBuilder;

  final WidgetBuilder loadingBuilder;

  final ErrorBuilder errorBuilder;

  final ValueWidgetBuilder<T> itemBuilder;

  final DataSource<T> pageDataSource;

  BaseWidget({Key key,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    @required this.itemBuilder,
    @required this.pageDataSource}): super(key : key);
}
