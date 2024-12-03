import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickit/ui/schedule/schedule/schedule_state.dart';

abstract class BaseScheduleViewModel extends StateNotifier<ScheduleState> {
  BaseScheduleViewModel() : super(const ScheduleState());

  // // create
  // void initState();
  //
  // void onPressedCancel();
  //
  // Future<void> onPressedSave();
  //
  // // detail
  // Future<void> initDetailView({required String id});
  //
  // Future<void> onTapDelete({required String id});
  //
  // void onTapEditButton();
}
