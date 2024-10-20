import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/theme/text_style.dart';
import 'package:tickit/ui/common/component/custom_text_button.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

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
                XFile? newImage = await imagePicker.pickImage(source: ImageSource.gallery);
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
            const SizedBox(
              height: 16.0,
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
                  label: "배경색 변경",
                  onPressed: () {},
                  textStyle: ticketStyle,
                ),
                CustomTextButton(
                  label: "글자색 변경",
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
            )
          ],
        ),
      ),
    );
  }
}
