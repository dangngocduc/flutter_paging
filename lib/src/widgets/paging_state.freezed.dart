// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'paging_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PagingStateTearOff {
  const _$PagingStateTearOff();

  PagingStateData<D> call<D>(List<D> datas, bool isLoadMore, bool isEndList) {
    return PagingStateData<D>(
      datas,
      isLoadMore,
      isEndList,
    );
  }

  PagingStateLoading<D> loading<D>() {
    return PagingStateLoading<D>();
  }

  PagingStateError<D> error<D>(dynamic error) {
    return PagingStateError<D>(
      error,
    );
  }
}

/// @nodoc
const $PagingState = _$PagingStateTearOff();

/// @nodoc
mixin _$PagingState<D> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<D> datas, bool isLoadMore, bool isEndList) $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<D> datas, bool isLoadMore, bool isEndList)?
        $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PagingStateData<D> value) $default, {
    required TResult Function(PagingStateLoading<D> value) loading,
    required TResult Function(PagingStateError<D> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PagingStateData<D> value)? $default, {
    TResult Function(PagingStateLoading<D> value)? loading,
    TResult Function(PagingStateError<D> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingStateCopyWith<D, $Res> {
  factory $PagingStateCopyWith(
          PagingState<D> value, $Res Function(PagingState<D>) then) =
      _$PagingStateCopyWithImpl<D, $Res>;
}

/// @nodoc
class _$PagingStateCopyWithImpl<D, $Res>
    implements $PagingStateCopyWith<D, $Res> {
  _$PagingStateCopyWithImpl(this._value, this._then);

  final PagingState<D> _value;
  // ignore: unused_field
  final $Res Function(PagingState<D>) _then;
}

/// @nodoc
abstract class $PagingStateDataCopyWith<D, $Res> {
  factory $PagingStateDataCopyWith(
          PagingStateData<D> value, $Res Function(PagingStateData<D>) then) =
      _$PagingStateDataCopyWithImpl<D, $Res>;
  $Res call({List<D> datas, bool isLoadMore, bool isEndList});
}

/// @nodoc
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
    Object? datas = freezed,
    Object? isLoadMore = freezed,
    Object? isEndList = freezed,
  }) {
    return _then(PagingStateData<D>(
      datas == freezed
          ? _value.datas
          : datas // ignore: cast_nullable_to_non_nullable
              as List<D>,
      isLoadMore == freezed
          ? _value.isLoadMore
          : isLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isEndList == freezed
          ? _value.isEndList
          : isEndList // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
class _$PagingStateData<D> implements PagingStateData<D> {
  const _$PagingStateData(this.datas, this.isLoadMore, this.isEndList);

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

  @JsonKey(ignore: true)
  @override
  $PagingStateDataCopyWith<D, PagingStateData<D>> get copyWith =>
      _$PagingStateDataCopyWithImpl<D, PagingStateData<D>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<D> datas, bool isLoadMore, bool isEndList) $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return $default(datas, isLoadMore, isEndList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<D> datas, bool isLoadMore, bool isEndList)?
        $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(datas, isLoadMore, isEndList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PagingStateData<D> value) $default, {
    required TResult Function(PagingStateLoading<D> value) loading,
    required TResult Function(PagingStateError<D> value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PagingStateData<D> value)? $default, {
    TResult Function(PagingStateLoading<D> value)? loading,
    TResult Function(PagingStateError<D> value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class PagingStateData<D> implements PagingState<D> {
  const factory PagingStateData(
      List<D> datas, bool isLoadMore, bool isEndList) = _$PagingStateData<D>;

  List<D> get datas => throw _privateConstructorUsedError;
  bool get isLoadMore => throw _privateConstructorUsedError;
  bool get isEndList => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PagingStateDataCopyWith<D, PagingStateData<D>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingStateLoadingCopyWith<D, $Res> {
  factory $PagingStateLoadingCopyWith(PagingStateLoading<D> value,
          $Res Function(PagingStateLoading<D>) then) =
      _$PagingStateLoadingCopyWithImpl<D, $Res>;
}

/// @nodoc
class _$PagingStateLoadingCopyWithImpl<D, $Res>
    extends _$PagingStateCopyWithImpl<D, $Res>
    implements $PagingStateLoadingCopyWith<D, $Res> {
  _$PagingStateLoadingCopyWithImpl(
      PagingStateLoading<D> _value, $Res Function(PagingStateLoading<D>) _then)
      : super(_value, (v) => _then(v as PagingStateLoading<D>));

  @override
  PagingStateLoading<D> get _value => super._value as PagingStateLoading<D>;
}

/// @nodoc
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
  TResult when<TResult extends Object?>(
    TResult Function(List<D> datas, bool isLoadMore, bool isEndList) $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<D> datas, bool isLoadMore, bool isEndList)?
        $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PagingStateData<D> value) $default, {
    required TResult Function(PagingStateLoading<D> value) loading,
    required TResult Function(PagingStateError<D> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PagingStateData<D> value)? $default, {
    TResult Function(PagingStateLoading<D> value)? loading,
    TResult Function(PagingStateError<D> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PagingStateLoading<D> implements PagingState<D> {
  const factory PagingStateLoading() = _$PagingStateLoading<D>;
}

/// @nodoc
abstract class $PagingStateErrorCopyWith<D, $Res> {
  factory $PagingStateErrorCopyWith(
          PagingStateError<D> value, $Res Function(PagingStateError<D>) then) =
      _$PagingStateErrorCopyWithImpl<D, $Res>;
  $Res call({dynamic error});
}

/// @nodoc
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
    Object? error = freezed,
  }) {
    return _then(PagingStateError<D>(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
class _$PagingStateError<D> implements PagingStateError<D> {
  const _$PagingStateError(this.error);

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

  @JsonKey(ignore: true)
  @override
  $PagingStateErrorCopyWith<D, PagingStateError<D>> get copyWith =>
      _$PagingStateErrorCopyWithImpl<D, PagingStateError<D>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<D> datas, bool isLoadMore, bool isEndList) $default, {
    required TResult Function() loading,
    required TResult Function(dynamic error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<D> datas, bool isLoadMore, bool isEndList)?
        $default, {
    TResult Function()? loading,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PagingStateData<D> value) $default, {
    required TResult Function(PagingStateLoading<D> value) loading,
    required TResult Function(PagingStateError<D> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PagingStateData<D> value)? $default, {
    TResult Function(PagingStateLoading<D> value)? loading,
    TResult Function(PagingStateError<D> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PagingStateError<D> implements PagingState<D> {
  const factory PagingStateError(dynamic error) = _$PagingStateError<D>;

  dynamic get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PagingStateErrorCopyWith<D, PagingStateError<D>> get copyWith =>
      throw _privateConstructorUsedError;
}
