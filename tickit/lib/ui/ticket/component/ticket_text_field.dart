import 'package:flutter/material.dart';
import 'package:tickit/theme/text_style.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class TicketTextField extends StatelessWidget {
  final double fontSize;
  final String hintText;
  final TextInputType keyboardType;

  const TicketTextField({
    super.key,
    required this.fontSize,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      keyboardType: keyboardType,
      style: ticketStyle.copyWith(
        fontSize: fontSize,
      ),
      textAlign: hintText == "제목을 입력하세요" ? TextAlign.center : TextAlign.start,
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
