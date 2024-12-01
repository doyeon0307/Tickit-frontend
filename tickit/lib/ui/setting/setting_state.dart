import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickit/core/loading_status.dart';

part 'setting_state.freezed.dart';

@freezed
class SettingState with _$SettingState {
  factory SettingState({
    @Default(LoadingStatus.none) LoadingStatus loadingStatus,
    @Default("") String username,
    @Default("") String errorMsg,
    @Default("") String successMsg,
  })= _SettingState;
}
