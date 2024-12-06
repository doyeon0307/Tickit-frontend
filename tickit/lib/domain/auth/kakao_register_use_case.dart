import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/auth/auth_repository.dart';
import 'package:tickit/data/auth/entity/auth_tokens_entity.dart';

final kakaoRegisterUseCaseProvider = Provider.autoDispose(
      (ref) => KakaoRegisterUseCase(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class KakaoRegisterUseCase {
  final AuthRepository _authRepository;

  const KakaoRegisterUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<UseCaseResult<AuthTokensEntity>> call({
    required String accessToken,
    required String idToken,
    required String refreshToken,
  }) async {
    final RepositoryResult<AuthTokensEntity> repositoryResult =
    await _authRepository.kakaoRegister(
      accessToken: accessToken,
      idToken: idToken,
      refreshToken: refreshToken,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<AuthTokensEntity>() => SuccessUseCaseResult(
        data: repositoryResult.data,
      ),
      FailureRepositoryResult<AuthTokensEntity>() => FailureUseCaseResult(
        message: repositoryResult.messages?.first ?? '',
        statusCode: repositoryResult.statusCode,
      )
    };
  }
}
