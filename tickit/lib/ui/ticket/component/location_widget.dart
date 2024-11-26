import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/ticket/component/ticket_text_field.dart';

class LocationWidget extends StatelessWidget {
  final bool isDetail;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Color color;

  const LocationWidget({
    super.key,
    required this.isDetail,
    required this.controller,
    required this.onChanged,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.location),
        const SizedBox(
          width: 4.0,
        ),
        IntrinsicWidth(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 5 / 12,
            ),
            child: TicketTextField(
              readOnly: isDetail,
              controller: controller,
              onChanged: onChanged,
              fontSize: 18.0,
              hintText: "장소를 입력하세요",
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
