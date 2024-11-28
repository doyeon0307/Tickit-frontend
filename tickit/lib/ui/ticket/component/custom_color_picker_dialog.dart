import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/custom_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/view_model/base_ticket_view_model.dart';
import 'package:tickit/ui/ticket/const/ticket_mode.dart';
import 'package:tickit/ui/ticket/view_model/ticket_view_model_provider.dart';

class CustomColorPickerDialog extends ConsumerStatefulWidget {
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
  ConsumerState<CustomColorPickerDialog> createState() =>
      _CustomColorPickerDialogState();
}

class _CustomColorPickerDialogState
    extends ConsumerState<CustomColorPickerDialog> {
  bool isBlockMode = false;

  @override
  Widget build(BuildContext context) {
    final TicketState state = ref.watch(ticketViewModelProvider(widget.mode));
    final BaseTicketViewModel viewModel =
        ref.read(ticketViewModelProvider(widget.mode).notifier);

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
                pickerColor: widget.isBackground
                    ? state.backgroundColor
                    : state.foregroundColor,
                onColorChanged: (value) => widget.isBackground
                    ? viewModel.onBackgroundColorChanged(newColor: value)
                    : viewModel.onForegroundColorChanged(newColor: value),
              ),
          )
          : SizedBox(
            height: 460.0,
            child: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: widget.isBackground
                    ? state.backgroundColor
                    : state.foregroundColor,
                onColorChanged: (value) => widget.isBackground
                    ? viewModel.onBackgroundColorChanged(newColor: value)
                    : viewModel.onForegroundColorChanged(newColor: value),
              ),
            ),
          ),
      actions: [
        CustomTextButton(
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
