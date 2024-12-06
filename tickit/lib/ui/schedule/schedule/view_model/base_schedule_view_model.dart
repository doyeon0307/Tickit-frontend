import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/ui/schedule/schedule/schedule_state.dart';

abstract class BaseScheduleViewModel extends StateNotifier<ScheduleState> {
  BaseScheduleViewModel() : super(const ScheduleState());

  // detail
  Future<void> getDetailSchedule({required String id});

  Future<void> onUpdatePressed({required String id});

  Future<void> onDeletePressed({required String id});

  // create
  Future<void> onSavePressed();

  // base
  void initView({required DateTime date}) {
    state = state.copyWith(date: date);
  }

  void onImageTap({required XFile? newImage}) {
    if (!mounted) return;

    if (newImage != null) {
      state = state.copyWith(image: newImage);
    } else {
      state = state.copyWith(errorMsg: "이미지를 불러올 수 없어요.");
    }
  }

  void onTitleChanged({required String value}) {
    state = state.copyWith(title: value);
  }

  void onLocationChanged({required String value}) {
    state = state.copyWith(location: value);
  }

  void toggleAm({required bool currentAM}) {
    state = state.copyWith(isAM: !currentAM);
  }

  void onHourChanged({required String value}) {
    state = state.copyWith(hour: value);
  }

  void onMinuteChanged({required String value}) {
    state = state.copyWith(minute: value);
  }

  void onSeatChanged({required String value}) {
    state = state.copyWith(seat: value);
  }

  void onCastingChanged({required String value}) {
    state = state.copyWith(casting: value);
  }

  void onCompanyChanged({required String value}) {
    state = state.copyWith(company: value);
  }

  void onLinkChanged({required String value}) {
    state = state.copyWith(link: value);
  }

  void onMemoChanged({required String value}) {
    state = state.copyWith(memo: value);
  }
}
