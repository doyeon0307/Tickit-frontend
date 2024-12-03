import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';

class ScheduleTextButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ScheduleTextButtonWidget({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 22.0,
          vertical: 10.0,
        ),
        textStyle: Typo.pretendardR16,
      ),
      child: Text(label),
    );
  }
}
