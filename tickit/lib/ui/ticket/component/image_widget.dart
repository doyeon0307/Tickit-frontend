import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class ImageWidget extends StatelessWidget {
  final bool isDetail;
  final bool isCreate;
  final bool isEdit;
  final ImagePicker imagePicker;
  final Function(XFile?) onTapImageBox;
  final String networkImage;
  final XFile? image;

  const ImageWidget({
    super.key,
    required this.isDetail,
    required this.isCreate,
    required this.isEdit,
    required this.imagePicker,
    required this.onTapImageBox,
    required this.networkImage,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!isDetail) {
          XFile? newImage = await imagePicker.pickImage(source: ImageSource.gallery);
          onTapImageBox(newImage);
        }
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.width * 1.25,
        color: AppColors.fillColor,
        alignment: Alignment.center,
        child: _buildImageContent(
          image: image,
          isCreate: isCreate,
          isDetail: isDetail,
          isEdit: isEdit,
          networkImage: networkImage,
        ),
      ),
    );
  }
}

Widget _buildImageContent({
  required bool isCreate,
  required bool isEdit,
  required bool isDetail,
  required String networkImage,
  required XFile? image,
}) {
  // 1. Create/Edit 모드에서 로컬 이미지가 있을 때
  if ((isCreate || isEdit) && image != null) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(image.path)),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(),
    );
  }

  // 2. Detail/Edit 모드에서 네트워크 이미지가 있을 때
  if ((isDetail || isEdit) && networkImage.isNotEmpty) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(networkImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(),
    );
  }

  // 3. 이미지가 없을 때 텍스트 표시
  if (isCreate || isEdit) {
    return Text(
      "클릭해서 사진 추가하기",
      style: Typo.gangwonR16.copyWith(
        color: AppColors.textColor,
      ),
    );
  }

  return const SizedBox.shrink();
}
