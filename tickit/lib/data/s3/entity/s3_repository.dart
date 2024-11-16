import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/data/s3/entity/s3_presigned_url_entity.dart';
import 'package:tickit/data/s3/s3_remote_data_source.dart';

final s3RepositoryProvider = Provider(
  (ref) => S3Repository(
    dataSource: ref.watch(s3RemoteDateSourceProvider),
  ),
);

class S3Repository extends Repository {
  final S3RemoteDataSource _dataSource;

  const S3Repository({
    required S3RemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  Future<RepositoryResult<S3PresignedUrlEntity>> getPresignedUrl() async {
    final resp = await _dataSource.getS3PresignedUrl();
    try {
      if (resp.data != null) {
        return SuccessRepositoryResult<S3PresignedUrlEntity>(data: resp.data!);
      } else {
        return FailureRepositoryResult<S3PresignedUrlEntity>(
          statusCode: resp.code,
          messages: [resp.message],
        );
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] as String? ?? "unknownError".tr();

      return FailureRepositoryResult<S3PresignedUrlEntity>(
        error: e,
        messages: [errorMessage],
        statusCode: e.response?.statusCode,
      );
    }
  }
}
