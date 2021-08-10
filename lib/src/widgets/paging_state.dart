import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_state.freezed.dart';

@freezed
abstract class PagingState<D> with _$PagingState<D> {
  const factory PagingState(List<D> datas, bool isLoadMore, bool isEndList) =
      PagingStateData;

  const factory PagingState.loading() = PagingStateLoading;

  const factory PagingState.error(dynamic error) = PagingStateError;
}
