import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/domain/ticket/create_ticket_use_case.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';

final ticketViewModelProvider =
    StateNotifierProvider.autoDispose<TicketViewModel, TicketState>(
  (ref) => TicketViewModel(
    createTicketUseCase: ref.read(createTicketUseCaseProvider),
  ),
);

class TicketViewModel extends StateNotifier<TicketState> {
  final CreateTicketUseCase _createTicketUseCase;

  TicketViewModel({
    required CreateTicketUseCase createTicketUseCase,
  })  : _createTicketUseCase = createTicketUseCase,
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
        "${state.date.toString().split(" ")[0]} ${state.hour}:${state.minute}";
    if (mounted) {
      state = state.copyWith(dateTime: dateTime);
      debugPrint("minute: ${state.dateTime}");
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
    if (state.saveErrMsg != "" ||
        state.setDatetimeErrMsg != "" ||
        state.unfilledTextFieldErrMsg != "") return;

    final result = await _createTicketUseCase(
      image: state.image!.path,
      title: state.title,
      datetime: state.date.toString(),
      location: state.location,
      fields: state.fields,
      foregroundColor: state.foregroundColor.toString(),
      backgroundColor: state.backgroundColor.toString(),
    );
    switch (result) {
      case SuccessUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(makingLoading: LoadingStatus.success);
        }
      case FailureUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            makingLoading: LoadingStatus.error,
            saveErrMsg: result.message ?? "unknownError".tr(),
          );
        } else {
          if (mounted) {
            state = state.copyWith(
              makingLoading: LoadingStatus.error,
              saveErrMsg: result.message ?? "unknownError".tr(),
            );
          }
        }
    }
  }
}

// String colorToString(Color color) {
//   return '0x${color.value.toRadixString(16).padLeft(8, '0')}';
// }
