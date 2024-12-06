import 'package:flutter/material.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class SuccessSnackBar extends SnackBar {
  final String message;

  SuccessSnackBar({
    super.key,
    required this.message,
  }) : super(
          backgroundColor: AppColors.successColor,
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        );
}
