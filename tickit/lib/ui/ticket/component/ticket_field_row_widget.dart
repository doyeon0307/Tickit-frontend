import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/ticket/component/ticket_text_field.dart';
import 'package:tickit/ui/ticket/const/ticket_mode.dart';
import 'package:tickit/ui/ticket/view_model/ticket_view_model_provider.dart';

class TicketFieldRowWidget extends ConsumerWidget {
  final TicketMode mode;
  final int index;
  final Color color;
  final String? subTitleInitialValue;
  final String? contentInitialValue;

  const TicketFieldRowWidget({
    super.key,
    required this.mode,
    required this.index,
    required this.color,
    this.subTitleInitialValue,
    this.contentInitialValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(ticketViewModelProvider(mode).notifier);

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
              onChanged: (value) => viewModel.updateFieldTitle(
                index: index,
                text: value,
              ),
              readOnly: mode == TicketMode.detail ? true : false,
              initialValue: subTitleInitialValue,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Text(
            " :  ",
            style: Typo.gangwonR16.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ),
        Expanded(
          child: TicketTextField(
            hintText: "내용을 입력하세요",
            onChanged: (value) => viewModel.updateFieldContent(
              index: index,
              text: value,
            ),
            readOnly: mode == TicketMode.detail ? true : false,
            initialValue: contentInitialValue,
            color: color,
          ),
        ),
        if (!(mode == TicketMode.detail))
          Padding(
            padding: const EdgeInsets.only(
              top: 14.0,
              left: 4.0,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => viewModel.removeField(index: index),
                borderRadius: BorderRadius.circular(100.0),
                child: SvgPicture.asset(
                  Assets.xCircle,
                  colorFilter: ColorFilter.mode(
                    color.withOpacity(0.8),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
