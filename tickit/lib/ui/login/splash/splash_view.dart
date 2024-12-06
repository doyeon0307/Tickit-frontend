import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/common/view/nav_bar.dart';
import 'package:tickit/ui/login/login/login_view.dart';
import 'package:tickit/ui/login/splash/splash_state.dart';
import 'package:tickit/ui/login/splash/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashViewModelProvider.notifier).checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SplashState>(
      splashViewModelProvider,
      (previous, next) {
        if (next.loginCheckLoading == LoadingStatus.success) {
          if (next.isLoggedIn) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NavBar(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ),
            );
          }
        }
      },
    );

    return DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tickit!",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 40.0,
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
            const SizedBox(
              height: 20.0,
            ),
            const CustomLoading(),
          ],
        ),
      ),
    );
  }
}
