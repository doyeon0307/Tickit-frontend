import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/auth/entity/auth_tokens_entity.dart';
import 'package:tickit/domain/auth/kakao_login_use_case.dart';
import 'package:tickit/domain/auth/kakao_register_use_case.dart';
import 'package:tickit/service/app/app_service.dart';
import 'package:tickit/ui/login/login/login_state.dart';

final loginViewModelProvider = StateNotifierProvider.autoDispose<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(
    appService: ref.read(appServiceProvider.notifier),
    kakaoLoginUseCase: ref.read(kakaoLoginUseCaseProvider),
    kakaoRegisterUseCase: ref.read(kakaoRegisterUseCaseProvider),
  ),
);

class LoginViewModel extends StateNotifier<LoginState> {
  final AppService _appService;
  final KakaoLoginUseCase _kakaoLoginUseCase;
  final KakaoRegisterUseCase _kakaoRegisterUseCase;

  LoginViewModel({
    required AppService appService,
    required KakaoLoginUseCase kakaoLoginUseCase,
    required KakaoRegisterUseCase kakaoRegisterUseCase,
  })  : _appService = appService,
        _kakaoLoginUseCase = kakaoLoginUseCase,
        _kakaoRegisterUseCase = kakaoRegisterUseCase,
        super(const LoginState());

  Future<void> onTapKakao() async {
    bool isInstalled = await isKakaoTalkInstalled();
    if (isInstalled) {
      debugPrint("카카오톡 앱으로 로그인합니다");
      try {
        OAuthToken resp = await UserApi.instance.loginWithKakaoTalk();
        debugPrint("카카오톡으로 로그인 성공");
        kakaoLogin(
          accessToken: resp.accessToken,
          idToken: resp.idToken ?? "",
          refreshToken: resp.refreshToken ?? "",
        );
      } catch (error) {
        debugPrint('카카오톡으로 로그인 실패 $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        try {
          final resp = await UserApi.instance.loginWithKakaoAccount();
          debugPrint("카카오톡으로 로그인 성공");
          kakaoLogin(
            accessToken: resp.accessToken,
            idToken: resp.idToken ?? "",
            refreshToken: resp.refreshToken ?? "",
          );
        } catch (error) {
          debugPrint('카카오계정으로 로그인 실패');
        }
      }
    } else {
      debugPrint("카카오 계정으로 로그인합니다");
      try {
        final resp = await UserApi.instance.loginWithKakaoAccount();
        debugPrint('카카오 계정으로 로그인 성공:\n \taccess: ${resp.accessToken},\n \trefresh: ${resp.refreshToken},\n \tid: ${resp.idToken}');
        kakaoLogin(
          accessToken: resp.accessToken,
          idToken: resp.idToken ?? "",
          refreshToken: resp.refreshToken ?? "",
        );
      } catch (error) {
        debugPrint('카카오 계정으로 로그인 실패');
      }
    }
  }

  Future<void> kakaoLogin({
    required String accessToken,
    required String idToken,
    required String refreshToken,
  }) async {
    if (!mounted) return;
    state = state.copyWith(loginLoading: LoadingStatus.loading);

    debugPrint("카카오 토큰으로 앱 로그인을 시도합니다");
    final UseCaseResult<AuthTokensEntity> loginResult = await _kakaoLoginUseCase(
      accessToken: accessToken,
      idToken: idToken,
      refreshToken: refreshToken,
    );

    if (!mounted) return;

    switch (loginResult) {
      case SuccessUseCaseResult<AuthTokensEntity>():
        if (mounted) {
          debugPrint("앱 로그인에 성공했습니다");
          await _appService.login(tokens: loginResult.data);
          state = state.copyWith(
            loginLoading: LoadingStatus.success,
            isLoggedIn: _appService.isLoggedIn,
          );
        }
      case FailureUseCaseResult<AuthTokensEntity>():
        if (loginResult.statusCode == 404) {
          debugPrint("존재하지 않는 회원이므로 회원가입을 시도합니다");

          if (!mounted) return;

          final UseCaseResult<AuthTokensEntity> registerResult = await _kakaoRegisterUseCase(
            accessToken: accessToken,
            idToken: idToken,
            refreshToken: refreshToken,
          );

          switch (registerResult) {
            case SuccessUseCaseResult<AuthTokensEntity>():
              if (mounted) {
                await _appService.login(tokens: registerResult.data);
                state = state.copyWith(
                  loginLoading: LoadingStatus.success,
                  isLoggedIn: _appService.isLoggedIn,
                );
              }
            case FailureUseCaseResult<AuthTokensEntity>():
              if (mounted) {
                state = state.copyWith(
                  loginLoading: LoadingStatus.error,
                  loginErrMsg: loginResult.message ?? "unknownError".tr(),
                );
              }
          }
        } else {
          if (mounted) {
            state = state.copyWith(
              loginLoading: LoadingStatus.error,
              loginErrMsg: loginResult.message ?? "unknownError".tr(),
            );
          }
        }
    }
  }
}
