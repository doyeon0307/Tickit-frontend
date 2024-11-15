import 'package:flutter/material.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class ErrorSnackBar extends SnackBar {
  final String message;

  ErrorSnackBar({
    super.key,
    required this.message,
  }) : super(
    backgroundColor: AppColors.errorColor,
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
