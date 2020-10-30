import 'dart:developer' as developer;

import 'package:paging/src/datasource/data_source.dart';
import 'package:tuple/tuple.dart';
/// Key is page index
abstract class PageKeyedDataSource<Key, Value> extends DataSource<Value> {
  static const TAG = 'PageKeyedDataSource';

  Key currentKey;

  Future<Tuple2<List<Value>, Key>> loadInitial();

  Future<Tuple2<List<Value>, Key>> loadPageAfter(Key params);

  @override
  Future<List<Value>> loadPage({bool isRefresh}) async {
    if (currentKey == null || isRefresh == true) {
      final results = await loadInitial();
      currentKey = results.item2;
      return results.item1;
    } else {
      final results = await loadPageAfter(currentKey);
      currentKey = results.item2;
      return results.item1;
    }
  }
}


