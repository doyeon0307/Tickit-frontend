import 'package:flutter/material.dart';
import 'package:tickit/domain/schedule/model/schedule_for_ticket_model.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/setting_divider_widget.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/component/ticket_text_button.dart';

class ScheduleListDialog extends StatelessWidget {
  final List<ScheduleForTicketModel> schedules;
  final Function(int) onTapSchedule;
  final VoidCallback onSelectSchedule;

  const ScheduleListDialog({
    super.key,
    required this.schedules,
    required this.onTapSchedule,
    required this.onSelectSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "티켓으로 만들 일정을 선택하세요",
                        style: Typo.gangwonR20.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                      const CustomDivider(),
                      SizedBox(
                        height: 200.0,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final schedule = schedules[index];
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => onTapSchedule(index),
                                child: SizedBox(
                                  height: 48,
                                  child: Row(
                                    children: [
                                      Text(
                                        schedule.date,
                                        style: Typo.gangwonR16.copyWith(
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16.0,
                                      ),
                                      Text(
                                        schedule.title,
                                        style: Typo.gangwonR16.copyWith(
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const CustomDivider(),
                          itemCount: schedules.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TicketTextButton(
              label: "선택",
              onPressed: onSelectSchedule,
              textStyle: Typo.gangwonR16.copyWith(
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
