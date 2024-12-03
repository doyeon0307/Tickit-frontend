import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/schedule/schedule/schedule_state.dart';
import 'package:tickit/ui/schedule/schedule/view_model/base_schedule_view_model.dart';
import 'package:tickit/ui/schedule/schedule/view_model/create_schedule_view_model.dart';
import 'package:tickit/ui/schedule/schedule/view_model/detail_schedule_view_model.dart';

final scheduleViewModelProvider = AutoDisposeStateNotifierProvider.family<
    BaseScheduleViewModel,
    ScheduleState,
    ScheduleMode>((ref, mode) {

  return switch (mode) {
    ScheduleMode.create => CreateScheduleViewModel(),
    ScheduleMode.detail => DetailScheduleViewModel(),
    ScheduleMode.none => CreateScheduleViewModel(),
  };
});
