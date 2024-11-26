import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/component/error_snack_bar.dart';
import 'package:tickit/ui/common/component/success_snack_bar.dart';
import 'package:tickit/ui/ticket/view_model/base_ticket_view_model.dart';
import 'package:tickit/ui/ticket/component/calendar_widget.dart';
import 'package:tickit/ui/ticket/component/deco_buttons_widget.dart';
import 'package:tickit/ui/ticket/component/edit_buttons_widget.dart';
import 'package:tickit/ui/ticket/component/image_widget.dart';
import 'package:tickit/ui/ticket/component/location_widget.dart';
import 'package:tickit/ui/ticket/component/save_buttons_widget.dart';
import 'package:tickit/ui/ticket/component/ticket_field_row_widget.dart';
import 'package:tickit/ui/ticket/component/title_widget.dart';
import 'package:tickit/ui/ticket/const/ticket_mode.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/view_model/ticket_view_model_provider.dart';

class TicketView extends HookConsumerWidget {
  final TicketMode mode;
  final String? id;

  TicketView({
    super.key,
    required this.mode,
    this.id,
  });

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BaseTicketViewModel viewModel =
        ref.watch(ticketViewModelProvider(mode).notifier);
    final TicketState state = ref.watch(ticketViewModelProvider(mode));

    final bool isDetail = mode == TicketMode.detail;
    final bool isEdit = mode == TicketMode.edit;
    final bool isCreate = mode == TicketMode.create;

    useEffect(() {
      if (isDetail) {
        Future(() => viewModel.initDetailView(id: id!));
      }
      return null;
    }, []);

    useEffect(() {
      if (state.isDeleted) {
        Future.microtask(() => Navigator.of(context).pop(true));
      }
      return;
    }, [state.isDeleted]);

    useEffect(() {
      if (state.errorMsg.isNotEmpty) {
        Future.microtask(
          () => ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(message: state.errorMsg),
          ),
        );
      }
      if (state.successMsg.isNotEmpty) {
        Future.microtask(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SuccessSnackBar(message: state.successMsg),
          ),
        );
      }
      return null;
    }, [state.errorMsg, state.successMsg]);

    return Scaffold(
      backgroundColor: state.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                ImageWidget(
                  isDetail: isDetail,
                  isCreate: isCreate,
                  isEdit: isEdit,
                  imagePicker: imagePicker,
                  onTapImageBox: (value) => viewModel.onTapImageBox(value),
                  networkImage: state.networkImage,
                  image: state.image,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                  child: TitleWidget(
                    isDetail: isDetail,
                    controller: viewModel.titleController,
                    onChanged: (value) =>
                        viewModel.onChangedTitle(newTitle: value),
                    color: state.foregroundColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocationWidget(
                            isDetail: isDetail,
                            controller: viewModel.locationController,
                            onChanged: (value) => viewModel.onChangedLocation(
                              newLocation: value,
                            ),
                            color: state.foregroundColor,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          CalendarWidget(
                            mode: mode,
                            onDateChanged: (value) =>
                                viewModel.onChangedDate(newDate: value),
                            onPressedAmButton: () => viewModel.onTapAmButton(),
                            onChangedMinute: (value) =>
                                viewModel.onChangedMinute(newMinute: value),
                            onPressedCheckButton: () =>
                                viewModel.onPressedDateTimeCheck(),
                            onChangedHour: (value) =>
                                viewModel.onChangedHour(newHour: value),
                            dateTime: state.dateTime,
                            color: state.foregroundColor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const TicketFieldRowWidget(),
                      const TicketFieldRowWidget(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      if (!isDetail)
                        DecoButtonsWidget(
                          mode: mode,
                        ),
                      if (!isDetail) const SizedBox(height: 16.0),
                      if (!isDetail)
                        SaveButtonsWidget(
                          onPressedCancel: () => viewModel.onPressedCancel(),
                          onPressedSave: () => viewModel.onPressedSave(),
                        ),
                      if (isDetail)
                        EditButtonsWidget(
                          onTapDelete: () {
                            if (id != null) {
                              viewModel.onTapDelete(id: id!);
                            }
                          },
                          onTapSaveAsImage: () {},
                          onTapEdit: () {},
                        ),
                      const SizedBox(
                        height: 100.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (isDetail)
            Positioned(
              top: 24.0,
              left: 8.0,
              child: IconButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(false),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          if (state.makeTicketLoading == LoadingStatus.loading ||
              state.initLoading == LoadingStatus.loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CustomLoading(),
              ),
            ),
        ],
      ),
    );
  }
}
