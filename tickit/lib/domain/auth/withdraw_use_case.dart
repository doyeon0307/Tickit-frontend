import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/auth/auth_repository.dart';

final withdrawUseCaseProvider = Provider.autoDispose(
      (ref) => WithdrawUseCase(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class WithdrawUseCase {
  final AuthRepository _authRepository;

  const WithdrawUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<UseCaseResult<String>> call() async {
    final RepositoryResult<String> repositoryResult =
    await _authRepository.withdraw();

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
