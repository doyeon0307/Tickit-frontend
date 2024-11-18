import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';

abstract class BaseTicketViewModel extends StateNotifier<TicketState> {
  BaseTicketViewModel() : super(TicketState());

  // create
  void initState();

  void onPressedCancel();

  Future<void> onPressedSave();

  // detail
  Future<void> initDetailView({required String id});

  Future<void> onTapDelete({required String id});

  // base
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

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
}
