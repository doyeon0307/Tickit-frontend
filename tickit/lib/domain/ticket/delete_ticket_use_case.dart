import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/ticket/ticket_repository.dart';

final deleteTicketUseCaseProvider = Provider.autoDispose(
  (ref) => DeleteTicketUseCase(
    ticketRepository: ref.watch(ticketRepositoryProvider),
  ),
);

class DeleteTicketUseCase {
  final TicketRepository _ticketRepository;

  const DeleteTicketUseCase({
    required TicketRepository ticketRepository,
  }) : _ticketRepository = ticketRepository;

  Future<UseCaseResult<String>> call({
    required String id,
  }) async {
    final RepositoryResult<String> repositoryResult =
        await _ticketRepository.deleteTicket(id: id);

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
