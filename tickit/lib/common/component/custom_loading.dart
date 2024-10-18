import 'package:flutter/material.dart';
import 'package:tickit/common/const/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.primaryColor,
    );
  }
}
