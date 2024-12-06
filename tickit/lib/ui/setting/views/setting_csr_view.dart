import 'package:flutter/material.dart';
import 'package:tickit/core/util/url_launcher_encoder.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/common/component/setting_divider_widget.dart';
import 'package:tickit/ui/setting/component/setting_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
            const CustomDivider(),
            SettingTextWidget(
              title: "버그 신고",
              description: "불편을 드려 죄송합니다. 신고해주시면 빠르게 해결해드리겠습니다.",
              onTap: () {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'tickit@example.com',
                  query: encodeQueryParameters(<String, String>{
                    "subject": "[Tickit!][버그] ",
                    "body": "겪으신 문제점을 알려주세요! 빠른 시일 내에 해결하겠습니다.\n\n"
                        "   문제가 발성한 화면: \n\n   사용 하려던 기능: \n\n   기타: \n\n"
                        "\n\n"
                        "다음의 내용을 작성해주시면 개발자가 문제점을 더 정확하게 알 수 있습니다.\n\n"
                        "   휴대폰 기종: \n\n   휴대폰 운영체제 버전: "
                  }),
                );
                launchUrl(emailLaunchUri);
              },
            ),
            const CustomDivider(),
            SettingTextWidget(
              title: "고객의 소리",
              description: "고객님의 의견은 서비스 개선에 큰 도움이 됩니다.",
              onTap: () {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'tickit@example.com',
                  query: encodeQueryParameters(<String, String>{
                    "subject": "[Tickit!][건의사항] ",
                    "body": "개발자에게 전달하고 싶은 내용을 자유롭게 작성해주세요! 고객님의 의견은 모두 소중합니다.\n\n"
                  }),
                );
                launchUrl(emailLaunchUri);
              },
            ),
          ],
        ),
      ),
    );
  }
}
