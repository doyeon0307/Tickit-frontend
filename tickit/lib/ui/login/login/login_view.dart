import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/view/nav_bar.dart';
import 'package:tickit/ui/login/login/login_state.dart';
import 'package:tickit/ui/login/login/login_view_model.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginState state = ref.watch(loginViewModelProvider);
    ref.listen<LoginState>(
      loginViewModelProvider,
      (previous, next) {
        if (next.loginLoading == LoadingStatus.success && next.isLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const NavBar(),
            ),
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tickit!",
                    style: Typo.pretendardEB40.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "내 손으로 만드는 나만의 티켓북",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      // fontFamily: "Pretendard"
                    ),
                  ),
                ],
              ),
            ),
            const KakaoLoginWidget(),
            if (state.loginLoading == LoadingStatus.loading)
              const Center(
                child: CustomLoading(),
              ),
          ],
        ),
      ),
    );
  }
}

class KakaoLoginWidget extends ConsumerWidget {
  const KakaoLoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginViewModel viewModel = ref.read(loginViewModelProvider.notifier);

    return Align(
      alignment: const Alignment(0, 0.8),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Image.asset("assets/image/kakao_login.png"),
        ),
        onTap: () => viewModel.onTapKakao(),
      ),
    );
  }
}
