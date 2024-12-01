import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/setting/component/setting_divider_widgtet.dart';
import 'package:tickit/ui/setting/component/setting_text_widget.dart';

class SettingAlarmView extends StatelessWidget {
  const SettingAlarmView({super.key});

  @override
  Widget build(BuildContext context) {
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
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "티켓 생성 알림",
              description: "완료된 일정을 티켓으로 만들 수 있도록 알림을 보내드려요",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
