import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/schedule/entity/schedule_entity.dart';
import 'package:tickit/domain/s3/get_presigned_url_use_case.dart';
import 'package:tickit/domain/s3/model/s3_url_model.dart';
import 'package:tickit/domain/s3/upload_image_to_s3_use_case.dart';
import 'package:tickit/domain/schedule/delete_schedule_use_case.dart';
import 'package:tickit/domain/schedule/get_schedule_detail_use_case.dart';
import 'package:tickit/domain/schedule/model/schedule_model.dart';
import 'package:tickit/domain/schedule/update_schedule_use_case.dart';
import 'package:tickit/ui/schedule/schedule/view_model/base_schedule_view_model.dart';

class DetailScheduleViewModel extends BaseScheduleViewModel {
  final GetScheduleDetailUseCase _getScheduleDetailUseCase;
  final GetPresignedUrlUseCase _getPresignedUrlUseCase;
  final UploadImageToS3UseCase _uploadImageToS3UseCase;
  final UpdateScheduleUseCase _updateScheduleUseCase;
  final DeleteScheduleUseCase _deleteScheduleUseCase;

  DetailScheduleViewModel({
    required GetScheduleDetailUseCase getScheduleDetailUseCase,
    required GetPresignedUrlUseCase getPresignedUrlUseCase,
    required UploadImageToS3UseCase uploadImageToS3UseCase,
    required UpdateScheduleUseCase updateScheduleUseCase,
    required DeleteScheduleUseCase deleteScheduleUseCase,
  })  : _getScheduleDetailUseCase = getScheduleDetailUseCase,
        _getPresignedUrlUseCase = getPresignedUrlUseCase,
        _uploadImageToS3UseCase = uploadImageToS3UseCase,
        _updateScheduleUseCase = updateScheduleUseCase,
        _deleteScheduleUseCase = deleteScheduleUseCase;

  @override
  Future<void> getDetailSchedule({required String id}) async {
    state = state.copyWith(
      loadingInitView: LoadingStatus.loading,
      errorMsg: "",
    );
    final UseCaseResult<ScheduleModel> result = await _getScheduleDetailUseCase(id: id);
    switch (result) {
      case SuccessUseCaseResult<ScheduleModel>():
        if (mounted) {
          final data = result.data;
          state = state.copyWith(
            seat: data.seat,
            minute: data.minute,
            link: data.link,
            company: data.company,
            location: data.location,
            casting: data.casting,
            hour: data.hour,
            isAM: data.isAM,
            title: data.title,
            memo: data.memo,
            networkImage: data.networkImage,
            loadingInitView: LoadingStatus.success,
          );
        }
      case FailureUseCaseResult<ScheduleModel>():
        if (mounted) {
          state = state.copyWith(
            loadingSave: LoadingStatus.error,
            errorMsg: "unknownError".tr(),
          );
          debugPrint("일정 불러오기 오류: ${result.message}");
          return;
        }
    }
  }

  @override
  Future<void> onUpdatePressed({required String id}) async {
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

      String imageUrl = "";
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
                errorMsg: "오류가 발생했어요. 다시 시도해주세요.",
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
      final result = await _updateScheduleUseCase(
        id: id,
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
              successMsg: "일정이 수정되었어요.",
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
        debugPrint("티켓 생성 오류 : $e");
      }
      return;
    }
  }

  @override
  Future<void> onDeletePressed({required String id}) async {
    state = state.copyWith(
      loadingSave: LoadingStatus.loading,
      errorMsg: "",
      successMsg: "",
    );
    final UseCaseResult<String> result = await _deleteScheduleUseCase(id: id);
    switch (result) {
      case SuccessUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            loadingSave: LoadingStatus.success,
            successMsg: "일정이 삭제되었어요.",
          );
        }
      case FailureUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            loadingSave: LoadingStatus.error,
            errorMsg: "unknownError".tr(),
          );
        }
    }
  }

  @override
  Future<void> onSavePressed() async {
    throw UnsupportedError("onSavePressed");
  }
}
