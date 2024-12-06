import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickit/core/loading_status.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(LoadingStatus.none) LoadingStatus loginCheckLoading,
    @Default(false) bool isLoggedIn,
  }) = _SplashState;
}
