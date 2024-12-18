import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/domain/auth/logout_use_case.dart';
import 'package:tickit/domain/auth/withdraw_use_case.dart';
import 'package:tickit/domain/setting/get_user_info_use_case.dart';
import 'package:tickit/domain/setting/model/profile_model.dart';
import 'package:tickit/service/app/app_service.dart';
import 'package:tickit/ui/setting/setting_state.dart';

final settingViewModelProvider = StateNotifierProvider.autoDispose<SettingViewModel, SettingState>(
  (ref) => SettingViewModel(
    getUserInfoUseCase: ref.read(getUserInfoUseCaseProvider),
    appService: ref.watch(appServiceProvider.notifier),
    logoutUseCase: ref.read(logoutUseCaseProvider),
    withdrawUseCase: ref.read(withdrawUseCaseProvider),
  ),
);

class SettingViewModel extends StateNotifier<SettingState> {
  final GetUserInfoUseCase _getUserInfoUseCase;
  final AppService _appService;
  final LogoutUseCase _logoutUseCase;
  final WithdrawUseCase _withdrawUseCase;

  SettingViewModel({
    required GetUserInfoUseCase getUserInfoUseCase,
    required AppService appService,
    required LogoutUseCase logoutUseCase,
    required WithdrawUseCase withdrawUseCase,
  })  : _getUserInfoUseCase = getUserInfoUseCase,
        _appService = appService,
        _logoutUseCase = logoutUseCase,
        _withdrawUseCase = withdrawUseCase,
        super(SettingState());

  Future<void> getUserProfile() async {
    if (mounted) {
      state = state.copyWith(
        loadingStatus: LoadingStatus.loading,
        errorMsg: "",
      );
    }
    final result = await _getUserInfoUseCase();
    switch (result) {
      case SuccessUseCaseResult<ProfileModel>():
        if (mounted) {
          state = state.copyWith(
            loadingStatus: LoadingStatus.success,
            username: result.data.name,
          );
        }
      case FailureUseCaseResult<ProfileModel>():
        if (mounted) {
          state = state.copyWith(
            loadingStatus: LoadingStatus.error,
            errorMsg: "회원 정보 불러오기에 실패했어요",
          );
        }
    }
  }

  void onTapDarkMode({required bool value}) {
    if (mounted) {
      state = state.copyWith(darkMode: value);
    }
  }

  void onTapScheduleAlarm({required bool value}) {
    if (mounted) {
      state = state.copyWith(scheduleAlarm: value);
    }
  }

  void onTapTicketAlarm({required bool value}) {
    if (mounted) {
      state = state.copyWith(ticketAlarm: value);
    }
  }

  Future<void> onLogoutPressed() async {
    if (mounted) {
      state = state.copyWith(
        loadingStatus: LoadingStatus.loading,
        errorMsg: "",
      );
    }
    final result = await _logoutUseCase();
    switch (result) {
      case SuccessUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            loadingStatus: LoadingStatus.success,
          );
        }
      case FailureUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            loadingStatus: LoadingStatus.error,
            // errorMsg: "로그아웃에 실패했어요.",
          );
        }
    }
    await _appService.logout();
  }

  Future<void> onWithdrawPressed() async {
    if (mounted) {
      state = state.copyWith(
        loadingStatus: LoadingStatus.loading,
        errorMsg: "",
      );
    }
    final result = await _withdrawUseCase();
    switch (result) {
      case SuccessUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            loadingStatus: LoadingStatus.success,
          );
        }
      case FailureUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            loadingStatus: LoadingStatus.error,
            errorMsg: "회원 탈퇴에 실패했어요.",
          );
        }
    }
    await _appService.logout();
  }
}
