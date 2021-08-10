abstract class DataSource<D> {
  /// Request load page for Data Source
  Future<List<D>> loadPage({bool isRefresh});

  /// true when your list is don't have any data for next request.
  bool get isEndList;
}

const kDefaultPageSize = 20;
