import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class SettingTextWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final Widget? widget;

  const SettingTextWidget({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.pretendardR16.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    description,
                    style: Typo.pretendardR12.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              widget ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
