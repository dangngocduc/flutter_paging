class IndexDataSource {
  static const TAG = 'IndexDataSource';
  final int pageSize;
  final int initIndex;

  IndexDataSource({this.pageSize = 20, this.initIndex = 0});
}

class LoadParamsIndex {
  int currentIndex;
  int pageSize;

  LoadParamsIndex(this.currentIndex, this.pageSize);
}
