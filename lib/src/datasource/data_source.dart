import 'dart:developer' as developer;

abstract class DataSource<Value> {
  static const TAG = 'DataSource';

  Future<List<Value>> loadPage({bool isRefresh});

}