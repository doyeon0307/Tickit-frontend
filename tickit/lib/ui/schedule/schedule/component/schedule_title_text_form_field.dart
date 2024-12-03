import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class ScheduleTitleTextFormField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final String? initialValue;
  final TextInputType? keyboardType;
  final int? maxLines;

  const ScheduleTitleTextFormField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      initialValue: initialValue,
      maxLines: maxLines,
      keyboardType: TextInputType.text,
      style: Typo.pretendardSB20.copyWith(
        color: AppColors.secondaryColor,
      ),
      onChanged: onChanged,
      textAlign: TextAlign.left,
      cursorColor: AppColors.textColor.withOpacity(0.6),
      cursorWidth: 1.5,
      cursorRadius: const Radius.circular(4.0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 8.0,
        ),
        hintText: hintText,
        hintStyle: Typo.pretendardR18.copyWith(
          color: AppColors.secondaryColor.withOpacity(0.5),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
