import 'package:flutter/material.dart';
import 'package:tickit/theme/typographies.dart';
import 'package:tickit/ui/common/component/custom_dialog.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class EditButtonsWidget extends StatelessWidget {
  final VoidCallback onTapDelete;
  final VoidCallback onTapSaveAsImage;
  final VoidCallback onTapEdit;

  const EditButtonsWidget({
    super.key,
    required this.onTapDelete,
    required this.onTapSaveAsImage,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        TextButton(
          style: TextButton.styleFrom(overlayColor: Colors.grey),
          onPressed: () async {
            final result = await showDialog<bool>(
              context: context,
              builder: (context) => CustomDialog(
                title: "정말 삭제할까요?",
                content: "삭제한 티켓은 되돌릴 수 없습니다",
                leftButtonLabel: "취소",
                rightButtonLabel: "삭제",
                onPressedLeftButton: () => Navigator.of(context).pop(false),
                onPressedRightButton: () {
                  onTapDelete();
                  Navigator.of(context).pop(true);
                },
              ),
            );
          },
          child: Text(
            "삭제하기",
            style: Typo.gangwonR16.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(overlayColor: Colors.grey),
          onPressed: onTapSaveAsImage,
          child: Text(
            "사진으로 저장하기",
            style: Typo.gangwonR16.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(overlayColor: Colors.grey),
          onPressed: onTapEdit,
          child: Text(
            "수정하기",
            style: Typo.gangwonR16.copyWith(
              color: AppColors.textColor,
            ),
          ),
        )
      ],
    );
  }
}
