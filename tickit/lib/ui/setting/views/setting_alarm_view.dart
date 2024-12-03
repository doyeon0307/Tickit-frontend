import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/setting/component/setting_divider_widget.dart';
import 'package:tickit/ui/setting/component/setting_text_widget.dart';
import 'package:tickit/ui/setting/setting_state.dart';
import 'package:tickit/ui/setting/setting_view_model.dart';

class SettingAlarmView extends ConsumerWidget {
  const SettingAlarmView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SettingViewModel viewModel =
        ref.read(settingViewModelProvider.notifier);
    final SettingState state = ref.watch(settingViewModelProvider);

    return DefaultLayout(
      appBar: AppBar(
        title: const Text("알림 설정"),
        titleTextStyle: Typo.pretendardR20.copyWith(color: AppColors.textColor),
        backgroundColor: Colors.transparent,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SettingTextWidget(
              title: "일정 알림",
              description: "일정 알림",
              onTap: () {},
              widget: CupertinoSwitch(
                value: state.scheduleAlarm,
                onChanged: (value) => viewModel.onTapScheduleAlarm(
                  value: value,
                ),
              ),
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "티켓 생성 알림",
              description: "완료된 일정을 티켓으로 만들 수 있도록 알림을 보내드려요",
              onTap: () {},
              widget: CupertinoSwitch(
                value: state.ticketAlarm,
                onChanged: (value) => viewModel.onTapTicketAlarm(
                  value: value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
