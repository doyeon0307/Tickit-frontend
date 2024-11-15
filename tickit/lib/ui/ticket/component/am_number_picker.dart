import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tickit/theme/ticket_typographies.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/ticket_view_model.dart';

class TimeNumberPicker extends ConsumerWidget {
  final bool isHour;
  final Function(int) onChanged;

  const TimeNumberPicker({
    super.key,
    required this.isHour,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TicketState state = ref.watch(ticketViewModelProvider);

    return NumberPicker(
      itemWidth: 40.0,
      itemCount: 1,
      textStyle: ticketStyle,
      selectedTextStyle: ticketStyle.copyWith(fontSize: 28.0),
      minValue: 0,
      maxValue: isHour ? 12 : 50,
      step: isHour ? 1 : 10,
      value: isHour ? state.hour : state.minute,
      onChanged: onChanged,
    );
  }
}
