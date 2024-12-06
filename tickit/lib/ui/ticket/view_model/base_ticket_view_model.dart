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
    debugPrint("removeField 호출, 선택된 인덱스=$index, State의 fields 길이=${state.fields.length}");
    if (index < 0 || index >= state.fields.length) return;

    final newFields = [...state.fields];
    debugPrint("삭제 전 fields: ${newFields.map((f) => f.subtitle).toList()}"); // 삭제 전 상태 확인
    newFields.removeAt(index);
    debugPrint("삭제 후 fields: ${newFields.map((f) => f.subtitle).toList()}"); // 삭제 후 상태 확인

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
    debugPrint("필드 소제목 업데이트 $index: $text");
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
    final dateTime = "${makeRequestDate(date: state.date!)} ${state.isAm ? "AM" : "PM"}"
        " ${getTimeFormat(time: state.hour.toString())}:${getTimeFormat(time: state.minute.toString())}";
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
