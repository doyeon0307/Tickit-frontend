import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/core/util/calendar_date_utils.dart';
import 'package:tickit/domain/schedule/get_schedule_preview_list_use_case.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';
import 'package:tickit/ui/schedule/calendar/calendar_state.dart';

final calendarViewModelProvider = StateNotifierProvider.autoDispose<CalendarViewModel, CalendarState>(
  (ref) => CalendarViewModel(
    getSchedulePreviewListUseCase: ref.read(getSchedulePreviewListUseCaseProvider),
  ),
);

class CalendarViewModel extends StateNotifier<CalendarState> {
  final GetSchedulePreviewListUseCase _getSchedulePreviewListUseCase;

  CalendarViewModel({
    required GetSchedulePreviewListUseCase getSchedulePreviewListUseCase,
  })  : _getSchedulePreviewListUseCase = getSchedulePreviewListUseCase,
        super(CalendarState(
          selectedDate: DateTime.now(),
          today: DateTime.now(),
        ));

  void initCalender() {
    getSchedules(date: state.today);
  }

  void onChangedCalendarPage(int index) {
    if (!mounted) return;

    final monthDiff = index - state.currentIndex;

    final newDate = DateTime(
      state.selectedDate.year,
      state.selectedDate.month + monthDiff,
      1,
    );

    state = state.copyWith(
      selectedDate: newDate,
      currentIndex: index,
    );

    if (!state.schedules.any((schedule) => schedule.containsKey('${newDate.year}-${newDate.month.toString().padLeft(2, '0')}'))) {
      getSchedules(date: newDate);
    }
  }

  Future<void> getSchedules({
    required DateTime date,
  }) async {
    if (!mounted) return;
    state = state.copyWith(loadingCalendar: LoadingStatus.loading);

    final startDate = getMonthStart(date: date);
    final endDate = getMonthEnd(date: date);

    final result = await _getSchedulePreviewListUseCase(
      startDate: startDate,
      endDate: endDate,
    );

    if (!mounted) return;

    switch (result) {
      case SuccessUseCaseResult<List<SchedulePreviewModel>>():
        final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';
        final monthData = {monthKey: result.data};
        var updatedSchedules = [...state.schedules];
        final existingIndex = updatedSchedules.indexWhere(
          (schedule) => schedule.containsKey(monthKey),
        );

        if (existingIndex != -1) {
          updatedSchedules[existingIndex] = monthData;
        } else {
          if (date.isBefore(state.today)) {
            updatedSchedules.insert(0, monthData);
          } else {
            updatedSchedules.add(monthData);
          }
        }

        state = state.copyWith(
          schedules: updatedSchedules,
          loadingCalendar: LoadingStatus.success,
        );

      case FailureUseCaseResult<List<SchedulePreviewModel>>():
        state = state.copyWith(
          errorMsg: "일정 불러오기에 실패했어요. 다시 시도해주세요.",
          loadingCalendar: LoadingStatus.error,
        );
    }
  }
}
