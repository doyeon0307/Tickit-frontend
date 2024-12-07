import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/domain/schedule/model/schedule_for_ticket_model.dart';
import 'package:tickit/domain/ticket/model/ticket_field_model.dart';
import 'package:tickit/ui/common/const/mode.dart';

part 'ticket_state.freezed.dart';

@freezed
class TicketState with _$TicketState {
  factory TicketState({
    @Default(LoadingStatus.none) LoadingStatus initLoading,
    @Default(LoadingStatus.none) LoadingStatus makeTicketLoading,
    @Default(TicketMode.none) TicketMode mode,
    @Default(null) XFile? image,
    @Default("") String title,
    @Default("") String location,
    @Default("날짜를 선택하세요") String dateTime,
    @Default(null) DateTime? date,
    @Default(true) bool isAm,
    @Default(7) int hour,
    @Default(0) int minute,
    @Default(Colors.white) Color backgroundColor,
    @Default(Color(0xff141414)) Color foregroundColor,
    @Default([]) List<TicketFieldModel> fields,
    @Default([]) List<ScheduleForTicketModel> schedules,
    @Default(-1) int scheduleIndex,
    @Default("") String networkImage,
    @Default(10) int maxCount,
    @Default(0) int fieldCount,
    @Default("") String errorMsg,
    @Default("") String successMsg,
    @Default(false) bool isDeleted,
  }) = _TicketState;
}
