import 'package:flutter/material.dart';
import 'package:tickit/theme/ticket_typegraphies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class TicketTextField extends StatelessWidget {
  final double fontSize;
  final String hintText;
  final TextInputType keyboardType;
  final TextAlign textAlign;

  const TicketTextField({
    super.key,
    this.fontSize = 16.0,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      keyboardType: keyboardType,
      style: ticketStyle.copyWith(
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      cursorColor: AppColors.textColor.withOpacity(0.6),
      cursorWidth: 1.5,
      cursorRadius: const Radius.circular(4.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        border: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textColor,
          ),
        ),
      ),
    );
  }
}
