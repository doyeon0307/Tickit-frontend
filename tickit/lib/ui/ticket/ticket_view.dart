import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/theme/ticket_typographies.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/component/custom_text_button.dart';
import 'package:tickit/ui/common/component/error_snack_bar.dart';
import 'package:tickit/ui/common/component/success_snack_bar.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/base_ticket_view_model.dart';
import 'package:tickit/ui/ticket/component/custom_color_picker_dialog.dart';
import 'package:tickit/ui/ticket/component/custom_date_picker_dialog.dart';
import 'package:tickit/ui/ticket/component/ticket_text_field.dart';
import 'package:tickit/ui/ticket/ticket_mode.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/ticket_view_model_provider.dart';

class TicketView extends HookConsumerWidget {
  final TicketMode mode;
  String? id;

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

    return Stack(
      children: [
        if (isDetail)
          Positioned(
            top: 8.0,
            left: 8.0,
            child: IconButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(false),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        //TODO Scaffold의 body를 Stack으로
        Scaffold(
          backgroundColor: state.backgroundColor,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                _buildImage(
                    isDetail, viewModel, context, state, isCreate, isEdit),
                _buildTitle(context, isDetail, viewModel, state),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLocation(context, isDetail, viewModel, state),
                          const SizedBox(
                            width: 8.0,
                          ),
                          _buildCalendar(context, viewModel, state),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const TicketFieldRow(),
                      const TicketFieldRow(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      if (!isDetail) _buildDecoButtons(context),
                      if (!isDetail) const SizedBox(height: 16.0),
                      if (!isDetail) _buildSaveButtons(viewModel),
                      if (isDetail) _bulidEditButtons(viewModel, id!),
                      const SizedBox(
                        height: 100.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
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
    );
  }

  Wrap _bulidEditButtons(BaseTicketViewModel viewModel, String id) {
    return Wrap(
      children: [
        TextButton(
            onPressed: () => viewModel.onTapDelete(id: id),
            child: Text(
              "삭제하기",
              style: ticketStyle,
            )),
        TextButton(
            onPressed: () {},
            child: Text(
              "사진으로 저장하기",
              style: ticketStyle,
            )),
        TextButton(
            onPressed: () {},
            child: Text(
              "수정하기",
              style: ticketStyle,
            ))
      ],
    );
  }

  Padding _buildTitle(BuildContext context, bool isDetail,
      BaseTicketViewModel viewModel, TicketState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/deco/left_title_deco.svg",
            width: MediaQuery.of(context).size.width / 4,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              child: TicketTextField(
                readOnly: isDetail,
                controller: viewModel.titleController,
                onChanged: (value) => viewModel.onChangedTitle(newTitle: value),
                fontSize: 20.0,
                hintText: "제목을 입력하세요",
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                color: state.foregroundColor,
              ),
            ),
          ),
          SvgPicture.asset(
            "assets/deco/right_title_deco.svg",
            width: MediaQuery.of(context).size.width / 4,
          ),
        ],
      ),
    );
  }

  Wrap _buildSaveButtons(BaseTicketViewModel viewModel) {
    return Wrap(
      spacing: 16.0,
      children: [
        CustomTextButton(
          label: "취소하기",
          onPressed: () => viewModel.onPressedCancel(),
          textStyle: ticketStyle,
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: AppColors.backgroundColor,
          width: 100.0,
          height: 28.0,
        ),
        CustomTextButton(
          label: "저장하기",
          onPressed: () => viewModel.onPressedSave(),
          textStyle: ticketStyle,
          backgroundColor: AppColors.primaryColor,
          width: 150.0,
          height: 28.0,
        ),
      ],
    );
  }

  Wrap _buildDecoButtons(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      children: [
        CustomTextButton(
          label: "필드 추가",
          onPressed: () {},
          textStyle: ticketStyle,
        ),
        CustomTextButton(
          label: "배경색",
          onPressed: () => showDialog(
            context: context,
            builder: (context) => CustomColorPickerDialog(
              mode: mode,
              isBackground: true,
              title: "배경색을 선택하세요",
            ),
          ),
          textStyle: ticketStyle,
        ),
        CustomTextButton(
          label: "글자색",
          onPressed: () => showDialog(
            context: context,
            builder: (context) => CustomColorPickerDialog(
              mode: mode,
              isBackground: false,
              title: "글자색을 선택하세요",
            ),
          ),
          textStyle: ticketStyle,
        ),
        CustomTextButton(
          label: "일정 불러오기",
          onPressed: () => showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: AppColors.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "티켓으로 만들 일정을 선택하세요",
                                style: ticketStyle.copyWith(
                                  fontSize: 20.0,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 48,
                                child: Row(
                                  children: [
                                    Text(
                                      "2024\n0829",
                                      style: ticketStyle,
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Text(
                                      "하데스타운",
                                      style: ticketStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Container(
                                color: Colors.grey.withOpacity(0.2),
                                height: 48,
                                child: Row(
                                  children: [
                                    Text(
                                      "2024\n0829",
                                      style: ticketStyle,
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Text(
                                      "하데스타운",
                                      style: ticketStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomTextButton(
                      label: "선택",
                      onPressed: () {},
                      textStyle: ticketStyle,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          textStyle: ticketStyle,
        ),
      ],
    );
  }

  Row _buildCalendar(
      BuildContext context, BaseTicketViewModel viewModel, TicketState state) {
    return Row(
      children: [
        SvgPicture.asset("assets/icon/mini_calendar.svg"),
        const SizedBox(
          width: 4.0,
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomDatePickerDialog(
                  mode: mode,
                  onDateChanged: (value) =>
                      viewModel.onChangedDate(newDate: value),
                  onPressedAmButton: () => viewModel.onTapAmButton(),
                  onChangedHour: (value) =>
                      viewModel.onChangedHour(newHour: value),
                  onChangedMinute: (value) =>
                      viewModel.onChangedMinute(newMinute: value),
                  onPressedCheckButton: () =>
                      viewModel.onPressedDateTimeCheck(),
                );
              },
            );
          },
          style: TextButton.styleFrom(
            textStyle: ticketStyle.copyWith(
              fontSize: 18.0,
            ),
            padding: const EdgeInsets.all(0.0),
            foregroundColor: state.dateTime == "날짜를 선택하세요"
                ? Theme.of(context).hintColor
                : state.foregroundColor,
          ),
          child: Text(state.dateTime),
        ),
      ],
    );
  }

  Row _buildLocation(BuildContext context, bool isDetail,
      BaseTicketViewModel viewModel, TicketState state) {
    return Row(
      children: [
        SvgPicture.asset("assets/icon/location.svg"),
        const SizedBox(
          width: 4.0,
        ),
        IntrinsicWidth(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 5 / 12,
            ),
            child: TicketTextField(
              readOnly: isDetail,
              controller: viewModel.locationController,
              onChanged: (value) =>
                  viewModel.onChangedLocation(newLocation: value),
              fontSize: 18.0,
              hintText: "장소를 입력하세요",
              color: state.foregroundColor,
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector _buildImage(bool isDetail, BaseTicketViewModel viewModel,
      BuildContext context, TicketState state, bool isCreate, bool isEdit) {
    return GestureDetector(
      onTap: () async {
        if (!isDetail) {
          XFile? newImage =
              await imagePicker.pickImage(source: ImageSource.gallery);
          viewModel.onTapImageBox(newImage: newImage);
        }
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.width * 1.25,
        color: AppColors.fillColor,
        alignment: Alignment.center,
        child: _buildImageContent(state, isCreate, isEdit, isDetail),
      ),
    );
  }
}

Widget _buildImageContent(
    TicketState state, bool isCreate, bool isEdit, bool isDetail) {
  // 1. Create 모드에서 이미지가 없을 때
  if (state.image == null && (isCreate || isEdit)) {
    return Text(
      "클릭해서 사진 추가하기",
      style: ticketStyle,
    );
  }

  // 2. Detail 모드에서 네트워크 이미지가 있을 때
  if (isDetail && state.networkImage.isNotEmpty) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(state.networkImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(),
    );
  }

  // 3. Create/Edit 모드에서 로컬 이미지가 있을 때
  if ((isCreate || isEdit) && state.image != null) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(state.image!.path)),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(),
    );
  }

  // 4. 기본값 (이미지가 없는 경우)
  return const SizedBox.shrink();
}

class TicketFieldRow extends StatelessWidget {
  const TicketFieldRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 3,
          ),
          child: IntrinsicWidth(
            child: TicketTextField(
              hintText: "소제목",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Text(
            " :  ",
            style: ticketStyle,
          ),
        ),
        Expanded(
          child: TicketTextField(
            hintText: "내용을 입력하세요",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 14.0,
            left: 4.0,
          ),
          child: SvgPicture.asset(
            "assets/icon/x-circle.svg",
            color: AppColors.textColor.withOpacity(0.8),
          ),
        )
      ],
    );
  }
}
