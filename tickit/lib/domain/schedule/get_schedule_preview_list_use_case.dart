import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/schedule/entity/schedule_preview_entity.dart';
import 'package:tickit/data/schedule/schedule_repository.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';

final getSchedulePreviewListUseCaseProvider = Provider.autoDispose(
  (ref) => GetSchedulePreviewListUseCase(
    scheduleRepository: ref.read(scheduleRepositoryProvider),
  ),
);

class GetSchedulePreviewListUseCase {
  final ScheduleRepository _scheduleRepository;

  const GetSchedulePreviewListUseCase({
    required ScheduleRepository scheduleRepository,
  }) : _scheduleRepository = scheduleRepository;

  Future<UseCaseResult<List<SchedulePreviewModel>>> call({
    required String startDate,
    required String endDate,
  }) async {
    final RepositoryResult<List<SchedulePreviewEntity>> repositoryResult =
        await _scheduleRepository.getScheduleList(
      startDate: startDate,
      endDate: endDate,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<List<SchedulePreviewEntity>>() =>
        SuccessUseCaseResult(
          data: repositoryResult.data
              .map(
                (entity) => SchedulePreviewModel.fromEntity(
                  entity: entity,
                ),
              )
              .toList(),
        ),
      FailureRepositoryResult<List<SchedulePreviewEntity>>() =>
        FailureUseCaseResult(
          message: repositoryResult.messages?.first ?? "",
          statusCode: repositoryResult.statusCode,
        )
    };
  }
}
