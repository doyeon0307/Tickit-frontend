// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_tokens_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthTokensEntity _$AuthTokensEntityFromJson(Map<String, dynamic> json) {
  return _AuthTokensEntity.fromJson(json);
}

/// @nodoc
mixin _$AuthTokensEntity {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthTokensEntityCopyWith<AuthTokensEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthTokensEntityCopyWith<$Res> {
  factory $AuthTokensEntityCopyWith(
          AuthTokensEntity value, $Res Function(AuthTokensEntity) then) =
      _$AuthTokensEntityCopyWithImpl<$Res, AuthTokensEntity>;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$AuthTokensEntityCopyWithImpl<$Res, $Val extends AuthTokensEntity>
    implements $AuthTokensEntityCopyWith<$Res> {
  _$AuthTokensEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthTokensEntityImplCopyWith<$Res>
    implements $AuthTokensEntityCopyWith<$Res> {
  factory _$$AuthTokensEntityImplCopyWith(_$AuthTokensEntityImpl value,
          $Res Function(_$AuthTokensEntityImpl) then) =
      __$$AuthTokensEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$$AuthTokensEntityImplCopyWithImpl<$Res>
    extends _$AuthTokensEntityCopyWithImpl<$Res, _$AuthTokensEntityImpl>
    implements _$$AuthTokensEntityImplCopyWith<$Res> {
  __$$AuthTokensEntityImplCopyWithImpl(_$AuthTokensEntityImpl _value,
      $Res Function(_$AuthTokensEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_$AuthTokensEntityImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthTokensEntityImpl
    with DiagnosticableTreeMixin
    implements _AuthTokensEntity {
  const _$AuthTokensEntityImpl(
      {required this.accessToken, required this.refreshToken});

  factory _$AuthTokensEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthTokensEntityImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthTokensEntity(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthTokensEntity'))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('refreshToken', refreshToken));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthTokensEntityImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthTokensEntityImplCopyWith<_$AuthTokensEntityImpl> get copyWith =>
      __$$AuthTokensEntityImplCopyWithImpl<_$AuthTokensEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthTokensEntityImplToJson(
      this,
    );
  }
}

abstract class _AuthTokensEntity implements AuthTokensEntity {
  const factory _AuthTokensEntity(
      {required final String accessToken,
      required final String refreshToken}) = _$AuthTokensEntityImpl;

  factory _AuthTokensEntity.fromJson(Map<String, dynamic> json) =
      _$AuthTokensEntityImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$AuthTokensEntityImplCopyWith<_$AuthTokensEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
