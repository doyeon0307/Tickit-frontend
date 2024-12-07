import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/ticket/component/field_text_form_field.dart';

class TicketFieldRowWidget extends ConsumerWidget {
  final TicketMode mode;
  final int index;
  final Color color;
  final void Function({required int index, required String text}) updateFieldTitle;
  final void Function({required int index, required String text}) updateFieldContent;
  final Function removeField;
  final String? subTitleInitialValue;
  final String? contentInitialValue;

  const TicketFieldRowWidget({
    super.key,
    required this.mode,
    required this.index,
    required this.color,
    required this.updateFieldTitle,
    required this.updateFieldContent,
    required this.removeField,
    this.subTitleInitialValue,
    this.contentInitialValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 3,
          ),
          child: IntrinsicWidth(
            child: FieldTextFormField(
              hintText: "소제목",
              onChanged: (value) => updateFieldTitle(
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
              color: color,
            ),
          ),
        ),
        Expanded(
          child: FieldTextFormField(
            hintText: "내용을 입력하세요",
            onChanged: (value) => updateFieldContent(
              index: index,
              text: value,
            ),
            readOnly: mode == TicketMode.detail ? true : false,
            initialValue: contentInitialValue,
            color: color,
            keyboardType: TextInputType.multiline,
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
                onTap: () => removeField(index: index),
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
