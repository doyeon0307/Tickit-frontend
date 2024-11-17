import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/core/use_case/use_case_result.dart';
import 'package:tickit/data/ticket/entity/ticket_preview_entity.dart';
import 'package:tickit/domain/ticket/get_ticket_previews_use_case.dart';
import 'package:tickit/ui/home/home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
    getTicketPreviewsUseCase: ref.read(getTicketPreviewsUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final GetTicketPreviewsUseCase _getTicketPreviewsUseCase;

  HomeViewModel({
    required GetTicketPreviewsUseCase getTicketPreviewsUseCase,
  })  : _getTicketPreviewsUseCase = getTicketPreviewsUseCase,
        super(HomeState());

  Future<void> initView() async {
    if (mounted) {
      state = state.copyWith(
        initLoading: LoadingStatus.loading,
        errorMsg: "",
      );
    }
    final result = await _getTicketPreviewsUseCase();

    switch (result) {
      case SuccessUseCaseResult<List<TicketPreviewEntity>>():
        if (mounted) {
          state = state.copyWith(
            previews: result.data,
            initLoading: LoadingStatus.success,
          );
        }
      case FailureUseCaseResult<List<TicketPreviewEntity>>():
        if (mounted) {
          state = state.copyWith(
            errorMsg: "작성한 티켓 불러오기에 실패했어요. 다시 시도해주세요.",
            initLoading: LoadingStatus.error,
          );
          debugPrint("티켓 목록 불러오기 실패: ${result.message}");
        }
    }
  }
}
