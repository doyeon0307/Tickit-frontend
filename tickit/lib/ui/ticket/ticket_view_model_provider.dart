import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/domain/s3/get_presigned_url_use_case.dart';
import 'package:tickit/domain/s3/upload_image_to_s3_use_case.dart';
import 'package:tickit/domain/ticket/create_ticket_use_case.dart';
import 'package:tickit/domain/ticket/delete_ticket_use_case.dart';
import 'package:tickit/domain/ticket/get_ticket_detail_use_case.dart';
import 'package:tickit/ui/ticket/base_ticket_view_model.dart';
import 'package:tickit/ui/ticket/detail_ticket_view_model.dart';
import 'package:tickit/ui/ticket/ticket_mode.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/create_ticket_view_model.dart';

final ticketViewModelProvider = StateNotifierProvider.family
    .autoDispose<BaseTicketViewModel, TicketState, TicketMode>((ref, mode) {
  if (mode == TicketMode.create) {
    return CreateTicketViewModel(
      createTicketUseCase: ref.read(createTicketUseCaseProvider),
      getPresignedUrlUseCase: ref.read(getPresignedUrlUseCaseProvider),
      uploadImageToS3UseCase: ref.read(uploadImageToS3UseCaseProvider),
    );
  }
  if (mode == TicketMode.detail) {
    return DetailTicketViewModel(
      getTicketDetailUseCase: ref.read(getTicketDetailUseCaseProvider),
      deleteTicketUseCase: ref.read(deleteTicketUseCaseProvider),
    );
  } else {
    return CreateTicketViewModel(
      createTicketUseCase: ref.read(createTicketUseCaseProvider),
      getPresignedUrlUseCase: ref.read(getPresignedUrlUseCaseProvider),
      uploadImageToS3UseCase: ref.read(uploadImageToS3UseCaseProvider),
    );
  }
});
