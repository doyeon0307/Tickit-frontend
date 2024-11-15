import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/ticket/entity/ticket_preview_entity.dart';
import 'package:tickit/data/ticket/ticket_repository.dart';

final getTicketPreviewsUseCaseProvider = Provider.autoDispose(
  (ref) => GetTicketPreviewsUseCase(
    ticketRepository: ref.watch(ticketRepositoryProvider),
  ),
);

class GetTicketPreviewsUseCase {
  final TicketRepository _ticketRepository;

  const GetTicketPreviewsUseCase({
    required TicketRepository ticketRepository,
  }) : _ticketRepository = ticketRepository;

  Future<UseCaseResult<List<TicketPreviewEntity>>> call() async {
    final RepositoryResult<List<TicketPreviewEntity>> repositoryResult =
        await _ticketRepository.getTicketPreviewList();

    return switch (repositoryResult) {
      SuccessRepositoryResult<List<TicketPreviewEntity>>() =>
        SuccessUseCaseResult(
          data: repositoryResult.data,
        ),
      FailureRepositoryResult<List<TicketPreviewEntity>>() =>
        FailureUseCaseResult(
          message: repositoryResult.messages?.first ?? '',
          statusCode: repositoryResult.statusCode,
        )
    };
  }
}
