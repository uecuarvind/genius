import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/theme/app_color.dart';
class DesignComponent{
  static List<BoxShadow> get  dropShadow => [
    BoxShadow(
      blurRadius: 6,
      offset: const Offset(0, 3),
      color: AppColor.shadowColor,
    )
  ];
  static ShapeBorder cardShape({double? radius}){
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? 10.r)
    );
  }

  static TextStyle textUnderline({Color? color}){
    return TextStyle(
      shadows: [
        Shadow(
            color: color ?? AppColor.primary,
            offset: Offset(0, -2.r)
        )
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor: color ?? AppColor.primary,
    );
  }

  static BoxDecoration emptyDecoration({Color? color}){
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5.r),
      boxShadow: [
        BoxShadow(color: color ?? AppColor.grey,),
        BoxShadow(
          color: AppColor.buttonTextColor,
          spreadRadius: -10.0.r,
          blurRadius: 10.0.r,
        ),
      ],
    );
  }
}