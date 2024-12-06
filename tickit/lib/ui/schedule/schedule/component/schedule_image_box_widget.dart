import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/const/mode.dart';

class ScheduleImageBoxWidget extends StatelessWidget {
  final XFile? image;
  final String networkImage;
  final ScheduleMode mode;

  const ScheduleImageBoxWidget({
    super.key,
    this.image,
    required this.networkImage,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144.0,
      width: 120.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: (image == null && networkImage.isEmpty) ? AppColors.strokeColor.withOpacity(0.8) : Colors.transparent,
        ),
      ),
      alignment: Alignment.center,
      child: _buildImageContent(
        isDetail: mode == ScheduleMode.detail,
        isCreate: mode == ScheduleMode.create,
        image: image,
        networkImage: networkImage,
      ),
    );
  }
}

Widget _buildImageContent({
  required bool isCreate,
  required bool isDetail,
  required String networkImage,
  required XFile? image,
}) {
  Widget buildImageWidget(ImageProvider imageProvider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(),
      ),
    );
  }

  if (isCreate) {
    if (image != null) {
      return buildImageWidget(FileImage(File(image.path)));
    }
  }

  if (isDetail) {
    if (image != null) {
      return buildImageWidget(FileImage(File(image.path)));
    }
    if (networkImage.isNotEmpty) {
      return buildImageWidget(NetworkImage(networkImage));
    }
  }

  return Text(
    "사진 추가하기",
    style: Typo.pretendardR12.copyWith(
      color: AppColors.strokeColor,
    ),
  );
}
