import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickit/core/loading_status.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoadingStatus.none) LoadingStatus loginLoading,
    @Default(false) bool isLoggedIn,
    @Default("") String loginErrMsg,
  }) = _LoginState;
}
