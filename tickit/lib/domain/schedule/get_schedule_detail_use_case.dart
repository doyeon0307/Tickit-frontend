import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/schedule/entity/schedule_entity.dart';
import 'package:tickit/data/schedule/schedule_repository.dart';
import 'package:tickit/domain/schedule/model/schedule_model.dart';

final getScheduleDetailUseCaseProvider = Provider.autoDispose(
  (ref) => GetScheduleDetailUseCase(
    scheduleRepository: ref.read(scheduleRepositoryProvider),
  ),
);

class GetScheduleDetailUseCase {
  final ScheduleRepository _scheduleRepository;

  const GetScheduleDetailUseCase({
    required ScheduleRepository scheduleRepository,
  }) : _scheduleRepository = scheduleRepository;

  Future<UseCaseResult<ScheduleModel>> call({
    required String id,
  }) async {
    final RepositoryResult<ScheduleEntity> repositoryResult =
        await _scheduleRepository.getScheduleDetail(
      id: id,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<ScheduleEntity>() => SuccessUseCaseResult(
          data: ScheduleModel.fromEntity(entity: repositoryResult.data),
        ),
      FailureRepositoryResult<ScheduleEntity>() => FailureUseCaseResult(
          message: repositoryResult.messages?.first ?? "",
          statusCode: repositoryResult.statusCode,
        )
    };
  }
}
