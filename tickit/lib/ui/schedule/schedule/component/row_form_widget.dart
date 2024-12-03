import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RowFormWidget extends StatelessWidget {
  final String icon;
  final Widget widget;
  final CrossAxisAlignment crossAxisAlignment;

  const RowFormWidget({
    super.key,
    required this.icon,
    required this.widget,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(
          width: 4.0,
        ),
        widget,
      ],
    );
  }
}
