import 'package:fl_paging/src/datasource/data_source.dart';
import 'package:flutter/material.dart';

import 'builder.dart';

typedef ValueIndexWidgetBuilder<T> = Widget Function(
    BuildContext context, T value, int index);

abstract class BaseWidget<T> extends StatefulWidget {
  /// Signature for a function that creates a widget empty
  final WidgetBuilder? emptyBuilder;

  /// Signature for a function that creates a widget loading
  final WidgetBuilder? loadingBuilder;

  /// Signature for a function that creates a widget Error
  final ErrorBuilder? errorBuilder;

  /// Signature for a function that creates a widget for item
  final ValueIndexWidgetBuilder<T> itemBuilder;

  /// DataSource for current ScrollView [ListView - GridView]
  final DataSource<T> pageDataSource;

  /// Signature for a function that creates a widget for load more
  final WidgetBuilder? loadmoreBuilder;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  BaseWidget(
      {Key? key,
      this.emptyBuilder,
      this.loadingBuilder,
      this.errorBuilder,
      this.loadmoreBuilder,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
      required this.itemBuilder,
      required this.pageDataSource})
      : super(key: key);
}
