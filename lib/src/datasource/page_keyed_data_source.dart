import 'dart:developer' as developer;

import 'package:tuple/tuple.dart';

import 'data_source.dart';

/// Key is page index, Value is type Data
abstract class PageKeyedDataSource<Key, Value> extends DataSource<Value> {
  static const TAG = 'PageKeyedDataSource';

  /// Current Key of page loaded success
  Key currentKey;

  /// true if data source is loaded all data
  /// false if data source is not loaded all data
  bool isEndList;

  /// Load for first time
  Future<Tuple2<List<Value>, Key>> loadInitial();

  /// Load for page after page has key is param
  Future<Tuple2<List<Value>, Key>> loadPageAfter(Key params);

  @override
  Future<List<Value>> loadPage({bool isRefresh = false}) async {
    if ((currentKey == null) || (isRefresh == true)) {
      final results = await loadInitial();
      if (isRefresh) isEndList = false;
      currentKey = results.item2;
      developer.log('loadPage done currentKey ${this.hashCode} $currentKey',
          name: TAG);
      return results.item1;
    } else {
      developer.log('loadPage currentKey ${this.hashCode} $currentKey',
          name: TAG);
      final results = await loadPageAfter(currentKey);
      currentKey = results.item2;
      developer.log('loadPage done currentKey ${this.hashCode} $currentKey',
          name: TAG);
      return results.item1;
    }
  }
}
