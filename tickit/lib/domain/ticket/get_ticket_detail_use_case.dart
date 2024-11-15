import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/ticket/entity/ticket_entity.dart';
import 'package:tickit/data/ticket/ticket_repository.dart';

final getTicketDetailUseCaseProvider = Provider.autoDispose(
      (ref) => GetTicketDetailUseCase(
    ticketRepository: ref.watch(ticketRepositoryProvider),
  ),
);

class GetTicketDetailUseCase {
  final TicketRepository _ticketRepository;

  const GetTicketDetailUseCase({
    required TicketRepository ticketRepository,
  }) : _ticketRepository = ticketRepository;

  Future<UseCaseResult<TicketEntity>> call({
    required String id,
  }) async {
    final RepositoryResult<TicketEntity> repositoryResult =
    await _ticketRepository.getTicketDetail(id: id);

    return switch (repositoryResult) {
      SuccessRepositoryResult<TicketEntity>() =>
          SuccessUseCaseResult(
            data: repositoryResult.data,
          ),
      FailureRepositoryResult<TicketEntity>() =>
          FailureUseCaseResult(
            message: repositoryResult.messages?.first ?? '',
            statusCode: repositoryResult.statusCode,
          )
    };
  }
}
