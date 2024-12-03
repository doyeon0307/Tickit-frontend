import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/custom_dialog.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/schedule/schedule/component/row_form_widget.dart';
import 'package:tickit/ui/schedule/schedule/component/schedule_text_button_widget.dart';
import 'package:tickit/ui/schedule/schedule/component/schedule_text_form_field.dart';
import 'package:tickit/ui/schedule/schedule/component/schedule_title_text_form_field.dart';
import 'package:tickit/ui/schedule/schedule/view_model/schedule_view_model_provider.dart';

class ScheduleView extends HookConsumerWidget {
  final ScheduleMode mode;
  final DateTime date;
  final String? id;

  const ScheduleView({
    super.key,
    required this.mode,
    required this.date,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(scheduleViewModelProvider(mode).notifier);
    final state = ref.watch(scheduleViewModelProvider(mode));

    return DefaultLayout(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Center(
                child: Text(
                  "${date.year}년 ${date.month}월 ${date.day}일",
                  style: Typo.pretendardR22.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(
                bottom: 24.0,
              ),
              child: IntrinsicWidth(
                child: ScheduleTitleTextFormField(
                  onChanged: (p0) {},
                  hintText: "제목을 입력하세요",
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RowFormWidget(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    icon: Assets.image,
                    widget: Container(
                      height: 144.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: AppColors.strokeColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 144.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RowFormWidget(
                          icon: Assets.scheduleLocation,
                          widget: Expanded(
                            child: ScheduleTextFormField(
                              hintText: "장소",
                              onChanged: (p0) {},
                            ),
                          ),
                        ),
                        RowFormWidget(
                          icon: Assets.time,
                          widget: Expanded(
                            child: ScheduleTextFormField(
                              hintText: "시간",
                              onChanged: (p0) {},
                            ),
                          ),
                        ),
                        RowFormWidget(
                          icon: Assets.seat,
                          widget: Expanded(
                            child: ScheduleTextFormField(
                              hintText: "좌석",
                              onChanged: (p0) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            RowFormWidget(
              icon: Assets.casting,
              widget: Expanded(
                child: ScheduleTextFormField(
                  hintText: "출연진",
                  onChanged: (p0) {},
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RowFormWidget(
              icon: Assets.company,
              widget: Expanded(
                child: ScheduleTextFormField(
                  hintText: "함께 하는 사람",
                  onChanged: (p0) {},
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RowFormWidget(
              icon: Assets.link,
              widget: Expanded(
                child: ScheduleTextFormField(
                  hintText: "링크",
                  onChanged: (p0) {},
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RowFormWidget(
              icon: Assets.memo,
              widget: Expanded(
                child: ScheduleTextFormField(
                  hintText: "메모",
                  onChanged: (p0) {},
                  maxLines: null,
                ),
              ),
            ),
            const SizedBox(
              height: 52.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScheduleTextButtonWidget(
                  label: "삭제하기",
                  backgroundColor: AppColors.errorColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        title: "정말 삭제할까요?",
                        content: "삭제한 일정은 되돌릴 수 없습니다",
                        leftButtonLabel: "취소",
                        rightButtonLabel: "삭제",
                        onPressedLeftButton: () => Navigator.of(context).pop(),
                        onPressedRightButton: () {},
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 40.0,
                ),
                ScheduleTextButtonWidget(
                  label: "저장하기",
                  backgroundColor: AppColors.secondaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
