import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/ticket/component/ticket_text_field.dart';

class LocationWidget extends StatelessWidget {
  final bool isDetail;
  final Function(String) onChanged;
  final Color color;
  final String? initialValue;

  const LocationWidget({
    super.key,
    required this.isDetail,
    required this.onChanged,
    required this.color,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.location,
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(
          width: 4.0,
        ),
        IntrinsicWidth(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 3,
            ),
            child: TicketTextField(
              readOnly: isDetail,
              initialValue: initialValue,
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
