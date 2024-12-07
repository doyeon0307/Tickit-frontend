import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/component/error_snack_bar.dart';
import 'package:tickit/ui/common/component/success_snack_bar.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/ticket/component/calendar_widget.dart';
import 'package:tickit/ui/ticket/component/deco_buttons_widget.dart';
import 'package:tickit/ui/ticket/component/edit_buttons_widget.dart';
import 'package:tickit/ui/ticket/component/image_widget.dart';
import 'package:tickit/ui/ticket/component/location_widget.dart';
import 'package:tickit/ui/ticket/component/save_buttons_widget.dart';
import 'package:tickit/ui/ticket/component/schedule_list_dialog.dart';
import 'package:tickit/ui/ticket/component/ticket_field_row_widget.dart';
import 'package:tickit/ui/ticket/component/title_widget.dart';
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
    final viewModel = ref.read(ticketViewModelProvider(mode).notifier);
    final state = ref.watch(ticketViewModelProvider(mode));

    useEffect(() {
      Future.microtask(() => viewModel.initTicketView(mode: mode, id: id));

      return null;
    }, []);

    useEffect(() {
      if (state.isDeleted) {
        Future.microtask(() {
          if (context.mounted) {
            Navigator.of(context).pop(true);
          }
        });
      }
      return;
    }, [state.isDeleted]);

    useEffect(() {
      if (state.errorMsg.isNotEmpty) {
        Future.microtask(() {
          if (context.mounted) {
            return ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackBar(message: state.errorMsg),
            );
          }
        });
      }
      if (state.successMsg.isNotEmpty) {
        Future.microtask(() {
          if (context.mounted) {
            return ScaffoldMessenger.of(context).showSnackBar(
              SuccessSnackBar(message: state.successMsg),
            );
          }
        });
      }
      return null;
    }, [state.errorMsg, state.successMsg]);

    return Scaffold(
      backgroundColor: state.backgroundColor,
      body: Stack(
        children: [
          if (state.initLoading != LoadingStatus.loading)
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  ImageWidget(
                    key: ValueKey(state.getSchedule),
                    isDetail: state.mode == TicketMode.detail,
                    isCreate: state.mode == TicketMode.create,
                    isEdit: state.mode == TicketMode.edit,
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
                      key: ValueKey(state.getSchedule),
                      isDetail: state.mode == TicketMode.detail,
                      onChanged: (value) => viewModel.onChangedTitle(newTitle: value),
                      color: state.foregroundColor,
                      initialValue: state.title,
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
                              key: ValueKey(state.getSchedule),
                              isDetail: state.mode == TicketMode.detail,
                              onChanged: (value) => viewModel.onChangedLocation(
                                newLocation: value!,
                              ),
                              color: state.foregroundColor,
                              initialValue: state.location,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            AbsorbPointer(
                              absorbing: state.mode == TicketMode.detail,
                              child: CalendarWidget(
                                mode: state.mode,
                                onDateChanged: (value) => viewModel.onChangedDate(newDate: value),
                                onPressedAmButton: () => viewModel.onTapAmButton(),
                                onChangedMinute: (value) => viewModel.onChangedMinute(newMinute: value),
                                onPressedCheckButton: () => viewModel.onPressedDateTimeCheck(),
                                onChangedHour: (value) => viewModel.onChangedHour(newHour: value),
                                dateTime: state.dateTime,
                                color: state.foregroundColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Column(
                          children: List.from(
                            state.fields.asMap().entries.map(
                                  (entry) => TicketFieldRowWidget(
                                    key: ValueKey(entry.value.id),
                                    mode: state.mode,
                                    index: entry.key,
                                    color: state.foregroundColor,
                                    subTitleInitialValue: state.mode == TicketMode.create ? null : entry.value.subtitle,
                                    contentInitialValue: state.mode == TicketMode.create ? null : entry.value.content,
                                    updateFieldTitle: viewModel.updateFieldTitle,
                                    updateFieldContent: viewModel.updateFieldContent,
                                    removeField: viewModel.removeField,
                                  ),
                                ),
                          ),
                        ),
                        if (!(state.mode == TicketMode.detail))
                          DecoButtonsWidget(
                            mode: state.mode,
                            onTapAddField: () => viewModel.addField(),
                            backgroundColor: state.backgroundColor,
                            foregroundColor: state.foregroundColor,
                            onBackgroundColorChanged: (newColor) => viewModel.onBackgroundColorChanged(newColor: newColor),
                            onForegroundColorChanged: (newColor) => viewModel.onForegroundColorChanged(newColor: newColor),
                            onTapGetSchedule: () async {
                              await viewModel.onTapGetSchedule();
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => ScheduleListDialog(
                                    schedules: state.schedules,
                                    onTapSchedule: viewModel.onTapSchedule,
                                    onSelectSchedule: () {
                                      viewModel.onSelectSchedule();
                                      Navigator.pop(dialogContext);
                                    },
                                  ),                                );
                              }
                            },
                          ),
                        if (!(state.mode == TicketMode.detail)) const SizedBox(height: 16.0),
                        if (!(state.mode == TicketMode.detail))
                          SaveButtonsWidget(
                            onPressedCancel: () {
                              if (state.mode == TicketMode.create) {
                                viewModel.onPressedCancel();
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TicketView(
                                    mode: mode,
                                    id: id,
                                  ),
                                ),
                              );
                            },
                            onPressedSave: () async {
                              if (state.mode == TicketMode.create) {
                                final result = await viewModel.onPressedSave();

                                if (result) {
                                  await Future.delayed(const Duration(milliseconds: 100));
                                  viewModel.initState();
                                  if (context.mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TicketView(
                                          mode: mode,
                                          id: id,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              } else if (state.mode == TicketMode.edit && id != null) {
                                await viewModel.onPressedUpdate(id: id!);
                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TicketView(
                                        mode: mode,
                                        id: id,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        if (state.mode == TicketMode.create)
                          const SizedBox(
                            height: 100.0,
                          ),
                        if (state.mode == TicketMode.detail && id != null)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: EditButtonsWidget(
                                color: state.foregroundColor,
                                onTapDelete: () => viewModel.onTapDelete(id: id!),
                                onTapSaveAsImage: () {},
                                onTapEdit: () => viewModel.onTapEditButton(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          if (state.mode == TicketMode.detail)
            Positioned(
              top: 24.0,
              left: 8.0,
              child: IconButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(false),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          if (state.makeTicketLoading == LoadingStatus.loading || state.initLoading == LoadingStatus.loading)
            const Center(
              child: CustomLoading(),
            ),
        ],
      ),
    );
  }
}
