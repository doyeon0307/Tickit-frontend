import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/ticket/const/ticket_mode.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/view_model/ticket_view_model_provider.dart';

class TimeNumberPicker extends ConsumerWidget {
  final TicketMode mode;
  final bool isHour;
  final Function(int) onChanged;

  const TimeNumberPicker({
    super.key,
    required this.mode,
    required this.isHour,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TicketState state = ref.watch(ticketViewModelProvider(mode));

    return NumberPicker(
      itemWidth: 40.0,
      itemCount: 1,
      textStyle: Typo.gangwonR16,
      selectedTextStyle: Typo.gangwonR20,
      minValue: 0,
      maxValue: isHour ? 12 : 50,
      step: isHour ? 1 : 10,
      value: isHour ? state.hour : state.minute,
      onChanged: onChanged,
    );
  }
}
