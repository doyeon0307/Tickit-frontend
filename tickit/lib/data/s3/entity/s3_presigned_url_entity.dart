import 'package:freezed_annotation/freezed_annotation.dart';

part 's3_presigned_url_entity.g.dart';

@JsonSerializable()
class S3PresignedUrlEntity {
  final String url;
  final String key;

  const S3PresignedUrlEntity({
    required this.url,
    required this.key,
  });
  
  factory S3PresignedUrlEntity.fromJson(Map<String, dynamic> json)
  => _$S3PresignedUrlEntityFromJson(json);
}