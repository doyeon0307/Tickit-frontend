import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/theme/ticket_typegraphies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/ticket_view_model.dart';

class AmTextButton extends ConsumerWidget {
  final bool isAmButton;
  final String label;
  final VoidCallback onPressed;

  const AmTextButton({
    super.key,
    required this.isAmButton,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TicketState state = ref.watch(ticketViewModelProvider);

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
