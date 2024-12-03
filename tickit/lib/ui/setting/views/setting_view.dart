import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/error_snack_bar.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/setting/component/setting_divider_widget.dart';
import 'package:tickit/ui/setting/component/setting_text_widget.dart';
import 'package:tickit/ui/setting/setting_state.dart';
import 'package:tickit/ui/setting/setting_view_model.dart';
import 'package:tickit/ui/setting/views/setting_account_view.dart';
import 'package:tickit/ui/setting/views/setting_alarm_view.dart';
import 'package:tickit/ui/setting/views/setting_csr_view.dart';

class SettingView extends HookConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SettingViewModel viewModel =
        ref.read(settingViewModelProvider.notifier);
    final SettingState state = ref.watch(settingViewModelProvider);

    useEffect(() {
      Future(() => viewModel.getUserProfile());
      return null;
    }, []);

    useEffect(() {
      if (state.errorMsg.isNotEmpty) {
        Future.microtask(
          () => ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(message: state.errorMsg),
          ),
        );
      }
      return null;
    }, [state.errorMsg]);

    return DefaultLayout(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "전도연",
                style: Typo.pretendardR20.copyWith(color: AppColors.textColor),
              ),
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "다크 모드",
              description: "다크 모드를 켜고 끌 수 있어요",
              onTap: () {},
              widget: CupertinoSwitch(
                value: state.darkMode,
                onChanged: (value) => viewModel.onTapDarkMode(value: value),
              ),
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "광고제거",
              description: "평생 광고없이 이용할 수 있어요",
              onTap: () {},
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "알림설정",
              description: "일정 및 티켓 생성",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingAlarmView(),
                ),
              ),
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "고객센터",
              description: "도움말 및 신고",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingCsrView(),
                ),
              ),
            ),
            const SettingDividerWidgtet(),
            SettingTextWidget(
              title: "계정관리",
              description: "로그아웃 및 탈퇴",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingAccountView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
