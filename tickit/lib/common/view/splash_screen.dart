import 'package:flutter/material.dart';
import 'package:tickit/common/component/custom_loading.dart';
import 'package:tickit/common/const/app_colors.dart';
import 'package:tickit/common/layout/default_layout.dart';
import 'package:tickit/common/view/nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    delayed();
  }

  Future<void> delayed() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const NavBar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
