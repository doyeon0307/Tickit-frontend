import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickit/core/loading_status.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isLoggedIn,
    @Default(LoadingStatus.none) LoadingStatus loading,
  }) = _AppState;
}
