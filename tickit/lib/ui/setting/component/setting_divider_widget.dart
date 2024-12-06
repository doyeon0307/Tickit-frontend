import 'package:flutter/material.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class SettingDividerWidget extends StatelessWidget {
  const SettingDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      endIndent: 0.0,
      indent: 0.0,
      color: AppColors.lightGrayColor,
    );
  }
}
