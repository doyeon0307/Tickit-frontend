import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/theme/ticket_typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/ticket_mode.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/ticket_view_model_provider.dart';

class AmTextButton extends ConsumerWidget {
  final TicketMode mode;
  final bool isAmButton;
  final String label;
  final VoidCallback onPressed;

  const AmTextButton({
    super.key,
    required this.mode,
    required this.isAmButton,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TicketState state = ref.watch(ticketViewModelProvider(mode));

    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(double.infinity),
        overlayColor: Colors.grey,
        backgroundColor: isAmButton == state.isAm ? AppColors.primaryColor : AppColors.fillColor,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: ticketStyle,
      ),
    );
  }
}
