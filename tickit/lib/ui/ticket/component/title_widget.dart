import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/ticket/component/ticket_text_field.dart';

class TitleWidget extends ConsumerWidget {
  final bool isDetail;
  final Function(String?) onChanged;
  final Color color;
  final String? initialValue;

  const TitleWidget({
    super.key,
    required this.isDetail,
    required this.onChanged,
    required this.color,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          Assets.leftTitleDeco,
          width: MediaQuery.of(context).size.width / 4,
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: TicketTextField(
              readOnly: isDetail,
              initialValue: initialValue,
              onChanged: onChanged,
              fontSize: 20.0,
              hintText: "제목을 입력하세요",
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              color: color,
            ),
          ),
        ),
        SvgPicture.asset(
          Assets.rightTitleDeco,
          width: MediaQuery.of(context).size.width / 4,
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
