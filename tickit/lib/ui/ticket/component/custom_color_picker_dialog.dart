import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/ticket/component/ticket_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/assets.dart';

class CustomColorPickerDialog extends ConsumerStatefulWidget {
  final String title;
  final Color color;
  final Function(Color) onColorChanged;

  const CustomColorPickerDialog({
    super.key,
    required this.title,
    required this.color,
    required this.onColorChanged,
  });

  @override
  ConsumerState<CustomColorPickerDialog> createState() => _CustomColorPickerDialogState();
}

class _CustomColorPickerDialogState extends ConsumerState<CustomColorPickerDialog> {
  bool isBlockMode = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
      ),
      titleTextStyle: Typo.gangwonR24.copyWith(
        color: AppColors.textColor,
        height: 1.0,
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16.0,
      ),
      backgroundColor: AppColors.backgroundColor,
      title: Row(
        children: [
          Text(widget.title),
          IconButton(
            onPressed: () => setState(() {
              isBlockMode = !isBlockMode;
            }),
            icon: SvgPicture.asset(
              Assets.droplet,
              width: 20.0,
              height: 20.0,
              colorFilter: ColorFilter.mode(
                AppColors.secondaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      content: isBlockMode
          ? SizedBox(
              height: 460.0,
              child: BlockPicker(
                pickerColor: widget.color,
                onColorChanged: widget.onColorChanged,
              ),
            )
          : SizedBox(
              height: 460.0,
              child: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: widget.color,
                  onColorChanged: widget.onColorChanged,
                ),
              ),
            ),
      actions: [
        TicketTextButton(
          label: "선택",
          textStyle: Typo.gangwonR16.copyWith(
            color: AppColors.textColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
