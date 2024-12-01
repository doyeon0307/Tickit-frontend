import 'package:flutter/material.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class TicketTextButton extends StatelessWidget {
  final String label;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const TicketTextButton({
    super.key,
    required this.label,
    this.foregroundColor,
    this.backgroundColor,
    this.textStyle,
    this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize:
            (width != null && height != null) ? Size(width!, height!) : null,
        textStyle: textStyle ?? const TextStyle(fontSize: 16.0),
        foregroundColor: foregroundColor ?? AppColors.textColor,
        backgroundColor: backgroundColor ?? AppColors.fillColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
      ),
      child: Text(label),
    );
  }
}
