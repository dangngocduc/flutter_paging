# Paging

<p align="center">

  <a href="https://pub.dartlang.org/packages/fl_paging">
    <img alt="Pub Package" src="https://img.shields.io/pub/v/fl_paging.svg">
  </a>
  <br/>
  <a href="https://github.com/dangngocduc/flutter_paging">
    <img src="https://img.shields.io/github/stars/dangngocduc/flutter_paging.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on GitHub">
  </a>
  <a href="https://github.com/tenhobi/effective_dart">
    <img alt="style: effective dart" src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img alt="MIT License" src="https://img.shields.io/badge/License-MIT-blue.svg">
  </a>
</p>

---
A Flutter package that supports pagination(load infinite) for ListView, GridView

### Demo

|   |   |   |
|---|---|---|
|![](./demo/list_view2.gif) |![](./demo/grid_view.gif) |![](./demo/sliver_demo.gif) |


### DataSource
#### PageKeyedDataSource

To create a `PagingListView` or `PagingGridView` you will need create class which extended from `PageKeyedDataSource`.

When extended from `PageKeyedDataSource`, you will need `override` 2 methods is 'loadInitial' and 'loadPageAfter`.
Output of those function is a Tuple2 with item1 is `List<D>` is List of data, end item2 is next page index.extended

Example: if your list start with page index is 0.
-> on loadInitial output is Tuple2([...], 1) 1 is next page when load more item.

Example:

```
class ListViewDataSource extends paging.PageKeyedDataSource<int, Note> {
  NoteRepository noteRepository;

  ListViewDataSource(this.noteRepository);

  @override
  Future<Tuple2<List<Note>, int>> loadInitial(int pageSize) async {
    return Tuple2(await noteRepository.getNotes(0), 1);
  }

  @override
  Future<Tuple2<List<Note>, int>> loadPageAfter(int params, int pageSize) async {
    return Tuple2(await noteRepository.getNotes(params), params + 1);
  }
}
```

### Display on UI

To display on UI, currently you can use `PagingListView` or `PagingGridView`.

Example:
```   ListViewDataSource dataSource = ListViewDataSource(NoteRepository());

      PagingListView<Note>(
        itemBuilder: (context, data, child) => NoteWidget(data),
        pageDataSource: dataSource,
      ),

```


