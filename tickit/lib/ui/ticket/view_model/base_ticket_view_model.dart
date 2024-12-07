import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/util/request_body_date_time_format.dart';
import 'package:tickit/domain/ticket/model/ticket_field_model.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';

abstract class BaseTicketViewModel extends StateNotifier<TicketState> {
  BaseTicketViewModel() : super(TicketState());

  // create
  void initState();

  void onPressedCancel();

  Future<bool> onPressedSave();

  Future<void> onTapGetSchedule();

  void onTapSchedule(int index);

  Future<void> onSelectSchedule();

  // detail
  Future<void> initDetailView({required String id});

  Future<void> onTapDelete({required String id});

  Future<void> onPressedUpdate({required String id});

  void onTapEditButton();

  // base
  Future<void> initTicketView({
    required TicketMode mode,
    required String? id,
  }) async {
    state = state.copyWith(mode: mode);
    if (mode == TicketMode.detail && id != null) {
      await initDetailView(id: id);
    }
  }

  void addField() {
    if (!mounted) return;
    if (state.fields.length >= state.maxCount) return;

    final newFields = [...state.fields];
    newFields.add(
      TicketFieldModel(
        subtitle: "",
        content: "",
      ),
    );

    state = state.copyWith(
      fields: newFields,
      fieldCount: state.fieldCount + 1,
    );
  }

  void removeField({
    required int index,
  }) {
    if (!mounted) return;
    if (index < 0 || index >= state.fields.length) return;

    final newFields = [...state.fields];
    newFields.removeAt(index);

    state = state.copyWith(
      fields: newFields,
      fieldCount: state.fieldCount - 1,
    );
  }

  void updateFieldTitle({
    required int index,
    required String text,
  }) {
    if (!mounted) return;
    if (index < 0 || index >= state.fields.length) return;

    final newFields = [...state.fields];
    newFields[index] = newFields[index].copyWith(subtitle: text);
    state = state.copyWith(fields: newFields);
  }

  void updateFieldContent({
    required int index,
    required String text,
  }) {
    if (!mounted) return;
    if (index < 0 || index >= state.fields.length) return;

    final newFields = [...state.fields];
    newFields[index] = newFields[index].copyWith(content: text);

    state = state.copyWith(fields: newFields);
  }

  void onTapImageBox(XFile? newImage) {
    if (mounted) {
      if (newImage != null) {
        state = state.copyWith(image: newImage);
      } else {
        state = state.copyWith(errorMsg: "이미지를 불러올 수 없어요.");
      }
    }
  }

  void onChangedTitle({
    required newTitle,
  }) {
    state = state.copyWith(title: newTitle);
  }

  void onChangedLocation({
    required String newLocation,
  }) {
    state = state.copyWith(location: newLocation);
  }

  void onTapAmButton() {
    if (mounted) {
      state = state.copyWith(isAm: !state.isAm);
    }
  }

  void onChangedDate({
    required DateTime newDate,
  }) {
    if (mounted) {
      state = state.copyWith(date: newDate);
    }
  }

  void onChangedHour({
    required int newHour,
  }) {
    if (mounted) {
      state = state.copyWith(hour: newHour);
    }
  }

  void onChangedMinute({
    required int newMinute,
  }) {
    if (mounted) {
      state = state.copyWith(minute: newMinute);
    }
  }

  void onPressedDateTimeCheck() {
    if (mounted) {
      state = state.copyWith(
        date: state.date ?? DateTime.now(),
      );
    }
    final dateTime = "${makeRequestDate(date: state.date!)} ${state.isAm ? "AM" : "PM"}"
        " ${getTimeFormat(time: state.hour.toString())}:${getTimeFormat(time: state.minute.toString())}";
    if (mounted) {
      state = state.copyWith(
        dateTime: dateTime,
      );
    }
  }

  void onBackgroundColorChanged({
    required Color newColor,
  }) {
    if (mounted) {
      state = state.copyWith(backgroundColor: newColor);
    }
  }

  void onForegroundColorChanged({
    required Color newColor,
  }) {
    if (mounted) {
      state = state.copyWith(foregroundColor: newColor);
    }
  }
}
