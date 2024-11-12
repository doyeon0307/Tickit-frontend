// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_kakao_tokens_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthKakaoTokensRequestBody _$AuthKakaoTokensRequestBodyFromJson(
        Map<String, dynamic> json) =>
    AuthKakaoTokensRequestBody(
      accessToken: json['accessToken'] as String,
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$AuthKakaoTokensRequestBodyToJson(
        AuthKakaoTokensRequestBody instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
    };
