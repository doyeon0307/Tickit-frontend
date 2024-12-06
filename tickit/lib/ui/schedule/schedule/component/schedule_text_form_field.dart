import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class ScheduleTextFormField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final String initialValue;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final int? maxLines;

  const ScheduleTextFormField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.initialValue,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      initialValue: initialValue,
      readOnly: false,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: Typo.pretendardR14.copyWith(
        color: AppColors.secondaryColor,
      ),
      onChanged: onChanged,
      textAlign: textAlign,
      cursorColor: AppColors.textColor.withOpacity(0.6),
      cursorWidth: 1.5,
      cursorRadius: const Radius.circular(4.0),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(8.0),
        hintText: hintText,
        hintStyle: Typo.pretendardR12.copyWith(
          color: AppColors.strokeColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          borderSide: BorderSide(
            color: AppColors.strokeColor.withOpacity(0.8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
