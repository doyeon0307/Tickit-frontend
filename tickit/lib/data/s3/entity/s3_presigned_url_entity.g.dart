// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's3_presigned_url_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

S3PresignedUrlEntity _$S3PresignedUrlEntityFromJson(
        Map<String, dynamic> json) =>
    S3PresignedUrlEntity(
      url: json['url'] as String,
      key: json['key'] as String,
    );

Map<String, dynamic> _$S3PresignedUrlEntityToJson(
        S3PresignedUrlEntity instance) =>
    <String, dynamic>{
      'url': instance.url,
      'key': instance.key,
    };
