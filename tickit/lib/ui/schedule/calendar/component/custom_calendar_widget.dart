import 'package:flutter/material.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/custom_network_image.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/schedule/calendar/component/calendar_date_widget.dart';

class CustomCalendarWidget extends StatelessWidget {
  final DateTime selectedDate;
  final List<SchedulePreviewModel> scheduleModels;
  final VoidCallback refreshCalendar;

  const CustomCalendarWidget({
    super.key,
    required this.selectedDate,
    required this.scheduleModels,
    required this.refreshCalendar,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final weeksInMonth = _getWeeksInMonth();

    final gridHeight = screenHeight - 240;
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
            final dateStr =
                '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
            final schedules = scheduleModels
                .expand((model) => model.markedDates.entries)
                .where((entry) => entry.key == dateStr)
                .map((entry) => entry.value)
                .toList();

            if (date.month != selectedDate.month) {
              return const SizedBox.shrink();
            }

            Widget? firstMarkerWidget;
            if (schedules.isNotEmpty) {
              final firstSchedule = schedules.first;
              if (firstSchedule.hasImage) {
                firstMarkerWidget = CustomNetworkImage(
                  url: firstSchedule.image,
                );
              } else {
                firstMarkerWidget = Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2.0,
                  ),
                  child: Text(
                    firstSchedule.title,
                    style: Typo.pretendardR8.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            }

              return CalendarDateWidget(
                cellHeight: cellHeight,
                date: date,
                schedules: schedules,
                firstMarkerWidget: firstMarkerWidget,
                refreshCalendar: refreshCalendar,
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
