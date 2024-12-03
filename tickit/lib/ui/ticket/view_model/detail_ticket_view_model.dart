import 'package:flutter/material.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/domain/ticket/delete_ticket_use_case.dart';
import 'package:tickit/domain/ticket/get_ticket_detail_use_case.dart';
import 'package:tickit/domain/ticket/get_ticket_previews_use_case.dart';
import 'package:tickit/domain/ticket/model/ticket_model.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/ticket/view_model/base_ticket_view_model.dart';

class DetailTicketViewModel extends BaseTicketViewModel {
  final GetTicketDetailUseCase _getTicketDetailUseCase;
  final DeleteTicketUseCase _deleteTicketUseCase;

  DetailTicketViewModel({
    required GetTicketDetailUseCase getTicketDetailUseCase,
    required DeleteTicketUseCase deleteTicketUseCase,
    required GetTicketPreviewsUseCase getTicketPreviewsUseCase,
  })  : _getTicketDetailUseCase = getTicketDetailUseCase,
        _deleteTicketUseCase = deleteTicketUseCase;

  @override
  Future<void> initDetailView({
    required String id,
  }) async {
    if (mounted) {
      state = state.copyWith(
        initLoading: LoadingStatus.loading,
        errorMsg: "",
        mode: TicketMode.detail,
      );
    }
    final UseCaseResult<TicketModel> result =
        await _getTicketDetailUseCase(id: id);

    switch (result) {
      case SuccessUseCaseResult<TicketModel>():
        final data = result.data;
        if (mounted) {
          state = state.copyWith(
              initLoading: LoadingStatus.success,
              networkImage: data.image,
              title: data.title,
              location: data.location,
              dateTime: data.datetime,
              fields: data.fields,
              fieldCount: data.fields.length,
            backgroundColor: Color(int.parse(data.backgroundColor)),
            foregroundColor: Color(int.parse(data.foregroundColor)),
          );
        }
      case FailureUseCaseResult<TicketModel>():
        if (mounted) {
          state = state.copyWith(
            errorMsg: "티켓 불러오기에 실패했어요. 다시 시도해주세요.",
            initLoading: LoadingStatus.error,
          );
          debugPrint("티켓 목록 불러오기 실패: ${result.message}");
        }
    }
  }

  @override
  Future<void> onTapDelete({
    required String id,
  }) async {
    if (mounted) {
      state = state.copyWith(errorMsg: "");
    }

    final UseCaseResult<String> result = await _deleteTicketUseCase(id: id);

    switch (result) {
      case SuccessUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(
            isDeleted: true,
            successMsg: "티켓이 삭제되었습니다.",
          );
        }
      case FailureUseCaseResult<String>():
        if (mounted) {
          state = state.copyWith(errorMsg: "티켓 삭제에 실패했습니다. 다시 시도해주세요.");
        }
        return;
    }
  }

  @override
  void onPressedCancel() {
    state = state.copyWith(mode: TicketMode.detail);
  }

  @override
  void onTapEditButton() {
    state = state.copyWith(mode: TicketMode.edit);
  }

  @override
  void initState() {
    throw UnimplementedError();
  }

  @override
  Future<void> onPressedSave() {
    throw UnimplementedError();
  }
}
