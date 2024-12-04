import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/domain/s3/get_presigned_url_use_case.dart';
import 'package:tickit/domain/s3/upload_image_to_s3_use_case.dart';
import 'package:tickit/domain/schedule/create_schedule_use_case.dart';
import 'package:tickit/domain/schedule/delete_schedule_use_case.dart';
import 'package:tickit/domain/schedule/get_schedule_detail_use_case.dart';
import 'package:tickit/domain/schedule/update_schedule_use_case.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/schedule/schedule/schedule_state.dart';
import 'package:tickit/ui/schedule/schedule/view_model/base_schedule_view_model.dart';
import 'package:tickit/ui/schedule/schedule/view_model/create_schedule_view_model.dart';
import 'package:tickit/ui/schedule/schedule/view_model/detail_schedule_view_model.dart';

final scheduleViewModelProvider = AutoDisposeStateNotifierProvider.family<
    BaseScheduleViewModel, ScheduleState, ScheduleMode>((ref, mode) {
  return switch (mode) {
    ScheduleMode.create => CreateScheduleViewModel(
        createScheduleUseCase: ref.read(createScheduleUseCaseProvider),
        uploadImageToS3UseCase: ref.read(uploadImageToS3UseCaseProvider),
        getPresignedUrlUseCase: ref.read(getPresignedUrlUseCaseProvider),
      ),
    ScheduleMode.detail => DetailScheduleViewModel(
        getPresignedUrlUseCase: ref.read(getPresignedUrlUseCaseProvider),
        uploadImageToS3UseCase: ref.read(uploadImageToS3UseCaseProvider),
        getScheduleDetailUseCase: ref.read(getScheduleDetailUseCaseProvider),
        updateScheduleUseCase: ref.read(updateScheduleUseCaseProvider),
        deleteScheduleUseCase: ref.read(deleteScheduleUseCaseProvider),
      ),
    ScheduleMode.none => CreateScheduleViewModel(
        createScheduleUseCase: ref.read(createScheduleUseCaseProvider),
        uploadImageToS3UseCase: ref.read(uploadImageToS3UseCaseProvider),
        getPresignedUrlUseCase: ref.read(getPresignedUrlUseCaseProvider),
      ),
  };
});
