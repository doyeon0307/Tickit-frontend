import 'package:tickit/data/s3/entity/s3_presigned_url_entity.dart';

class S3UrlModel {
  final String uploadUrl;
  final String imageUrl;

  const S3UrlModel({
    required this.uploadUrl,
    required this.imageUrl,
  });

  factory S3UrlModel.fromEntity({
    required S3PresignedUrlEntity entity,
  }) {
    return S3UrlModel(
      uploadUrl: entity.url,
      imageUrl: "https://tickit-s3-bucket.s3.us-east-1.amazonaws.com/${entity.key}",
    );
  }
}
