import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/service/app/app_service.dart';
import 'package:tickit/ui/login/splash/splash_state.dart';

final splashViewModelProvider =
    StateNotifierProvider.autoDispose<SplashViewModel, SplashState>(
  (ref) => SplashViewModel(
    appService: ref.read(appServiceProvider.notifier),
  ),
);

class SplashViewModel extends StateNotifier<SplashState> {
  final AppService _appService;

  SplashViewModel({
    required AppService appService,
  })  : _appService = appService,
        super(const SplashState());

  Future<void> checkLogin() async {
    debugPrint("로그인 상태를 확인합니다");
    state = state.copyWith(loginCheckLoading: LoadingStatus.loading);

    await Future.wait([
      _appService.initialize(),
      Future.delayed(const Duration(seconds: 2)),
    ]);

    if (mounted) {
      state = state.copyWith(
        loginCheckLoading: LoadingStatus.success,
        isLoggedIn: _appService.isLoggedIn,
      );
      debugPrint("로그인 상태 확인 완료: ${state.isLoggedIn}");
    }
  }
}
