import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/repository/repository_result.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/core/util/color_utils.dart';
import 'package:tickit/core/util/request_body_date_time_format.dart';
import 'package:tickit/data/ticket/body/ticket_request_body.dart';
import 'package:tickit/data/ticket/entity/ticket_entity.dart';
import 'package:tickit/data/ticket/ticket_repository.dart';
import 'package:tickit/domain/ticket/model/ticket_field_model.dart';

final updateTicketUseCaseProvider = Provider.autoDispose(
  (ref) => UpdateTicketUseCase(
    ticketRepository: ref.watch(ticketRepositoryProvider),
  ),
);

class UpdateTicketUseCase {
  final TicketRepository _ticketRepository;

  const UpdateTicketUseCase({
    required TicketRepository ticketRepository,
  }) : _ticketRepository = ticketRepository;

  Future<UseCaseResult<TicketEntity>> call({
    required String id,
    required String networkImage,
    required String location,
    required String title,
    required String hour,
    required String minute,
    required bool isAM,
    required DateTime date,
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
    final newDate = makeRequestDate(date: date);
    final time = makeRequestTime(hour: hour, minute: minute, isAM: isAM);

    final RepositoryResult<TicketEntity> repositoryResult =
        await _ticketRepository.updateTicket(
      id: id,
      ticketDTO: TicketRequestBody(
        image: networkImage,
        location: location,
        title: title,
        date: newDate,
        time: time,
        backgroundColor: backgroundColor == null
            ? null
            : extractColor(rawColor: backgroundColor),
        foregroundColor: foregroundColor == null
            ? null
            : extractColor(rawColor: foregroundColor),
        fields: requestFields,
      ),
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<TicketEntity>() => SuccessUseCaseResult(
          data: repositoryResult.data,
        ),
      FailureRepositoryResult<TicketEntity>() => FailureUseCaseResult(
          message: repositoryResult.messages?.first ?? '',
          statusCode: repositoryResult.statusCode,
        )
    };
  }
}
