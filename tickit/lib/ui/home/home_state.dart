import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/data/ticket/entity/ticket_preview_entity.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(LoadingStatus.none) LoadingStatus initLoading,
    @Default([]) List<TicketPreviewEntity> previews,
    @Default("") String errorMsg,
    @Default("") String successMsg,
  }) = _HomeState;
}