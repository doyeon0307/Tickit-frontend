// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_kakao_tokens_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthTokensRequestBodyImpl _$$AuthTokensRequestBodyImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthTokensRequestBodyImpl(
      accessToken: json['accessToken'] as String?,
      idToken: json['idToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$AuthTokensRequestBodyImplToJson(
        _$AuthTokensRequestBodyImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
    };
