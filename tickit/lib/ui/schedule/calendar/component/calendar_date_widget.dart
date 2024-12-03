import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/mode.dart';
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
    return GestureDetector(
      // onLongPress: () => showModalBottomSheet(
      //   context: context,
      //   useSafeArea: false,
      //   builder: (context) => Container(
      //     width: double.infinity,
      //     decoration: const BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(16.0),
      //         topRight: Radius.circular(16.0),
      //       ),
      //     ),
      //     padding: const EdgeInsets.symmetric(
      //       horizontal: 20.0,
      //       vertical: 32.0,
      //     ),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           "${date.year}년 ${date.month}월 ${date.day}일",
      //           style: Typo.pretendardSB18.copyWith(
      //             color: AppColors.textColor,
      //           ),
      //         ),
      //         const SettingDividerWidgtet(),
      //       ],
      //     ),
      //   ),
      // ),
      onLongPress: () async {
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
