import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/schedule/calendar/component/calendar_dialog.dart';
import 'package:tickit/ui/schedule/schedule/schedule_view.dart';

class CalendarDateWidget extends StatelessWidget {
  final DateTime date;
  final List<SchedulePreviewData> schedules;
  final double cellHeight;
  final VoidCallback refreshCalendar;
  final Widget? firstMarkerWidget;

  const CalendarDateWidget({
    super.key,
    required this.date,
    required this.schedules,
    required this.cellHeight,
    required this.refreshCalendar,
    this.firstMarkerWidget,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        if (schedules.isEmpty) {
          final created = await pushWithNavBar(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleView(
                mode: ScheduleMode.create,
                date: date,
                id: null,
              ),
            ),
          );
          if (created != null && created) {
            refreshCalendar();
          }
        } else {
          showDialog(
            context: context,
            builder: (context) {
              final width = screenSize.width * 0.7;
              final height = screenSize.height * 0.4;
              return CalendarDialog(
                width: width,
                height: height,
                date: date,
                refreshCalendar: refreshCalendar,
                schedules: schedules,
              );
            },
          );
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            if (firstMarkerWidget != null)
              Flexible(
                child: Container(
                  child: firstMarkerWidget,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
