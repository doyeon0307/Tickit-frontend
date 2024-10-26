import 'package:flutter/material.dart';
import 'package:tickit/theme/text_style.dart';

class AmTextButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final VoidCallback onPressed;

  const AmTextButton({
    super.key,
    required this.backgroundColor,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(double.infinity),
        overlayColor: Colors.grey,
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: ticketStyle,
      ),
    );
  }
}
