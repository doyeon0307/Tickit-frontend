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

final loginViewModelProvider = StateNotifierProvider.autoDispose(
  (ref) => LoginViewModel(
    appService: ref.read(appServiceProvider.notifier),
    kakaoLoginUseCase: ref.read(kakaoLoginUseCaseProvider),
    kakaoRegisterUseCase: ref.refresh(kakaoRegisterUseCaseProvider),
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
      try {
        OAuthToken resp = await UserApi.instance.loginWithKakaoTalk();
        debugPrint(
            '카카오톡으로 로그인 성공 : access: ${resp.accessToken}, refresh: ${resp.refreshToken}, id: ${resp.idToken}');
        kakaoLogin(
          accessToken: resp.accessToken,
          idToken: resp.accessToken,
          refreshToken: resp.refreshToken ?? "",
        );
      } catch (error) {
        debugPrint('카카오톡으로 로그인 실패 $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // try {
        //   await UserApi.instance.loginWithKakaoAccount();
        //   debugPrint('카카오톡 계정으로 로그인 성공');
        // } catch (error) {
        //   debugPrint('카카오계정으로 로그인 실패');
        // }
      }
    } else {
      // try {
      //   OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      //   debugPrint('카카오계정으로 로그인 성공: ${token.accessToken}');
      // } catch (error) {
      //   debugPrint('카카오계정으로 로그인 실패 $error');
      // }
    }
  }

  Future<void> kakaoLogin({
    required String accessToken,
    required String idToken,
    required String refreshToken,
  }) async {
    state = state.copyWith(loginLoading: LoadingStatus.loading);

    final UseCaseResult<AuthTokensEntity> loginResult =
        await _kakaoLoginUseCase(
      accessToken: accessToken,
      idToken: idToken,
      refreshToken: refreshToken,
    );

    switch (loginResult) {
      case SuccessUseCaseResult<AuthTokensEntity>():
        if (mounted) {
          state = state.copyWith(loginLoading: LoadingStatus.success);
          await _appService.login(tokens: loginResult.data);
        }
      case FailureUseCaseResult<AuthTokensEntity>():
        if (loginResult.statusCode == 404) {
          final UseCaseResult<AuthTokensEntity> registerResult =
              await _kakaoRegisterUseCase(
            accessToken: accessToken,
            idToken: idToken,
            refreshToken: refreshToken,
          );

          switch (registerResult) {
            case SuccessUseCaseResult<AuthTokensEntity>():
              if (mounted) {
                state = state.copyWith(loginLoading: LoadingStatus.success);
              }
              await _appService.login(tokens: registerResult.data);
            case FailureUseCaseResult<AuthTokensEntity>():
          }
        }
        state = state.copyWith(
          loginLoading: LoadingStatus.error,
          loginErrMsg: loginResult.message ?? "unknownError".tr(),
        );
    }
  }
}
