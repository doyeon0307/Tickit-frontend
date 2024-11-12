// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_kakao_tokens_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthKakaoTokensRequestBody _$AuthKakaoTokensRequestBodyFromJson(
    Map<String, dynamic> json) {
  return _AuthTokensRequestBody.fromJson(json);
}

/// @nodoc
mixin _$AuthKakaoTokensRequestBody {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get idToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthKakaoTokensRequestBodyCopyWith<AuthKakaoTokensRequestBody>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthKakaoTokensRequestBodyCopyWith<$Res> {
  factory $AuthKakaoTokensRequestBodyCopyWith(AuthKakaoTokensRequestBody value,
          $Res Function(AuthKakaoTokensRequestBody) then) =
      _$AuthKakaoTokensRequestBodyCopyWithImpl<$Res,
          AuthKakaoTokensRequestBody>;
  @useResult
  $Res call({String? accessToken, String? idToken, String? refreshToken});
}

/// @nodoc
class _$AuthKakaoTokensRequestBodyCopyWithImpl<$Res,
        $Val extends AuthKakaoTokensRequestBody>
    implements $AuthKakaoTokensRequestBodyCopyWith<$Res> {
  _$AuthKakaoTokensRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? idToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      idToken: freezed == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthTokensRequestBodyImplCopyWith<$Res>
    implements $AuthKakaoTokensRequestBodyCopyWith<$Res> {
  factory _$$AuthTokensRequestBodyImplCopyWith(
          _$AuthTokensRequestBodyImpl value,
          $Res Function(_$AuthTokensRequestBodyImpl) then) =
      __$$AuthTokensRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? accessToken, String? idToken, String? refreshToken});
}

/// @nodoc
class __$$AuthTokensRequestBodyImplCopyWithImpl<$Res>
    extends _$AuthKakaoTokensRequestBodyCopyWithImpl<$Res,
        _$AuthTokensRequestBodyImpl>
    implements _$$AuthTokensRequestBodyImplCopyWith<$Res> {
  __$$AuthTokensRequestBodyImplCopyWithImpl(_$AuthTokensRequestBodyImpl _value,
      $Res Function(_$AuthTokensRequestBodyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? idToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$AuthTokensRequestBodyImpl(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      idToken: freezed == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthTokensRequestBodyImpl
    with DiagnosticableTreeMixin
    implements _AuthTokensRequestBody {
  const _$AuthTokensRequestBodyImpl(
      {this.accessToken, this.idToken, this.refreshToken});

  factory _$AuthTokensRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthTokensRequestBodyImplFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? idToken;
  @override
  final String? refreshToken;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthKakaoTokensRequestBody(accessToken: $accessToken, idToken: $idToken, refreshToken: $refreshToken)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthKakaoTokensRequestBody'))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('idToken', idToken))
      ..add(DiagnosticsProperty('refreshToken', refreshToken));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthTokensRequestBodyImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, idToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthTokensRequestBodyImplCopyWith<_$AuthTokensRequestBodyImpl>
      get copyWith => __$$AuthTokensRequestBodyImplCopyWithImpl<
          _$AuthTokensRequestBodyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthTokensRequestBodyImplToJson(
      this,
    );
  }
}

abstract class _AuthTokensRequestBody implements AuthKakaoTokensRequestBody {
  const factory _AuthTokensRequestBody(
      {final String? accessToken,
      final String? idToken,
      final String? refreshToken}) = _$AuthTokensRequestBodyImpl;

  factory _AuthTokensRequestBody.fromJson(Map<String, dynamic> json) =
      _$AuthTokensRequestBodyImpl.fromJson;

  @override
  String? get accessToken;
  @override
  String? get idToken;
  @override
  String? get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$AuthTokensRequestBodyImplCopyWith<_$AuthTokensRequestBodyImpl>
      get copyWith => throw _privateConstructorUsedError;
}
