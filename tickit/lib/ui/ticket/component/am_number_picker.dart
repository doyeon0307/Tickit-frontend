import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tickit/theme/text_style.dart';

class AmNumberPicker extends StatelessWidget {
  final bool am;

  const AmNumberPicker({
    super.key,
    required this.am,
  });

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      itemWidth: 40.0,
      itemCount: 1,
      textStyle: ticketStyle,
      selectedTextStyle: ticketStyle.copyWith(fontSize: 28.0),
      minValue: 0,
      maxValue: am ? 12 : 50,
      step: am ? 1 : 10,
      value: 0,
      onChanged: (value) {},
    );
  }
}
