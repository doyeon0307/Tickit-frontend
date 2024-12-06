import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/schedule/entity/schedule_entity.dart';
import 'package:tickit/domain/s3/get_presigned_url_use_case.dart';
import 'package:tickit/domain/s3/model/s3_url_model.dart';
import 'package:tickit/domain/s3/upload_image_to_s3_use_case.dart';
import 'package:tickit/domain/schedule/create_schedule_use_case.dart';
import 'package:tickit/ui/schedule/schedule/view_model/base_schedule_view_model.dart';

class CreateScheduleViewModel extends BaseScheduleViewModel {
  final GetPresignedUrlUseCase _getPresignedUrlUseCase;
  final UploadImageToS3UseCase _uploadImageToS3UseCase;
  final CreateScheduleUseCase _createScheduleUseCase;

  CreateScheduleViewModel({
    required GetPresignedUrlUseCase getPresignedUrlUseCase,
    required UploadImageToS3UseCase uploadImageToS3UseCase,
    required CreateScheduleUseCase createScheduleUseCase,
  })  : _getPresignedUrlUseCase = getPresignedUrlUseCase,
        _uploadImageToS3UseCase = uploadImageToS3UseCase,
        _createScheduleUseCase = createScheduleUseCase;

  @override
  Future<void> onSavePressed() async {
    if (state.date == null || state.title.isEmpty || state.hour.isEmpty || state.minute.isEmpty) {
      state = state.copyWith(
        errorMsg: "제목과 시간은 필수로 입력해주세요.",
      );
      return;
    }
    try {
      state = state.copyWith(
        loadingSave: LoadingStatus.loading,
        errorMsg: "",
        successMsg: "",
      );

      String imageUrl = state.networkImage;
      if (state.image != null) {
        final getUrlResult = await _getPresignedUrlUseCase();
        late final S3UrlModel urlData;

        // get url
        switch (getUrlResult) {
          case SuccessUseCaseResult<S3UrlModel>():
            urlData = getUrlResult.data;
          case FailureUseCaseResult<S3UrlModel>():
            if (mounted) {
              state = state.copyWith(
                loadingSave: LoadingStatus.error,
                errorMsg: "unknownError".tr(),
              );
              debugPrint("url 요청 오류: ${getUrlResult.message}");
              return;
            }
        }

        final imageUploadResult = await _uploadImageToS3UseCase(
          uploadUrl: urlData.uploadUrl,
          image: state.image!,
        );

        switch (imageUploadResult) {
          case SuccessUseCaseResult<void>():
            imageUrl = urlData.imageUrl;
            if (mounted) {
              state = state.copyWith();
            }
          case FailureUseCaseResult<void>():
            if (mounted) {
              state = state.copyWith(
                loadingSave: LoadingStatus.error,
                errorMsg: "unknownError".tr(),
              );
              debugPrint("s3 이미지 업로드 오류: ${imageUploadResult.message}");
              return;
            }
        }
      }

      // make schedule
      final result = await _createScheduleUseCase(
        image: imageUrl,
        isAM: state.isAM,
        memo: state.memo,
        minute: state.minute,
        title: state.title,
        date: state.date!,
        hour: state.hour,
        location: state.location,
        company: state.company,
        link: state.link,
        seat: state.seat,
      );

      switch (result) {
        case SuccessUseCaseResult<ScheduleEntity>():
          if (mounted) {
            state = state.copyWith(
              loadingSave: LoadingStatus.success,
              successMsg: "일정이 저장되었어요.",
            );
          }
        case FailureUseCaseResult<ScheduleEntity>():
          if (mounted) {
            state = state.copyWith(
              loadingSave: LoadingStatus.error,
              errorMsg: "unknownError".tr(),
            );
            debugPrint("티켓 생성 오류: ${result.message}");
            return;
          } else {
            if (mounted) {
              state = state.copyWith(
                loadingSave: LoadingStatus.error,
                errorMsg: "unknownError".tr(),
              );
            }
            return;
          }
      }
    } catch (e) {
      if (mounted) {
        state = state.copyWith(
          loadingSave: LoadingStatus.error,
          errorMsg: "unknownError".tr(),
        );
      }
      return;
    }
  }

  @override
  Future<void> getDetailSchedule({required String id}) {
    throw UnsupportedError("getDetailSchedule");
  }

  @override
  Future<void> onUpdatePressed({required String id}) {
    throw UnsupportedError("onUpdatePressed");
  }

  @override
  Future<void> onDeletePressed({required String id}) {
    throw UnsupportedError("onDeletePressed");
  }
}
