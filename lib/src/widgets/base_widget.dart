import 'package:fl_paging/src/datasource/data_source.dart';
import 'package:flutter/material.dart';

import 'builder.dart';

abstract class BaseWidget<T> extends StatefulWidget {
  /// Signature for a function that creates a widget empty
  final WidgetBuilder emptyBuilder;

  /// Signature for a function that creates a widget loading
  final WidgetBuilder loadingBuilder;

  /// Signature for a function that creates a widget Error
  final ErrorBuilder errorBuilder;

  /// Signature for a function that creates a widget for item
  final ValueWidgetBuilder<T> itemBuilder;

  /// DataSource for current ScrollView [ListView - GridView]
  final DataSource<T> pageDataSource;

  BaseWidget({Key key,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    @required this.itemBuilder,
    @required this.pageDataSource}): super(key : key);
}
