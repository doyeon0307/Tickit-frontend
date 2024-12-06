import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/ui/common/const/mode.dart';

part 'schedule_state.freezed.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    @Default(ScheduleMode.none) mode,
    @Default(LoadingStatus.none) loadingInitView,
    @Default(LoadingStatus.none) loadingSave,
    @Default(null) DateTime? date,
    @Default("") String title,
    @Default(null) XFile? image,
    @Default("") String networkImage,
    @Default("") String location,
    @Default(true) bool isAM,
    @Default("") String hour,
    @Default("") String minute,
    @Default("") String seat,
    @Default("") String casting,
    @Default("") String company,
    @Default("") String link,
    @Default("") String memo,
    @Default("") String errorMsg,
    @Default("") String successMsg,
  }) = _ScheduleState;
}
