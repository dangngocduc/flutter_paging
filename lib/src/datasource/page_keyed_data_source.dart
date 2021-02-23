import 'dart:developer' as developer;

import 'package:tuple/tuple.dart';

import 'data_source.dart';
import 'package:async/async.dart';
/// Key is page index, Value is type Data
abstract class PageKeyedDataSource<Key, Value> extends DataSource<Value> {
  static const TAG = 'PageKeyedDataSource';

  /// Current Key of page loaded success
  Key currentKey;

  /// true if data source is loaded all data
  /// false if data source is not loaded all data
  bool isEndList;

  CancelableOperation<Tuple2<List<Value>, Key>> _cancelableOperation;

  /// Load for first time
  Future<Tuple2<List<Value>, Key>> loadInitial();

  /// Load for page after page has key is param
  Future<Tuple2<List<Value>, Key>> loadPageAfter(Key params);

  @override
  Future<List<Value>> loadPage({bool isRefresh = false}) async {
    if ((currentKey == null) || (isRefresh == true)) {
      if (_cancelableOperation != null && !_cancelableOperation.isCompleted)
        _cancelableOperation.cancel();
      _cancelableOperation = CancelableOperation.fromFuture(loadInitial());
      final results = await _cancelableOperation.valueOrCancellation();
      currentKey = results?.item2;
      return results?.item1;
    } else {
      _cancelableOperation =  CancelableOperation.fromFuture(loadPageAfter(currentKey));
      final results = await _cancelableOperation.valueOrCancellation();
      currentKey = results?.item2;
      return results?.item1;
    }
  }
}
