import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/schedule/schedule_repository.dart';

final getUserInfoUseCaseProvider = Provider.autoDispose(
  (ref) => DeleteScheduleUseCase(
    scheduleRepository: ref.read(scheduleRepositoryProvider),
  ),
);

class DeleteScheduleUseCase {
  final ScheduleRepository _scheduleRepository;

  const DeleteScheduleUseCase({
    required ScheduleRepository scheduleRepository,
  }) : _scheduleRepository = scheduleRepository;

  Future<UseCaseResult<String>> call({
    required String id,
  }) async {
    final RepositoryResult<String> repositoryResult =
        await _scheduleRepository.deleteSchedule(id: id);

    return switch (repositoryResult) {
      SuccessRepositoryResult<String>() => SuccessUseCaseResult(
          data: repositoryResult.data,
        ),
      FailureRepositoryResult<String>() => FailureUseCaseResult(
          message: repositoryResult.messages?.first ?? "",
          statusCode: repositoryResult.statusCode,
        )
    };
  }
}
