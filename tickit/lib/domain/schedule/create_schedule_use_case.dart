import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/schedule/body/schedule_request_body.dart';
import 'package:tickit/data/schedule/entity/schedule_entity.dart';
import 'package:tickit/data/schedule/schedule_repository.dart';

final createScheduleUseCaseProvider = Provider.autoDispose(
      (ref) => CreateScheduleUseCase(
    scheduleRepository: ref.read(scheduleRepositoryProvider),
  ),
);

class CreateScheduleUseCase {
  final ScheduleRepository _scheduleRepository;

  const CreateScheduleUseCase({
    required ScheduleRepository scheduleRepository,
  }) : _scheduleRepository = scheduleRepository;

  Future<UseCaseResult<ScheduleEntity>> call({
    required ScheduleRequestBody scheduleDTO,
  }) async {
    final RepositoryResult<ScheduleEntity> repositoryResult =
    await _scheduleRepository.createSchedule(scheduleDTO: scheduleDTO);

    return switch (repositoryResult) {
      SuccessRepositoryResult<ScheduleEntity>() => SuccessUseCaseResult(
        data: repositoryResult.data,
      ),
      FailureRepositoryResult<ScheduleEntity>() => FailureUseCaseResult(
        message: repositoryResult.messages?.first ?? "",
        statusCode: repositoryResult.statusCode,
      )
    };
  }
}
