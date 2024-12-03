import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class ScheduleTextFormField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final int? maxLines;
  final String? initialValue;

  const ScheduleTextFormField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.maxLines = 1,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      initialValue: initialValue,
      readOnly: false,
      maxLines: maxLines,
      keyboardType: TextInputType.text,
      style: Typo.pretendardR16.copyWith(
        color: AppColors.secondaryColor,
      ),
      onChanged: onChanged,
      textAlign: TextAlign.left,
      cursorColor: AppColors.textColor.withOpacity(0.6),
      cursorWidth: 1.5,
      cursorRadius: const Radius.circular(4.0),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(8.0),
        hintText: hintText,
        hintStyle: Typo.pretendardR16.copyWith(
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
