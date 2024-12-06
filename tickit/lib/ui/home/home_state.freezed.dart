// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  LoadingStatus get initLoading => throw _privateConstructorUsedError;
  List<TicketPreviewEntity> get previews => throw _privateConstructorUsedError;
  String get errorMsg => throw _privateConstructorUsedError;
  String get successMsg => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {LoadingStatus initLoading,
      List<TicketPreviewEntity> previews,
      String errorMsg,
      String successMsg});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initLoading = null,
    Object? previews = null,
    Object? errorMsg = null,
    Object? successMsg = null,
  }) {
    return _then(_value.copyWith(
      initLoading: null == initLoading
          ? _value.initLoading
          : initLoading // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      previews: null == previews
          ? _value.previews
          : previews // ignore: cast_nullable_to_non_nullable
              as List<TicketPreviewEntity>,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      successMsg: null == successMsg
          ? _value.successMsg
          : successMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadingStatus initLoading,
      List<TicketPreviewEntity> previews,
      String errorMsg,
      String successMsg});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initLoading = null,
    Object? previews = null,
    Object? errorMsg = null,
    Object? successMsg = null,
  }) {
    return _then(_$HomeStateImpl(
      initLoading: null == initLoading
          ? _value.initLoading
          : initLoading // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      previews: null == previews
          ? _value._previews
          : previews // ignore: cast_nullable_to_non_nullable
              as List<TicketPreviewEntity>,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      successMsg: null == successMsg
          ? _value.successMsg
          : successMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  _$HomeStateImpl(
      {this.initLoading = LoadingStatus.none,
      final List<TicketPreviewEntity> previews = const [],
      this.errorMsg = "",
      this.successMsg = ""})
      : _previews = previews;

  @override
  @JsonKey()
  final LoadingStatus initLoading;
  final List<TicketPreviewEntity> _previews;
  @override
  @JsonKey()
  List<TicketPreviewEntity> get previews {
    if (_previews is EqualUnmodifiableListView) return _previews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previews);
  }

  @override
  @JsonKey()
  final String errorMsg;
  @override
  @JsonKey()
  final String successMsg;

  @override
  String toString() {
    return 'HomeState(initLoading: $initLoading, previews: $previews, errorMsg: $errorMsg, successMsg: $successMsg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.initLoading, initLoading) ||
                other.initLoading == initLoading) &&
            const DeepCollectionEquality().equals(other._previews, _previews) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg) &&
            (identical(other.successMsg, successMsg) ||
                other.successMsg == successMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initLoading,
      const DeepCollectionEquality().hash(_previews), errorMsg, successMsg);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
      {final LoadingStatus initLoading,
      final List<TicketPreviewEntity> previews,
      final String errorMsg,
      final String successMsg}) = _$HomeStateImpl;

  @override
  LoadingStatus get initLoading;
  @override
  List<TicketPreviewEntity> get previews;
  @override
  String get errorMsg;
  @override
  String get successMsg;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
