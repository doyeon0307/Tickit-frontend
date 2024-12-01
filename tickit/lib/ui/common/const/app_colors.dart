import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  static Color primaryColor = const Color(0xffEEC643);
  static Color backgroundColor = Colors.white;
  static Color fillColor = const Color(0xffEEF0F2);
  static Color textColor = const Color(0xff141414);
  static Color secondaryColor = const Color(0xff585757);
  static Color lightGrayColor = const Color(0xffD9D9D9);
  static Color errorColor = const Color(0xffCB444A);
  static Color successColor = const Color(0xff537F4B);

  static Color dialogContentColor = const Color(0xff666666);
  static Color dialogButtonTextColor = const Color(0xff423B34);
  static Color dialogLeftButtonColor = const Color(0xffDEDAD5);
  static Color dialogRightButtonColor = const Color(0xff423B34);

  static Color calendarDateColor = const Color(0xff969696);
}