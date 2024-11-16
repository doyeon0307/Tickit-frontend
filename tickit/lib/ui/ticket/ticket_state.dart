import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/data/ticket/body/ticket_request_body.dart';

part 'ticket_state.freezed.dart';

@freezed
class TicketState with _$TicketState {
  factory TicketState({
    @Default(LoadingStatus.none) LoadingStatus initLoading,
    @Default(LoadingStatus.none) LoadingStatus uploadImageLoading,
    @Default(LoadingStatus.none) LoadingStatus makeTicketLoading,
    @Default(null) XFile? image,
    @Default("") String title,
    @Default("") String location,
    @Default("날짜를 선택하세요") String dateTime,
    @Default(null) DateTime? date,
    @Default(true) bool isAm,
    @Default(0) int hour,
    @Default(0) int minute,
    @Default(Colors.white) Color backgroundColor,
    @Default(Color(0xff141414)) Color foregroundColor,
    @Default([]) List<Field> fields,
    @Default(10) int maxCount,
    @Default(0) int fieldCount,
    @Default("") String setDatetimeErrMsg,
    @Default("") String saveErrMsg,
    @Default("") String unfilledTextFieldErrMsg,
    @Default("") String imageErrMsg,
  }) = _TicketState;
}
