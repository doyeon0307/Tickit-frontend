import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/schedule/schedule/schedule_view.dart';

class CalendarDialogCardWidget extends StatelessWidget {
  final SchedulePreviewData schedule;
  final DateTime date;
  final VoidCallback refreshCalendar;

  const CalendarDialogCardWidget({
    super.key,
    required this.schedule,
    required this.date,
    required this.refreshCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 0.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                schedule.title,
                style: Typo.pretendardR14.copyWith(
                  color: AppColors.textColor,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                final result = await pushWithNavBar(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleView(
                      mode: ScheduleMode.detail,
                      date: date,
                      id: schedule.id,
                    ),
                  ),
                );
                if (result != null && result) {
                  refreshCalendar();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
