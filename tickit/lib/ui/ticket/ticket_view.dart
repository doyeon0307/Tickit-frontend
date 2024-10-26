import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tickit/theme/text_style.dart';
import 'package:tickit/ui/common/component/custom_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/ticket/component/am_number_picker.dart';
import 'package:tickit/ui/ticket/component/am_text_button.dart';
import 'package:tickit/ui/ticket/component/ticket_text_field.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  ImagePicker imagePicker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                XFile? newImage =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (newImage != null) {
                  setState(() {
                    image = newImage;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 1.25,
                color: AppColors.fillColor,
                alignment: Alignment.center,
                child: image == null
                    ? Text(
                        "클릭해서 사진 추가하기",
                        style: ticketStyle,
                      )
                    : DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(image!.path)),
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
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: TicketTextField(
                        fontSize: 20.0,
                        hintText: "제목을 입력하세요",
                        keyboardType: TextInputType.multiline,
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
                              child: const TicketTextField(
                                fontSize: 16.0,
                                hintText: "장소를 입력하세요",
                                keyboardType: TextInputType.multiline,
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
                                  return Dialog(
                                    insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 16.0,
                                    ),
                                    backgroundColor: AppColors.backgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: SizedBox(
                                      height: 500,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "날짜를 선택하세요",
                                            style: ticketStyle.copyWith(
                                              fontSize: 24.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          CalendarDatePicker(
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2500),
                                            onDateChanged: (value) {},
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20.0),
                                                    color: AppColors.fillColor,
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: AmTextButton(
                                                          backgroundColor:
                                                              AppColors.fillColor,
                                                          onPressed: () {},
                                                          label: "오전",
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: AmTextButton(
                                                          backgroundColor: AppColors
                                                              .primaryColor,
                                                          onPressed: () {},
                                                          label: "오후",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                const AmNumberPicker(am: true),
                                                Text(
                                                  ":",
                                                  style: ticketStyle.copyWith(
                                                    fontSize: 28.0,
                                                  ),
                                                ),
                                                const AmNumberPicker(am: false),
                                                const SizedBox(
                                                  width: 16.0,
                                                ),
                                                CustomTextButton(
                                                  label: "선택",
                                                  textStyle: ticketStyle,
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              textStyle: ticketStyle,
                              padding: const EdgeInsets.all(0.0),
                              foregroundColor: Theme.of(context).hintColor,
                            ),
                            child: const Text(
                              "날짜를 선택하세요",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    16.0,
                                  ),
                                ),
                                titleTextStyle: ticketStyle.copyWith(
                                  fontSize: 24.0,
                                ),
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 16.0,
                                ),
                                backgroundColor: AppColors.backgroundColor,
                                title: const Text(
                                  "배경색을 선택하세요",
                                ),
                                content: BlockPicker(
                                  pickerColor: Colors.white,
                                  onColorChanged: (value) {},
                                ),
                                actions: [
                                  CustomTextButton(
                                    label: "선택",
                                    textStyle: ticketStyle,
                                    onPressed: () {},
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        textStyle: ticketStyle,
                      ),
                      CustomTextButton(
                        label: "글자색",
                        onPressed: () {},
                        textStyle: ticketStyle,
                      ),
                      CustomTextButton(
                        label: "일정 불러오기",
                        onPressed: () {},
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
                        onPressed: () {},
                        textStyle: ticketStyle,
                        backgroundColor: AppColors.secondaryColor,
                        foregroundColor: AppColors.backgroundColor,
                        width: 100.0,
                        height: 28.0,
                      ),
                      CustomTextButton(
                        label: "저장하기",
                        onPressed: () {},
                        textStyle: ticketStyle,
                        backgroundColor: AppColors.primaryColor,
                        width: 150.0,
                        height: 28.0,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
