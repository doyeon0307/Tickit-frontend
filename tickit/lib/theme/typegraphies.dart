import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

@immutable
class Typo {
  const Typo._();

  //  예시
  //  static const TextStyle hBold24 = TextStyle(
  //    fontSize: 24,
  //    fontWeight: FontWeight.w700,
  //    height: 1.4,
  //    leadingDistribution: TextLeadingDistribution.even,
  //    fontFamily: 'Pretendard',
  //  );

  static TextStyle hBold40 = TextStyle(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w800,
    fontSize: 40.0,
  );
}
