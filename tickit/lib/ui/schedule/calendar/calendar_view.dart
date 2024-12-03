import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/schedule/calendar/calendar_view_model.dart';
import 'package:tickit/ui/schedule/calendar/component/custom_calendar_widget.dart';

class CalendarView extends HookConsumerWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(calendarViewModelProvider.notifier);
    final state = ref.watch(calendarViewModelProvider);
    final pageController = usePageController(initialPage: 12);

    useEffect(() {
      Future(() => viewModel.initCalender());
      return null;
    }, []);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: state.loadingCalendar == LoadingStatus.loading
              ? const Center(child: CustomLoading())
              : PageView.builder(
                  controller: pageController,
                  onPageChanged: (value) =>
                      viewModel.onChangedCalendarPage(value),
                  itemBuilder: (context, index) {
                    final monthKey =
                        '${state.selectedDate.year}-${state.selectedDate.month.toString().padLeft(2, '0')}';
                    final currentSchedules = state.schedules
                            .where((schedule) => schedule.containsKey(monthKey))
                            .map((schedule) => schedule[monthKey] ?? [])
                            .firstOrNull ??
                        [];

                    return CustomCalendarWidget(
                      selectedDate: state.selectedDate,
                      scheduleModels: currentSchedules,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
