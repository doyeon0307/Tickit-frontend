import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/component/custom_network_image.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/schedule/calendar/calendar_view_model.dart';

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

    return Scaffold(
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

                  return CustomCalendar(
                    selectedDate: state.selectedDate,
                    scheduleModels: currentSchedules,
                  );
                },
              ),
      ),
    );
  }
}

class CustomCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final List<SchedulePreviewModel> scheduleModels;

  const CustomCalendar({
    super.key,
    required this.selectedDate,
    required this.scheduleModels,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final weeksInMonth = _getWeeksInMonth();

    final gridHeight = screenHeight - 220;
    final cellHeight = gridHeight / weeksInMonth;

    final markedDates = <DateTime, Widget>{};
    for (final model in scheduleModels) {
      model.markedDates.forEach((dateStr, data) {
        final date = DateTime.parse(dateStr);
        Widget content;

        if (data.hasImage) {
          content = CustomNetworkImage(url: data.image);
        } else {
          content = Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: AppColors.secondaryColor.withOpacity(0.1),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 2.0,
            ),
            child: Text(
              data.title,
              style: Typo.pretendardR8.copyWith(
                color: AppColors.secondaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        markedDates[date] = content;
      });
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${selectedDate.year}년 ${selectedDate.month}월',
            style: Typo.pretendardSB24.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
                .map(
                  (day) => Expanded(
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: Typo.pretendardR12.copyWith(
                        color: AppColors.calendarDateColor,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio:
                MediaQuery.of(context).size.width / 7 / cellHeight,
          ),
          itemCount: _getDaysInMonth(),
          itemBuilder: (context, index) {
            final date = _getDateFromIndex(index);
            final hasMarker = markedDates.containsKey(date);

            if (date.month != selectedDate.month) {
              return Container();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 12.0,
                  ),
                  child: Text(
                    date.day.toString(),
                    style: Typo.pretendardR8.copyWith(
                      color: AppColors.calendarDateColor,
                    ),
                  ),
                ),
                if (hasMarker)
                  Container(
                    child: markedDates[date]!,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  int _getWeeksInMonth() {
    final firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDay = DateTime(selectedDate.year, selectedDate.month + 1, 0);

    final firstDayOffset = firstDay.weekday - 1;
    final totalDays = firstDayOffset + lastDay.day;

    return (totalDays / 7).ceil();
  }

  int _getDaysInMonth() {
    final weeksInMonth = _getWeeksInMonth();
    return weeksInMonth * 7;
  }

  DateTime _getDateFromIndex(int index) {
    final firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    final diff = index - (firstDay.weekday - 1);
    return DateTime(selectedDate.year, selectedDate.month, diff);
  }
}
