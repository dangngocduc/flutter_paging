# 1.0.0

- feat: `ListView`, 'GridView' with `PageKeyedDataSource`

# 1.0.1

-docs: Update example

# 1.0.2

-docs: Update example

# 1.0.3

-docs: Update format

# 1.0.4

-docs: Update format

# 1.0.5

-refactor: refactor list_view code.

# 1.0.6

-refactor: refactor list_view code.

# 1.0.7

-refactor: refactor list_view code.

# 1.0.8

-refactor: fix bug empty config list_view.

# 1.0.9

-refactor: fix bug loadmore list_view.

# 1.0.10

-refactor: feat: add handle errorWhenLoadMore.

# 1.0.11

-refactor: feat: add handle retry when errror.

# 1.0.12

-refactor: feat: add handle retry when errror.

# 1.0.13

-refactor: feat: get state of ListView

# 1.0.14

-refactor: fixbug: fixbug loadmore

# 1.0.15

-refactor: feat: add index for itembuilder and separatorBuilder

# 1.0.16

-refactor: feat add GridView builder

# 1.0.17

-refactor: feat handle retry GridView

# 1.0.18

-fixbug: fix bug loading when retry on GridView

# 1.0.19

-feature: reize item gridview

# 1.0.20

-fixbug: fix bug duplicate when loadmore +  pull to refresh

# 1.0.21

-feat: update index gridView

# 2.0.0

- support null safety

# 2.0.1

- feat: support auto detect end of list.
- feat: support default empty for list.

**BREAKING**:

- refactor: rename `ListView` to `PagingListView`
- refactor: rename `GridView` to `PagingGridView`
- refactor: added params `pageSize` for method `loadInitial` in `PageKeyedDataSource`
- refactor: added params `pageSize` for method `loadPageAfter` in `PageKeyedDataSource`

# 2.0.2

- feat: support enable pull to refresh

# 2.1.0

- feat: support style for pull to refresh (Material|Cupertino)

# 2.1.1

- fix: issue pull to refresh with short list.

# 2.1.2

- feat: support ScrollViewKeyboardDismissBehavior on PagingGridView.

# 2.2.0

- feat: support ScrollViewKeyboardDismissBehavior on PagingGridView.
