import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String leftButtonLabel;
  final String rightButtonLabel;
  final VoidCallback onPressedLeftButton;
  final VoidCallback onPressedRightButton;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.leftButtonLabel,
    required this.rightButtonLabel,
    required this.onPressedLeftButton,
    required this.onPressedRightButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 24.0,
                ),
                child: Text(
                  title,
                  style: Typo.pretendardSB22.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16.0,
                ),
                child: Text(
                  content,
                  style: Typo.pretendardR18.copyWith(
                    color: AppColors.dialogContentColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: onPressedLeftButton,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.dialogButtonTextColor,
                        backgroundColor: AppColors.dialogLeftButtonColor,
                        textStyle: Typo.pretendardSB18,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                      ),
                      child: Text(leftButtonLabel),
                    ),
                    const SizedBox(width: 16.0),
                    TextButton(
                      onPressed: onPressedRightButton,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.dialogLeftButtonColor,
                        backgroundColor: AppColors.dialogRightButtonColor,
                        textStyle: Typo.pretendardSB18,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                      ),
                      child: Text(rightButtonLabel),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
