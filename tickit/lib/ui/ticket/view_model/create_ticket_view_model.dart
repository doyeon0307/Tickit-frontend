import 'package:flutter/material.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/domain/s3/get_presigned_url_use_case.dart';
import 'package:tickit/domain/s3/model/s3_url_model.dart';
import 'package:tickit/domain/s3/upload_image_to_s3_use_case.dart';
import 'package:tickit/domain/ticket/create_ticket_use_case.dart';
import 'package:tickit/ui/ticket/view_model/base_ticket_view_model.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';

class CreateTicketViewModel extends BaseTicketViewModel {
  final CreateTicketUseCase _createTicketUseCase;
  final GetPresignedUrlUseCase _getPresignedUrlUseCase;
  final UploadImageToS3UseCase _uploadImageToS3UseCase;

  CreateTicketViewModel({
    required CreateTicketUseCase createTicketUseCase,
    required GetPresignedUrlUseCase getPresignedUrlUseCase,
    required UploadImageToS3UseCase uploadImageToS3UseCase,
  })  : _createTicketUseCase = createTicketUseCase,
        _getPresignedUrlUseCase = getPresignedUrlUseCase,
        _uploadImageToS3UseCase = uploadImageToS3UseCase;

  @override
  void initState() {
    state = TicketState();
    debugPrint("티켓 UI 초기화 완료");
  }

  @override
  void onPressedCancel() {
    if (mounted) {
      initState();
    }
  }

  @override
  Future<void> onPressedSave() async {
    if (state.image == null ||
        state.dateTime == "날짜를 선택하세요" ||
        state.date == null) return;

    try {
      state = state.copyWith(
        makeTicketLoading: LoadingStatus.loading,
        errorMsg: "",
        successMsg: "",
      );

      // get url
      final getUrlResult = await _getPresignedUrlUseCase();
      late final S3UrlModel urlData;

      switch (getUrlResult) {
        case SuccessUseCaseResult<S3UrlModel>():
          urlData = getUrlResult.data;
        case FailureUseCaseResult<S3UrlModel>():
          if (mounted) {
            state = state.copyWith(
              makeTicketLoading: LoadingStatus.error,
              errorMsg: "오류가 발생했어요. 다시 시도해주세요.",
            );
            debugPrint("url 요청 오류: ${getUrlResult.message}");
            return;
          }
      }

      // upload image
      final imageUploadResult = await _uploadImageToS3UseCase(
        uploadUrl: urlData.uploadUrl,
        image: state.image!,
      );
      late final String imageUrl;

      switch (imageUploadResult) {
        case SuccessUseCaseResult<void>():
          imageUrl = urlData.imageUrl;
          if (mounted) {
            state = state.copyWith();
          }
        case FailureUseCaseResult<void>():
          if (mounted) {
            state = state.copyWith(
                makeTicketLoading: LoadingStatus.error,
                errorMsg: "오류가 발생했어요. 다시 시도해주세요.");
            debugPrint("s3 이미지 업로드 오류: ${imageUploadResult.message}");
            return;
          }
      }

      // make ticket
      final makeTicketResult = await _createTicketUseCase(
        networkImage: imageUrl,
        isAM: state.isAm,
        hour: state.hour.toString(),
        location: state.location,
        minute: state.minute.toString(),
        date: state.date!,
        title: state.title,
        foregroundColor: state.foregroundColor.toString(),
        backgroundColor: state.backgroundColor.toString(),
        fields: state.fields,
      );
      switch (makeTicketResult) {
        case SuccessUseCaseResult<String>():
          if (mounted) {
            state = state.copyWith(
              makeTicketLoading: LoadingStatus.success,
              successMsg: "티켓이 만들어졌어요! 만들어진 티켓은 홈 화면에서 확인할 수 있어요.",
            );
          }
        case FailureUseCaseResult<String>():
          if (mounted) {
            state = state.copyWith(
                makeTicketLoading: LoadingStatus.error,
                errorMsg: "오류가 발생했어요. 다시 시도해주세요.");
            debugPrint("티켓 생성 오류: ${makeTicketResult.message}");
            return;
          } else {
            if (mounted) {
              state = state.copyWith(
                  makeTicketLoading: LoadingStatus.error,
                  errorMsg: "오류가 발생했어요. 다시 시도해주세요.");
            }
            return;
          }
      }
    } catch (e) {
      if (mounted) {
        state = state.copyWith(
            makeTicketLoading: LoadingStatus.error,
            errorMsg: "오류가 발생했어요. 다시 시도해주세요.");
        return;
      }
    }
  }

  @override
  Future<void> initDetailView({required String id}) {
    throw UnsupportedError("initDetailView");
  }

  @override
  Future<void> onTapDelete({required String id}) {
    throw UnsupportedError("onTapDelete");
  }

  @override
  void onTapEditButton() {
    throw UnsupportedError("onTapEditButton");
  }

  @override
  Future<void> onPressedUpdate({required String id}) {
    throw UnsupportedError("onPressedUpdate");
  }
}
