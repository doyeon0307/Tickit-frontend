import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/custom_dialog.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/component/error_snack_bar.dart';
import 'package:tickit/ui/common/component/success_snack_bar.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/assets.dart';
import 'package:tickit/ui/common/const/mode.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/schedule/schedule/component/row_form_widget.dart';
import 'package:tickit/ui/schedule/schedule/component/schedule_image_box_widget.dart';
import 'package:tickit/ui/schedule/schedule/component/schedule_text_button_widget.dart';
import 'package:tickit/ui/schedule/schedule/component/schedule_text_form_field.dart';
import 'package:tickit/ui/schedule/schedule/component/schedule_title_text_form_field.dart';
import 'package:tickit/ui/schedule/schedule/view_model/schedule_view_model_provider.dart';
import 'package:tickit/ui/common/component/custom_divider.dart';

class ScheduleView extends HookConsumerWidget {
  final ScheduleMode mode;
  final DateTime date;
  final String? id;

  const ScheduleView({
    super.key,
    required this.mode,
    required this.date,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(scheduleViewModelProvider(mode).notifier);
    final state = ref.watch(scheduleViewModelProvider(mode));

    final imagePicker = ImagePicker();

    useEffect(() {
      Future.microtask(
        () => viewModel.initView(date: date),
      );
      if (mode == ScheduleMode.detail && id != null) {
        Future.microtask(
          () => viewModel.getDetailSchedule(id: id!),
        );
      }
      return null;
    }, []);

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

    return DefaultLayout(
      child: Stack(
        children: [
          state.loadingInitView == LoadingStatus.loading
              ? const Center(
                  child: CustomLoading(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: BackButton(),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "${date.year}년 ${date.month}월 ${date.day}일",
                                style: Typo.pretendardR22.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IntrinsicWidth(
                        child: ScheduleTitleTextFormField(
                          hintText: "titleHint".tr(),
                          onChanged: (value) => viewModel.onTitleChanged(
                            value: value,
                          ),
                          initialValue: state.title,
                        ),
                      ),
                      const CustomDivider(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RowFormWidget(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              icon: Assets.image,
                              widget: GestureDetector(
                                onTap: () async {
                                  XFile? newImage = await imagePicker.pickImage(source: ImageSource.gallery);
                                  viewModel.onImageTap(newImage: newImage);
                                },
                                child: ScheduleImageBoxWidget(
                                  image: state.image,
                                  networkImage: state.networkImage,
                                  mode: mode,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 144.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RowFormWidget(
                                    icon: Assets.scheduleLocation,
                                    widget: Expanded(
                                      child: ScheduleTextFormField(
                                        hintText: "locationHint".tr(),
                                        onChanged: (value) => viewModel.onLocationChanged(
                                          value: value,
                                        ),
                                        initialValue: state.location,
                                      ),
                                    ),
                                  ),
                                  RowFormWidget(
                                    icon: Assets.time,
                                    widget: Expanded(
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: () => viewModel.toggleAm(
                                              currentAM: state.isAM,
                                            ),
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                              ),
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              overlayColor: AppColors.secondaryColor,
                                            ),
                                            child: Text(
                                              state.isAM ? "AM" : "PM",
                                              style: Typo.pretendardR14.copyWith(
                                                color: AppColors.secondaryColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: ScheduleTextFormField(
                                              hintText: "HH",
                                              onChanged: (value) => viewModel.onHourChanged(
                                                value: value,
                                              ),
                                              initialValue: state.hour,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0,
                                            ),
                                            child: Text(
                                              ":",
                                              style: Typo.pretendardR16.copyWith(color: AppColors.strokeColor),
                                            ),
                                          ),
                                          Expanded(
                                            child: ScheduleTextFormField(
                                              hintText: "MM",
                                              onChanged: (value) => viewModel.onMinuteChanged(
                                                value: value,
                                              ),
                                              initialValue: state.minute,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  RowFormWidget(
                                    icon: Assets.seat,
                                    widget: Expanded(
                                      child: ScheduleTextFormField(
                                        hintText: "seatHint".tr(),
                                        onChanged: (value) => viewModel.onSeatChanged(
                                          value: value,
                                        ),
                                        initialValue: state.seat,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      RowFormWidget(
                        icon: Assets.casting,
                        widget: Expanded(
                          child: ScheduleTextFormField(
                            hintText: "castingHint".tr(),
                            onChanged: (value) => viewModel.onCastingChanged(
                              value: value,
                            ),
                            initialValue: state.casting,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      RowFormWidget(
                        icon: Assets.company,
                        widget: Expanded(
                          child: ScheduleTextFormField(
                            hintText: "companyHint".tr(),
                            onChanged: (value) => viewModel.onCompanyChanged(
                              value: value,
                            ),
                            initialValue: state.company,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      RowFormWidget(
                        icon: Assets.link,
                        widget: Expanded(
                          child: ScheduleTextFormField(
                            hintText: "linkHint".tr(),
                            onChanged: (value) => viewModel.onLinkChanged(
                              value: value,
                            ),
                            initialValue: state.link,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      RowFormWidget(
                        icon: Assets.memo,
                        widget: Expanded(
                          child: ScheduleTextFormField(
                            hintText: "memoHint".tr(),
                            onChanged: (value) => viewModel.onMemoChanged(
                              value: value,
                            ),
                            initialValue: state.memo,
                            maxLines: null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 52.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScheduleTextButtonWidget(
                            label: mode == ScheduleMode.create ? "최소하기" : "삭제하기",
                            backgroundColor: AppColors.errorColor,
                            onPressed: () async {
                              if (mode == ScheduleMode.create) {
                                Navigator.of(context).pop();
                              }
                              if (mode == ScheduleMode.detail && id != null) {
                                final deleted = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      title: "정말 삭제할까요?",
                                      content: "삭제한 일정은 되돌릴 수 없습니다",
                                      leftButtonLabel: "취소",
                                      rightButtonLabel: "삭제",
                                      onPressedLeftButton: () => Navigator.of(context).pop(),
                                      onPressedRightButton: () async {
                                        await viewModel.onDeletePressed(
                                          id: id!,
                                        );
                                        if (context.mounted) {
                                          Navigator.of(context).pop(true);
                                        }
                                      },
                                    );
                                  },
                                );
                                if (deleted != null && deleted && context.mounted) {
                                  Navigator.of(context).pop(true);
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          ScheduleTextButtonWidget(
                            label: "저장하기",
                            backgroundColor: AppColors.secondaryColor,
                            onPressed: () async {
                              if (mode == ScheduleMode.detail && id != null) {
                                await viewModel.onUpdatePressed(id: id!);
                                if (context.mounted) {
                                  Navigator.of(context).pop(true);
                                }
                              }
                              if (mode == ScheduleMode.create) {
                                await viewModel.onSavePressed();
                                if (context.mounted) {
                                  Navigator.of(context).pop(true);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          if (state.loadingSave == LoadingStatus.loading)
            const Center(
              child: CustomLoading(),
            ),
        ],
      ),
    );
  }
}
