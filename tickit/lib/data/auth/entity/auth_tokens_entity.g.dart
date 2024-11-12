// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_tokens_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthTokensEntityImpl _$$AuthTokensEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthTokensEntityImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$AuthTokensEntityImplToJson(
        _$AuthTokensEntityImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
