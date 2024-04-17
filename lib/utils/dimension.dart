import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/utils/app_constant.dart';

class Dimension{
  static FontWeight textRegular=FontWeight.w400;
  static FontWeight textMedium=FontWeight.w500;
  static FontWeight textSemiBold=FontWeight.w600;
  static FontWeight textBold=FontWeight.w700;
  static FontWeight textExtraBold=FontWeight.w800;

  static double cardElevation = 5;

  static double get paddingTop=>MediaQuery.of(appContext).padding.top;
  static double get paddingBottom=>MediaQuery.of(appContext).padding.bottom;
  static double get screenRatio=>appSize().width/AppConstant.defaultScreenSize.width;
  static double get appbarHeight => DefaultAppbar(title: '').preferredSize.height;
  static Widget get bottomSpace => (paddingBottom+16.h).verticalSpace;
}