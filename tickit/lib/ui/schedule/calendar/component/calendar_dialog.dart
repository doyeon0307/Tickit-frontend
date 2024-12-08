import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickit/domain/schedule/model/schedule_preview_model.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/schedule/calendar/component/calendar_dialog_card_widget.dart';
import 'package:tickit/ui/schedule/schedule/schedule_view.dart';
import 'package:tickit/ui/common/component/custom_divider.dart';

class CalendarDialog extends StatelessWidget {
  final double width;
  final double height;
  final DateTime date;
  final VoidCallback refreshCalendar;
  final List<SchedulePreviewData> schedules;

  const CalendarDialog({
    super.key,
    required this.width,
    required this.height,
    required this.date,
    required this.refreshCalendar,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${date.month}월 ${date.day}일",
                    style: Typo.pretendardSB18,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () async {
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
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ).copyWith(top: 8.0),
                        child: Text(
                          "추가하기",
                          style: Typo.pretendardR12.copyWith(
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const CustomDivider(),
              SizedBox(
                height: height - 60.0,
                child: ListView.builder(
                  itemCount: schedules.length + 1,
                  itemBuilder: (context, index) {
                    if (index == schedules.length) {
                      return const SizedBox(
                        height: 40.0,
                      );
                    }
                    return CalendarDialogCardWidget(
                      schedule: schedules[index],
                      date: date,
                      refreshCalendar: refreshCalendar,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
