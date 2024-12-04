import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/core/util/color_utils.dart';
import 'package:tickit/data/ticket/body/ticket_request_body.dart';
import 'package:tickit/data/ticket/ticket_repository.dart';
import 'package:tickit/domain/ticket/model/ticket_field_model.dart';

final createTicketUseCaseProvider = Provider.autoDispose(
  (ref) => CreateTicketUseCase(
    ticketRepository: ref.watch(ticketRepositoryProvider),
  ),
);

class CreateTicketUseCase {
  final TicketRepository _ticketRepository;

  const CreateTicketUseCase({
    required TicketRepository ticketRepository,
  }) : _ticketRepository = ticketRepository;

  Future<UseCaseResult<String>> call({
    required String image,
    required String location,
    required String title,
    required String datetime,
    String? backgroundColor,
    String? foregroundColor,
    List<TicketFieldModel>? fields,
  }) async {
    List<Field>? requestFields = fields == null
        ? null
        : List.generate(
            fields.length,
            (index) => Field(
              content: fields[index].content,
              subtitle: fields[index].subtitle,
            ),
          );

    final RepositoryResult<String> repositoryResult =
        await _ticketRepository.makeTicket(
      image: image,
      location: location,
      title: title,
      datetime: datetime,
      backgroundColor: backgroundColor == null
          ? null
          : extractColor(rawColor: backgroundColor),
      foregroundColor: foregroundColor == null
          ? null
          : extractColor(rawColor: foregroundColor),
      fields: requestFields,
    );

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
