// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_tokens_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokensEntity _$AuthTokensEntityFromJson(Map<String, dynamic> json) =>
    AuthTokensEntity(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$AuthTokensEntityToJson(AuthTokensEntity instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
