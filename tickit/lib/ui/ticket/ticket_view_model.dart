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

  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  TicketViewModel({
    required CreateTicketUseCase createTicketUseCase,
    required GetPresignedUrlUseCase getPresignedUrlUseCase,
    required UploadImageToS3UseCase uploadImageToS3UseCase,
  })  : _createTicketUseCase = createTicketUseCase,
        _getPresignedUrlUseCase = getPresignedUrlUseCase,
        _uploadImageToS3UseCase = uploadImageToS3UseCase,
        super(TicketState());

  void initState() {
    state = TicketState();
    titleController.clear();
    locationController.clear();
    debugPrint("티켓 UI 초기화 완료");
  }

  void onTapImageBox({
    required XFile? newImage,
  }) {
    if (mounted) {
      if (newImage != null) {
        state = state.copyWith(image: newImage);
        debugPrint("image: ${state.image?.path}");
      } else {
        state = state.copyWith(errorMsg: "이미지를 불러올 수 없어요.");
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
    if (mounted) {
      state = state.copyWith(
        date: state.date ?? DateTime.now(),
      );
    }
    final dateTime =
        "${state.date.toString().split(" ")[0]}  ${state.hour}:${state.minute}";
    if (mounted) {
      state = state.copyWith(
        dateTime: dateTime,
      );
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
      initState();
    }
  }

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

    initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();

    super.dispose();
  }
}

// String colorToString(Color color) {
//   return '0x${color.value.toRadixString(16).padLeft(8, '0')}';
// }
