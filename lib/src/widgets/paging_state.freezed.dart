// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'paging_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$PagingStateTearOff {
  const _$PagingStateTearOff();

// ignore: unused_element
  PagingStateData<D> call<D>(List<D> datas, bool isLoadMore, bool isEndList) {
    return PagingStateData<D>(
      datas,
      isLoadMore,
      isEndList,
    );
  }

// ignore: unused_element
  PagingStateLoading<D> loading<D>() {
    return PagingStateLoading<D>();
  }

// ignore: unused_element
  PagingStateError<D> error<D>(dynamic error) {
    return PagingStateError<D>(
      error,
    );
  }
}

// ignore: unused_element
const $PagingState = _$PagingStateTearOff();

mixin _$PagingState<D> {
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(List<D> datas, bool isLoadMore, bool isEndList), {
    @required Result loading(),
    @required Result error(dynamic error),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(List<D> datas, bool isLoadMore, bool isEndList), {
    Result loading(),
    Result error(dynamic error),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(PagingStateData<D> value), {
    @required Result loading(PagingStateLoading<D> value),
    @required Result error(PagingStateError<D> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(PagingStateData<D> value), {
    Result loading(PagingStateLoading<D> value),
    Result error(PagingStateError<D> value),
    @required Result orElse(),
  });
}

abstract class $PagingStateCopyWith<D, $Res> {
  factory $PagingStateCopyWith(
          PagingState<D> value, $Res Function(PagingState<D>) then) =
      _$PagingStateCopyWithImpl<D, $Res>;
}

class _$PagingStateCopyWithImpl<D, $Res>
    implements $PagingStateCopyWith<D, $Res> {
  _$PagingStateCopyWithImpl(this._value, this._then);

  final PagingState<D> _value;
  // ignore: unused_field
  final $Res Function(PagingState<D>) _then;
}

abstract class $PagingStateDataCopyWith<D, $Res> {
  factory $PagingStateDataCopyWith(
          PagingStateData<D> value, $Res Function(PagingStateData<D>) then) =
      _$PagingStateDataCopyWithImpl<D, $Res>;
  $Res call({List<D> datas, bool isLoadMore, bool isEndList});
}

class _$PagingStateDataCopyWithImpl<D, $Res>
    extends _$PagingStateCopyWithImpl<D, $Res>
    implements $PagingStateDataCopyWith<D, $Res> {
  _$PagingStateDataCopyWithImpl(
      PagingStateData<D> _value, $Res Function(PagingStateData<D>) _then)
      : super(_value, (v) => _then(v as PagingStateData<D>));

  @override
  PagingStateData<D> get _value => super._value as PagingStateData<D>;

  @override
  $Res call({
    Object datas = freezed,
    Object isLoadMore = freezed,
    Object isEndList = freezed,
  }) {
    return _then(PagingStateData<D>(
      datas == freezed ? _value.datas : datas as List<D>,
      isLoadMore == freezed ? _value.isLoadMore : isLoadMore as bool,
      isEndList == freezed ? _value.isEndList : isEndList as bool,
    ));
  }
}

class _$PagingStateData<D> implements PagingStateData<D> {
  const _$PagingStateData(this.datas, this.isLoadMore, this.isEndList)
      : assert(datas != null),
        assert(isLoadMore != null),
        assert(isEndList != null);

  @override
  final List<D> datas;
  @override
  final bool isLoadMore;
  @override
  final bool isEndList;

  @override
  String toString() {
    return 'PagingState<$D>(datas: $datas, isLoadMore: $isLoadMore, isEndList: $isEndList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PagingStateData<D> &&
            (identical(other.datas, datas) ||
                const DeepCollectionEquality().equals(other.datas, datas)) &&
            (identical(other.isLoadMore, isLoadMore) ||
                const DeepCollectionEquality()
                    .equals(other.isLoadMore, isLoadMore)) &&
            (identical(other.isEndList, isEndList) ||
                const DeepCollectionEquality()
                    .equals(other.isEndList, isEndList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(datas) ^
      const DeepCollectionEquality().hash(isLoadMore) ^
      const DeepCollectionEquality().hash(isEndList);

  @override
  $PagingStateDataCopyWith<D, PagingStateData<D>> get copyWith =>
      _$PagingStateDataCopyWithImpl<D, PagingStateData<D>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(List<D> datas, bool isLoadMore, bool isEndList), {
    @required Result loading(),
    @required Result error(dynamic error),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    return $default(datas, isLoadMore, isEndList);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(List<D> datas, bool isLoadMore, bool isEndList), {
    Result loading(),
    Result error(dynamic error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(datas, isLoadMore, isEndList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(PagingStateData<D> value), {
    @required Result loading(PagingStateLoading<D> value),
    @required Result error(PagingStateError<D> value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(PagingStateData<D> value), {
    Result loading(PagingStateLoading<D> value),
    Result error(PagingStateError<D> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class PagingStateData<D> implements PagingState<D> {
  const factory PagingStateData(
      List<D> datas, bool isLoadMore, bool isEndList) = _$PagingStateData<D>;

  List<D> get datas;
  bool get isLoadMore;
  bool get isEndList;
  $PagingStateDataCopyWith<D, PagingStateData<D>> get copyWith;
}

abstract class $PagingStateLoadingCopyWith<D, $Res> {
  factory $PagingStateLoadingCopyWith(PagingStateLoading<D> value,
          $Res Function(PagingStateLoading<D>) then) =
      _$PagingStateLoadingCopyWithImpl<D, $Res>;
}

class _$PagingStateLoadingCopyWithImpl<D, $Res>
    extends _$PagingStateCopyWithImpl<D, $Res>
    implements $PagingStateLoadingCopyWith<D, $Res> {
  _$PagingStateLoadingCopyWithImpl(
      PagingStateLoading<D> _value, $Res Function(PagingStateLoading<D>) _then)
      : super(_value, (v) => _then(v as PagingStateLoading<D>));

  @override
  PagingStateLoading<D> get _value => super._value as PagingStateLoading<D>;
}

class _$PagingStateLoading<D> implements PagingStateLoading<D> {
  const _$PagingStateLoading();

  @override
  String toString() {
    return 'PagingState<$D>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is PagingStateLoading<D>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(List<D> datas, bool isLoadMore, bool isEndList), {
    @required Result loading(),
    @required Result error(dynamic error),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(List<D> datas, bool isLoadMore, bool isEndList), {
    Result loading(),
    Result error(dynamic error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(PagingStateData<D> value), {
    @required Result loading(PagingStateLoading<D> value),
    @required Result error(PagingStateError<D> value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(PagingStateData<D> value), {
    Result loading(PagingStateLoading<D> value),
    Result error(PagingStateError<D> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PagingStateLoading<D> implements PagingState<D> {
  const factory PagingStateLoading() = _$PagingStateLoading<D>;
}

abstract class $PagingStateErrorCopyWith<D, $Res> {
  factory $PagingStateErrorCopyWith(
          PagingStateError<D> value, $Res Function(PagingStateError<D>) then) =
      _$PagingStateErrorCopyWithImpl<D, $Res>;
  $Res call({dynamic error});
}

class _$PagingStateErrorCopyWithImpl<D, $Res>
    extends _$PagingStateCopyWithImpl<D, $Res>
    implements $PagingStateErrorCopyWith<D, $Res> {
  _$PagingStateErrorCopyWithImpl(
      PagingStateError<D> _value, $Res Function(PagingStateError<D>) _then)
      : super(_value, (v) => _then(v as PagingStateError<D>));

  @override
  PagingStateError<D> get _value => super._value as PagingStateError<D>;

  @override
  $Res call({
    Object error = freezed,
  }) {
    return _then(PagingStateError<D>(
      error == freezed ? _value.error : error as dynamic,
    ));
  }
}

class _$PagingStateError<D> implements PagingStateError<D> {
  const _$PagingStateError(this.error) : assert(error != null);

  @override
  final dynamic error;

  @override
  String toString() {
    return 'PagingState<$D>.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PagingStateError<D> &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @override
  $PagingStateErrorCopyWith<D, PagingStateError<D>> get copyWith =>
      _$PagingStateErrorCopyWithImpl<D, PagingStateError<D>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(List<D> datas, bool isLoadMore, bool isEndList), {
    @required Result loading(),
    @required Result error(dynamic error),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(List<D> datas, bool isLoadMore, bool isEndList), {
    Result loading(),
    Result error(dynamic error),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(PagingStateData<D> value), {
    @required Result loading(PagingStateLoading<D> value),
    @required Result error(PagingStateError<D> value),
  }) {
    assert($default != null);
    assert(loading != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(PagingStateData<D> value), {
    Result loading(PagingStateLoading<D> value),
    Result error(PagingStateError<D> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PagingStateError<D> implements PagingState<D> {
  const factory PagingStateError(dynamic error) = _$PagingStateError<D>;

  dynamic get error;
  $PagingStateErrorCopyWith<D, PagingStateError<D>> get copyWith;
}
