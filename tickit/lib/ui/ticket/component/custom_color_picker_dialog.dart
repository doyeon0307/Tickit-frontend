import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/theme/ticket_typographies.dart';
import 'package:tickit/ui/common/component/custom_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/base_ticket_view_model.dart';
import 'package:tickit/ui/ticket/ticket_mode.dart';
import 'package:tickit/ui/ticket/ticket_view_model_provider.dart';

class CustomColorPickerDialog extends ConsumerWidget {
  final TicketMode mode;
  final bool isBackground;
  final String title;

  const CustomColorPickerDialog({
    super.key,
    required this.mode,
    required this.isBackground,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BaseTicketViewModel viewModel =
    ref.watch(ticketViewModelProvider(mode).notifier);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
      ),
      titleTextStyle: ticketStyle.copyWith(
        fontSize: 24.0,
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16.0,
      ),
      backgroundColor: AppColors.backgroundColor,
      title: Text(title),
      content: BlockPicker(
        pickerColor: Colors.white,
        onColorChanged: (value) => isBackground
            ? viewModel.onBackgroundColorChanged(newColor: value)
            : viewModel.onForegroundColorChanged(newColor: value),
      ),
      actions: [
        CustomTextButton(
          label: "선택",
          textStyle: ticketStyle,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}