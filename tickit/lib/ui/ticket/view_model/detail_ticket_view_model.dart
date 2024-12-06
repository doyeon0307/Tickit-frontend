import 'package:flutter/material.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/ticket/entity/ticket_entity.dart';
import 'package:tickit/domain/s3/get_presigned_url_use_case.dart';
import 'package:tickit/domain/s3/model/s3_url_model.dart';
import 'package:tickit/domain/s3/upload_image_to_s3_use_case.dart';
import 'package:tickit/domain/ticket/delete_ticket_use_case.dart';
import 'package:tickit/domain/ticket/get_ticket_detail_use_case.dart';
import 'package:tickit/domain/ticket/model/ticket_model.dart';
import 'package:tickit/domain/ticket/update_ticket_use_case.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/ticket/view_model/base_ticket_view_model.dart';

class DetailTicketViewModel extends BaseTicketViewModel {
  final GetTicketDetailUseCase _getTicketDetailUseCase;
  final DeleteTicketUseCase _deleteTicketUseCase;
  final GetPresignedUrlUseCase _getPresignedUrlUseCase;
  final UploadImageToS3UseCase _uploadImageToS3UseCase;
  final UpdateTicketUseCase _updateTicketUseCase;

  DetailTicketViewModel({
    required GetTicketDetailUseCase getTicketDetailUseCase,
    required DeleteTicketUseCase deleteTicketUseCase,
    required GetPresignedUrlUseCase getPresignedUrlUseCase,
    required UploadImageToS3UseCase uploadImageToS3UseCase,
    required UpdateTicketUseCase updateTicketUseCase,
  })  : _getTicketDetailUseCase = getTicketDetailUseCase,
        _deleteTicketUseCase = deleteTicketUseCase,
        _getPresignedUrlUseCase = getPresignedUrlUseCase,
        _uploadImageToS3UseCase = uploadImageToS3UseCase,
        _updateTicketUseCase = updateTicketUseCase;

  @override
  Future<void> initDetailView({
    required String id,
  }) async {
    if (mounted) {
      state = state.copyWith(
        initLoading: LoadingStatus.loading,
        errorMsg: "",
        mode: TicketMode.detail,
      );
    }
    final UseCaseResult<TicketModel> result = await _getTicketDetailUseCase(id: id);

    switch (result) {
      case SuccessUseCaseResult<TicketModel>():
        final data = result.data;
        if (mounted) {
          state = state.copyWith(
            initLoading: LoadingStatus.success,
            networkImage: data.image,
            title: data.title,
            location: data.location,
            fields: data.fields,
            fieldCount: data.fields.length,
            backgroundColor: Color(int.parse(data.backgroundColor)),
            foregroundColor: Color(int.parse(data.foregroundColor)),
            date: data.date,
            minute: data.minute,
            hour: data.hour,
            isAm: data.isAm,
            dateTime: data.dateTime,
          );
        }
      case FailureUseCaseResult<TicketModel>():
        if (mounted) {
          state = state.copyWith(
            errorMsg: "티켓 불러오기에 실패했어요. 다시 시도해주세요.",
            initLoading: LoadingStatus.error,
          );
          debugPrint("티켓 세부정보 불러오기 실패: ${result.message}");
        }
    }
  }

  @override
  Future<void> onTapDelete({
    required String id,
  }) async {
    if (mounted) {
      state = state.copyWith(errorMsg: "");
    }

    final UseCaseResult<String> result = await _deleteTicketUseCase(id: id);

    switch (result) {
      case SuccessUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            isDeleted: true,
            successMsg: "티켓이 삭제되었습니다.",
          );
        }
      case FailureUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(errorMsg: "티켓 삭제에 실패했습니다. 다시 시도해주세요.");
        }
        return;
    }
  }

  @override
  void onPressedCancel() {
    throw UnsupportedError("onPressedCacel");
  }

  @override
  void onTapEditButton() {
    state = state.copyWith(mode: TicketMode.edit);
  }

  @override
  Future<void> onPressedUpdate({required String? id}) async {
    if (id == null) return;

    if (state.date == null || state.title.isEmpty) {
      state = state.copyWith(
        errorMsg: "제목과 일시는 필수로 입력해주세요.",
      );
      return;
    }

    try {
      state = state.copyWith(
        makeTicketLoading: LoadingStatus.loading,
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
                makeTicketLoading: LoadingStatus.error,
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
              state = state.copyWith(makeTicketLoading: LoadingStatus.error, errorMsg: "오류가 발생했어요. 다시 시도해주세요.");
              debugPrint("s3 이미지 업로드 오류: ${imageUploadResult.message}");
              return;
            }
        }
      }

      // make schedule
      final result = await _updateTicketUseCase(
        id: id,
        networkImage: imageUrl,
        isAM: state.isAm,
        minute: state.minute.toString(),
        title: state.title,
        date: state.date!,
        hour: state.hour.toString(),
        location: state.location,
        fields: state.fields,
        backgroundColor: state.backgroundColor.toString(),
        foregroundColor: state.foregroundColor.toString(),
      );

      switch (result) {
        case SuccessUseCaseResult<TicketEntity>():
          if (mounted) {
            state = state.copyWith(
              makeTicketLoading: LoadingStatus.success,
              successMsg: "일정이 수정되었어요.",
            );
          }
        case FailureUseCaseResult<TicketEntity>():
          if (mounted) {
            state = state.copyWith(
              makeTicketLoading: LoadingStatus.error,
              errorMsg: "오류가 발생했어요. 다시 시도해주세요.",
            );
            debugPrint("티켓 생성 오류: ${result.message}");
            return;
          } else {
            if (mounted) {
              state = state.copyWith(makeTicketLoading: LoadingStatus.error, errorMsg: "오류가 발생했어요. 다시 시도해주세요.");
            }
            return;
          }
      }
    } catch (e) {
      if (mounted) {
        state = state.copyWith(
          makeTicketLoading: LoadingStatus.error,
          errorMsg: "오류가 발생했어요. 다시 시도해주세요.",
        );
      }
      return;
    }
  }

  @override
  Future<void> onPressedSave() {
    throw UnsupportedError("onPressedSave");
  }

  @override
  void initState() {
    throw UnimplementedError("initState");
  }
}
