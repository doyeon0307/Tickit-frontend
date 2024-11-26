import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/theme/ticket_typographies.dart';
import 'package:tickit/ui/common/component/custom_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/component/am_number_picker.dart';
import 'package:tickit/ui/ticket/component/am_text_button.dart';
import 'package:tickit/ui/ticket/const/ticket_mode.dart';

class CustomDatePickerDialog extends ConsumerWidget {
  final TicketMode mode;
  final Function(DateTime) onDateChanged;
  final VoidCallback onPressedAmButton;
  final Function(int) onChangedHour;
  final Function(int) onChangedMinute;
  final VoidCallback onPressedCheckButton;

  const CustomDatePickerDialog({
    super.key,
    required this.mode,
    required this.onDateChanged,
    required this.onPressedAmButton,
    required this.onChangedHour,
    required this.onChangedMinute,
    required this.onPressedCheckButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16.0,
      ),
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "날짜를 선택해주세요",
              style: ticketStyle.copyWith(
                fontSize: 24.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2500),
              currentDate: DateTime.now(),
              onDateChanged: onDateChanged,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: AppColors.fillColor,
                    ),
                    width: MediaQuery.of(context).size.width / 4,
                    child: Row(
                      children: [
                        Expanded(
                          child: AmTextButton(
                            mode: mode,
                            isAmButton: true,
                            label: "오전",
                            onPressed: onPressedAmButton,
                          ),
                        ),
                        Expanded(
                          child: AmTextButton(
                            mode: mode,
                            isAmButton: false,
                            label: "오후",
                            onPressed: onPressedAmButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  TimeNumberPicker(
                    mode: mode,
                    isHour: true,
                    onChanged: onChangedHour,
                  ),
                  Text(
                    ":",
                    style: ticketStyle.copyWith(
                      fontSize: 28.0,
                    ),
                  ),
                  TimeNumberPicker(
                    mode: mode,
                    isHour: false,
                    onChanged: onChangedMinute,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  CustomTextButton(
                    label: "선택",
                    textStyle: ticketStyle,
                    onPressed: () {
                      onPressedCheckButton();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
