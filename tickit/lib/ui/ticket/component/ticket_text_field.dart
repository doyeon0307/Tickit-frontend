import 'package:flutter/material.dart';
import 'package:tickit/theme/ticket_typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class TicketTextField extends StatelessWidget {
  final double fontSize;
  final String hintText;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  Color? color;
  Function(String)? onChanged;
  TextEditingController? controller;
  bool readOnly;

  TicketTextField({
    super.key,
    this.fontSize = 16.0,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.color,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      maxLines: null,
      keyboardType: keyboardType,
      style: ticketStyle.copyWith(
        fontSize: fontSize,
        color: color ?? AppColors.textColor,
      ),
      onChanged: onChanged,
      textAlign: textAlign,
      cursorColor: AppColors.textColor.withOpacity(0.6),
      cursorWidth: 1.5,
      cursorRadius: const Radius.circular(4.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        border: InputBorder.none,
        focusedBorder: readOnly
            ? InputBorder.none
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.textColor,
                ),
              ),
      ),
    );
  }
}