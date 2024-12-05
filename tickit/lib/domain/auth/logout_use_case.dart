import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/auth/auth_repository.dart';

final logoutUseCaseProvider = Provider.autoDispose(
      (ref) => LogoutUseCase(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class LogoutUseCase {
  final AuthRepository _authRepository;

  const LogoutUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<UseCaseResult<String>> call() async {
    final RepositoryResult<String> repositoryResult =
    await _authRepository.logout();

    return switch (repositoryResult) {
      SuccessRepositoryResult<String>() => SuccessUseCaseResult(
        data: repositoryResult.data,
      ),
      FailureRepositoryResult<String>() => FailureUseCaseResult(
        message: repositoryResult.messages?.first ?? '',
        statusCode: repositoryResult.statusCode,
      )
    };
  }
}
