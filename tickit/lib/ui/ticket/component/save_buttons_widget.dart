import 'package:flutter/material.dart';
import 'package:tickit/theme/ticket_typographies.dart';
import 'package:tickit/ui/common/component/custom_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class SaveButtonsWidget extends StatelessWidget {
  final VoidCallback onPressedCancel;
  final VoidCallback onPressedSave;

  const SaveButtonsWidget({
    super.key,
    required this.onPressedCancel,
    required this.onPressedSave,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      children: [
        CustomTextButton(
          label: "취소하기",
          onPressed: onPressedCancel,
          textStyle: ticketStyle,
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: AppColors.backgroundColor,
          width: 100.0,
          height: 28.0,
        ),
        CustomTextButton(
          label: "저장하기",
          onPressed: onPressedSave,
          textStyle: ticketStyle,
          backgroundColor: AppColors.primaryColor,
          width: 150.0,
          height: 28.0,
        ),
      ],
    );
  }
}
