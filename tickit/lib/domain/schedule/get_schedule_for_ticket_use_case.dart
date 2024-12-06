import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/schedule/entity/schedule_for_ticket_entity.dart';
import 'package:tickit/data/schedule/schedule_repository.dart';
import 'package:tickit/domain/schedule/model/schedule_for_ticket_model.dart';

final getScheduleForTicketUseCaseProvider = Provider.autoDispose(
  (ref) => GetScheduleForTicketUseCase(
    scheduleRepository: ref.read(scheduleRepositoryProvider),
  ),
);

class GetScheduleForTicketUseCase {
  final ScheduleRepository _scheduleRepository;

  const GetScheduleForTicketUseCase({
    required ScheduleRepository scheduleRepository,
  }) : _scheduleRepository = scheduleRepository;

  Future<UseCaseResult<List<ScheduleForTicketModel>>> call() async {
    final RepositoryResult<List<ScheduleForTicketEntity>> repositoryResult = await _scheduleRepository.getScheduleForTicket();

    return switch (repositoryResult) {
      SuccessRepositoryResult<List<ScheduleForTicketEntity>>() => SuccessUseCaseResult(
          data: repositoryResult.data
              .map(
                (entity) => ScheduleForTicketModel.fromEntity(
                  entity: entity,
                ),
              )
              .toList(),
        ),
      FailureRepositoryResult<List<ScheduleForTicketEntity>>() => FailureUseCaseResult(
          message: repositoryResult.messages?.first ?? "",
          statusCode: repositoryResult.statusCode,
        )
    };
  }
}
