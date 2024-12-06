import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState({
    @Default(LoadingStatus.none) loadingCalendar,
    @Default([]) List<Map<String, List<SchedulePreviewModel>>> schedules,
    required DateTime selectedDate,
    required DateTime today,
    @Default(0) int currentIndex,
    @Default("") String errorMsg,
    @Default("") String successMsg,
  }) = _CalendarState;
}
