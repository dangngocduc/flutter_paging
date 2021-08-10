import 'package:tuple/tuple.dart';

import 'data_source.dart';
import 'package:async/async.dart';

/// K is type of page index, D is type of data
abstract class PageKeyedDataSource<K, D> extends DataSource<D> {
  static const TAG = 'PageKeyedDataSource';

  /// Current Key of page loaded success
  K? currentKey;

  final bool autoDetectEndList;

  final int pageSize;

  /// true if data source is loaded all data
  /// false if data source is not loaded all data
  bool isEndList;

  CancelableOperation<Tuple2<List<D>, K>>? _cancelableOperation;

  PageKeyedDataSource({
    this.isEndList = false,
    this.autoDetectEndList = true,
    this.pageSize = kDefaultPageSize});

  /// Load for first time
  /// Item1(List<D>) of Tuple2 is List of Data
  /// Item2(K) of Tuple2 is next page when load more
  Future<Tuple2<List<D>, K>> loadInitial(int pageSize);

  /// Load for page after page has key is param
  /// Item1(List<D>) of Tuple2 is List of Data
  /// Item2(K) of Tuple2 is next page when load more
  Future<Tuple2<List<D>, K>> loadPageAfter(K params, int pageSize);

  @override
  Future<List<D>> loadPage({bool isRefresh = false}) async {
    if ((currentKey == null) || isRefresh) {
      if (_cancelableOperation != null && !_cancelableOperation!.isCompleted)
        _cancelableOperation!.cancel();
      _cancelableOperation = CancelableOperation.fromFuture(loadInitial(pageSize));
      final results = await _cancelableOperation!.valueOrCancellation();
      if (autoDetectEndList) {
        isEndList = ((results?.item1.length ?? 0) < pageSize);
      }
      currentKey = results?.item2;
      return results?.item1 ?? [];
    } else {
      _cancelableOperation =  CancelableOperation.fromFuture(loadPageAfter(currentKey!, pageSize));
      final results = await _cancelableOperation!.valueOrCancellation();
      currentKey = results?.item2;
      if (autoDetectEndList) {
        isEndList = ((results?.item1.length ?? 0) < pageSize);
      }
      return results?.item1 ?? [];
    }
  }
}
