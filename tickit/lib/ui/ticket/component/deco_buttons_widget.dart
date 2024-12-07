import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/ticket/component/ticket_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/component/custom_color_picker_dialog.dart';

class DecoButtonsWidget extends StatelessWidget {
  final TicketMode mode;
  final VoidCallback onTapAddField;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function(Color) onBackgroundColorChanged;
  final Function(Color) onForegroundColorChanged;
  final VoidCallback onTapGetSchedule;

  const DecoButtonsWidget({
    super.key,
    required this.mode,
    required this.onTapAddField,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onBackgroundColorChanged,
    required this.onForegroundColorChanged,
    required this.onTapGetSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      children: [
        TicketTextButton(
          label: "필드 추가",
          onPressed: onTapAddField,
          textStyle: Typo.gangwonR16.copyWith(
            color: AppColors.textColor,
          ),
        ),
        TicketTextButton(
          label: "배경색",
          onPressed: () => showDialog(
            context: context,
            builder: (context) => CustomColorPickerDialog(
              title: "배경색을 선택하세요",
              color: backgroundColor,
              onColorChanged: onBackgroundColorChanged,
            ),
          ),
          textStyle: Typo.gangwonR16.copyWith(
            color: AppColors.textColor,
          ),
        ),
        TicketTextButton(
          label: "글자색",
          onPressed: () => showDialog(
            context: context,
            builder: (context) => CustomColorPickerDialog(
              title: "글자색을 선택하세요",
              color: foregroundColor,
              onColorChanged: onForegroundColorChanged,
            ),
          ),
          textStyle: Typo.gangwonR16.copyWith(
            color: AppColors.textColor,
          ),
        ),
        TicketTextButton(
          label: "일정 불러오기",
          onPressed: onTapGetSchedule,
          textStyle: Typo.gangwonR16.copyWith(
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
