import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/custom_dialog.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/login/login/login_view.dart';
import 'package:tickit/ui/setting/component/setting_divider_widget.dart';
import 'package:tickit/ui/setting/component/setting_text_widget.dart';
import 'package:tickit/ui/setting/setting_view_model.dart';

class SettingAccountView extends ConsumerWidget {
  const SettingAccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(settingViewModelProvider.notifier);

    return DefaultLayout(
      appBar: AppBar(
        title: const Text("계정관리"),
        titleTextStyle: Typo.pretendardR20.copyWith(color: AppColors.textColor),
        backgroundColor: Colors.transparent,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SettingTextWidget(
              title: "로그아웃",
              description: "로그아웃합니다",
              onTap: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: "정말 로그아웃 할까요?",
                    content: "로그인 화면으로 이동합니다",
                    leftButtonLabel: "취소하기",
                    rightButtonLabel: "로그아웃",
                    onPressedLeftButton: () => Navigator.of(context).pop(),
                    onPressedRightButton: () async {
                      await viewModel.onLogoutPressed();
                      if (context.mounted) {
                        Navigator.of(context).pop(true);
                      }
                    },
                  ),
                );
                if (result != null && result && context.mounted) {
                  pushReplacementWithoutNavBar(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                }
              },
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "회원 탈퇴",
              description: "소중한 기록과..추억이...모두 사라져요......",
              onTap: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: "정말 탈퇴하시겠어요?🥲",
                    content: "모든 계정 정보가 삭제됩니다",
                    leftButtonLabel: "취소하기",
                    rightButtonLabel: "탈퇴하기",
                    onPressedLeftButton: () => Navigator.of(context).pop(),
                    onPressedRightButton: () async {
                      await viewModel.onWithdrawPressed();
                      if (context.mounted) {
                        Navigator.of(context).pop(true);
                      }
                    },
                  ),
                );
                if (result != null && result && context.mounted) {
                  pushReplacementWithoutNavBar(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
