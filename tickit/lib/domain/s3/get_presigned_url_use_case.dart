import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/s3/entity/s3_presigned_url_entity.dart';
import 'package:tickit/data/s3/s3_repository.dart';
import 'package:tickit/domain/s3/model/s3_url_model.dart';

final getPresignedUrlUseCaseProvider = Provider.autoDispose(
  (ref) => GetPresignedUrlUseCase(
    s3repository: ref.watch(s3RepositoryProvider),
  ),
);

class GetPresignedUrlUseCase {
  final S3Repository _s3repository;

  const GetPresignedUrlUseCase({
    required S3Repository s3repository,
  }) : _s3repository = s3repository;

  Future<UseCaseResult<S3UrlModel>> call() async {
    final RepositoryResult<S3PresignedUrlEntity> repositoryResult =
        await _s3repository.getPresignedUrl();

    return switch (repositoryResult) {
      SuccessRepositoryResult<S3PresignedUrlEntity>() =>
        SuccessUseCaseResult<S3UrlModel>(
          data: S3UrlModel.fromEntity(entity: repositoryResult.data),
        ),
      FailureRepositoryResult<S3PresignedUrlEntity>() => FailureUseCaseResult(
          message: repositoryResult.messages?.first ?? "",
          statusCode: repositoryResult.statusCode,
        ),
    };
  }
}
