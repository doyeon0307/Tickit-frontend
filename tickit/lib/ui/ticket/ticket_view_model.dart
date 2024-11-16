import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/domain/s3/get_presigned_url_use_case.dart';
import 'package:tickit/domain/s3/model/s3_url_model.dart';
import 'package:tickit/domain/s3/upload_image_to_s3_use_case.dart';
import 'package:tickit/domain/ticket/create_ticket_use_case.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';

final ticketViewModelProvider =
    StateNotifierProvider.autoDispose<TicketViewModel, TicketState>(
  (ref) => TicketViewModel(
    createTicketUseCase: ref.read(createTicketUseCaseProvider),
    getPresignedUrlUseCase: ref.read(getPresignedUrlUseCaseProvider),
    uploadImageToS3UseCase: ref.read(uploadImageToS3UseCaseProvider),
  ),
);

class TicketViewModel extends StateNotifier<TicketState> {
  final CreateTicketUseCase _createTicketUseCase;
  final GetPresignedUrlUseCase _getPresignedUrlUseCase;
  final UploadImageToS3UseCase _uploadImageToS3UseCase;

  TicketViewModel({
    required CreateTicketUseCase createTicketUseCase,
    required GetPresignedUrlUseCase getPresignedUrlUseCase,
    required UploadImageToS3UseCase uploadImageToS3UseCase,
  })  : _createTicketUseCase = createTicketUseCase,
        _getPresignedUrlUseCase = getPresignedUrlUseCase,
        _uploadImageToS3UseCase = uploadImageToS3UseCase,
        super(TicketState());

  void onTapImageBox({
    required XFile? newImage,
  }) {
    if (mounted) {
      if (newImage != null) {
        state = state.copyWith(
          image: newImage,
          imageErrMsg: "",
        );
        debugPrint("image: ${state.image?.path}");
      } else {
        state = state.copyWith(imageErrMsg: "imageError".tr());
      }
    }
  }

  void onChangedTitle({
    required newTitle,
  }) {
    if (mounted) {
      state = state.copyWith(title: newTitle);
      debugPrint("title: ${state.title}");
    }
  }

  void onChangedLocation({
    required String newLocation,
  }) {
    if (mounted) {
      state = state.copyWith(location: newLocation);
      debugPrint("location: ${state.location}");
    }
  }

  void onTapAmButton() {
    if (mounted) {
      state = state.copyWith(isAm: !state.isAm);
      debugPrint("isAm: ${state.isAm}");
    }
  }

  void onChangedDate({
    required DateTime newDate,
  }) {
    if (mounted) {
      state = state.copyWith(date: newDate);
      debugPrint("date: ${state.date?.toString()}");
    }
  }

  void onChangedHour({
    required int newHour,
  }) {
    if (mounted) {
      state = state.copyWith(hour: newHour);
      debugPrint("hour: ${state.hour}");
    }
  }

  void onChangedMinute({
    required int newMinute,
  }) {
    if (mounted) {
      state = state.copyWith(minute: newMinute);
      debugPrint("minute: ${state.minute}");
    }
  }

  void onPressedDateTimeCheck() {
    final dateTime =
        "${state.date.toString().split(" ")[0]}  ${state.hour}:${state.minute}";
    if (mounted) {
      state = state.copyWith(dateTime: dateTime);
      debugPrint("dateTime: ${state.dateTime}");
    }
  }

  void onBackgroundColorChanged({
    required Color newColor,
  }) {
    if (mounted) {
      state = state.copyWith(backgroundColor: newColor);
      debugPrint("backgroundColor: ${state.backgroundColor}");
    }
  }

  void onForegroundColorChanged({
    required Color newColor,
  }) {
    if (mounted) {
      state = state.copyWith(foregroundColor: newColor);
      debugPrint("foregroundColor: ${state.foregroundColor}");
    }
  }

  void onPressedCancel() {
    if (mounted) {
      state = TicketState();
    }
  }

  Future<void> onPressedSave() async {
    if (state.image == null ||
        state.dateTime == "날짜를 선택하세요" ||
        state.date == null) return;

    try {
      state = state.copyWith(
        makeTicketLoading: LoadingStatus.loading,
        uploadImageLoading: LoadingStatus.loading,
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
                uploadImageLoading: LoadingStatus.error,
                makeTicketLoading: LoadingStatus.error,
                imageErrMsg: "이미지 업로드에 실패했습니다.");
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
            state = state.copyWith(
              uploadImageLoading: LoadingStatus.success,
            );
          }
        case FailureUseCaseResult<void>():
          if (mounted) {
            state = state.copyWith(
              uploadImageLoading: LoadingStatus.error,
              makeTicketLoading: LoadingStatus.error,
              imageErrMsg: "이미지 업로드에 실패했습니다.",
            );
            return;
          }
      }

      // make ticket
      final makeTicketResult = await _createTicketUseCase(
        image: imageUrl,
        title: state.title,
        datetime: state.dateTime,
        location: state.location,
        fields: state.fields,
        foregroundColor: state.foregroundColor.toString(),
        backgroundColor: state.backgroundColor.toString(),
      );
      switch (makeTicketResult) {
        case SuccessUseCaseResult<String>():
          if (mounted) {
            state = state.copyWith(
              makeTicketLoading: LoadingStatus.success,
            );
          }
        case FailureUseCaseResult<String>():
          if (mounted) {
            state = state.copyWith(
              makeTicketLoading: LoadingStatus.error,
              saveErrMsg: makeTicketResult.message ?? "unknownError".tr(),
            );
            debugPrint("실패..${state.saveErrMsg}");
          } else {
            if (mounted) {
              state = state.copyWith(
                makeTicketLoading: LoadingStatus.error,
                saveErrMsg: makeTicketResult.message ?? "unknownError".tr(),
              );
              debugPrint("실패..${state.saveErrMsg}");
            }
          }
      }
    } catch (e) {
      if (mounted) {
        state = state.copyWith(
          makeTicketLoading: LoadingStatus.error,
          saveErrMsg: "unknownError".tr(),
        );
      }
    }
  }
}

// String colorToString(Color color) {
//   return '0x${color.value.toRadixString(16).padLeft(8, '0')}';
// }
