import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/ticket/component/ticket_text_button.dart';
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
        TicketTextButton(
          label: "취소하기",
          onPressed: onPressedCancel,
          textStyle: Typo.gangwonR16.copyWith(
            color: AppColors.textColor,
          ),
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: AppColors.backgroundColor,
          width: 100.0,
          height: 28.0,
        ),
        TicketTextButton(
          label: "저장하기",
          onPressed: onPressedSave,
          textStyle: Typo.gangwonR16.copyWith(
            color: AppColors.textColor,
          ),
          backgroundColor: AppColors.primaryColor,
          width: 150.0,
          height: 28.0,
        ),
      ],
    );
  }
}
