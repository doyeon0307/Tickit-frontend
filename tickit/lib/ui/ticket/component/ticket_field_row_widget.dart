import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/ticket/component/ticket_text_field.dart';

class TicketFieldRowWidget extends StatelessWidget {
  const TicketFieldRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 3,
          ),
          child: IntrinsicWidth(
            child: TicketTextField(
              hintText: "소제목",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Text(
            " :  ",
            style: Typo.gangwonR16,
          ),
        ),
        Expanded(
          child: TicketTextField(
            hintText: "내용을 입력하세요",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 14.0,
            left: 4.0,
          ),
          child: SvgPicture.asset(
            Assets.xCircle,
            colorFilter: ColorFilter.mode(
              AppColors.textColor.withOpacity(0.8),
              BlendMode.srcIn,
            ),
          ),
        )
      ],
    );
  }
}
