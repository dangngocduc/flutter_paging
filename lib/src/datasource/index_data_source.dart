import 'dart:developer' as developer;

class IndexDataSource {
  static const TAG = 'IndexDataSource';
  final int pageSize;
  final int initIndex;

  IndexDataSource({this.pageSize, this.initIndex =  20});

}

class LoadParamsIndex {
  int currentIndex;
  int pageSize;

  LoadParamsIndex(this.currentIndex, this.pageSize);
}