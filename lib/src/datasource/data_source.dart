abstract class DataSource<Value> {
  /// Request load page for Data Source
  Future<List<Value>> loadPage({bool isRefresh});

  bool get isEndList;
}