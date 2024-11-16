import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/theme/ticket_typegraphies.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/component/custom_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/component/custom_color_picker_dialog.dart';
import 'package:tickit/ui/ticket/component/custom_date_picker_dialog.dart';
import 'package:tickit/ui/ticket/component/ticket_text_field.dart';
import 'package:tickit/ui/ticket/ticket_state.dart';
import 'package:tickit/ui/ticket/ticket_view_model.dart';

class TicketView extends ConsumerStatefulWidget {
  const TicketView({super.key});

  @override
  ConsumerState<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends ConsumerState<TicketView> {
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final TicketViewModel viewModel =
        ref.watch(ticketViewModelProvider.notifier);
    final TicketState state = ref.watch(ticketViewModelProvider);

    return Stack(
      children: [
        Scaffold(
        backgroundColor: state.backgroundColor,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  XFile? newImage =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  viewModel.onTapImageBox(newImage: newImage);
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 1.25,
                  color: AppColors.fillColor,
                  alignment: Alignment.center,
                  child: state.image == null
                      ? Text(
                          "클릭해서 사진 추가하기",
                          style: ticketStyle,
                        )
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(state.image!.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                ),
              ),
              Padding(
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
                          controller: viewModel.titleController,
                          onChanged: (value) =>
                              viewModel.onChangedTitle(newTitle: value),
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
                        Row(
                          children: [
                            SvgPicture.asset("assets/icon/location.svg"),
                            const SizedBox(
                              width: 4.0,
                            ),
                            IntrinsicWidth(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 5 / 12,
                                ),
                                child: TicketTextField(
                                  controller: viewModel.locationController,
                                  onChanged: (value) => viewModel
                                      .onChangedLocation(newLocation: value),
                                  fontSize: 18.0,
                                  hintText: "장소를 입력하세요",
                                  color: state.foregroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Row(
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
                                      onDateChanged: (value) =>
                                          viewModel.onChangedDate(newDate: value),
                                      onPressedAmButton: () =>
                                          viewModel.onTapAmButton(),
                                      onChangedHour: (value) =>
                                          viewModel.onChangedHour(newHour: value),
                                      onChangedMinute: (value) => viewModel
                                          .onChangedMinute(newMinute: value),
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
                        ),
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
                    Wrap(
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
                            builder: (context) => const CustomColorPickerDialog(
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
                            builder: (context) => const CustomColorPickerDialog(
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                color:
                                                    Colors.grey.withOpacity(0.2),
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
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Wrap(
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
      ),
        if (state.makeTicketLoading == LoadingStatus.loading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CustomLoading(),
            ),
          ),
      ],
    );
  }
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
