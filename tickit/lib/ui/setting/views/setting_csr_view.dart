import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/setting/component/setting_divider_widgtet.dart';
import 'package:tickit/ui/setting/component/setting_text_widget.dart';

class SettingCsrView extends StatelessWidget {
  const SettingCsrView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        title: const Text("고객센터"),
        titleTextStyle: Typo.pretendardR20.copyWith(color: AppColors.textColor),
        backgroundColor: Colors.transparent,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SettingTextWidget(
              title: "도움말",
              description: "사용방법을 설명하는 사이트로 연결됩니다.",
              onTap: () {},
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "버그 신고",
              description: "불편을 드려 죄송합니다. 신고해주시면 빠르게 해결해드리겠습니다.",
              onTap: () {},
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "고객의 소리",
              description: "고객님의 의견은 서비스 개선에 큰 도움이 됩니다.",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
