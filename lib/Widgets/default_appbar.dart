import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/theme/app_color.dart';

AppBar DefaultAppbar ({String? title, Widget? titleWidget,bool returnData=false,List<Widget>? actions,Color? color,PreferredSizeWidget? bottom,bool centerTitle=true,bool haveLeading=true,double? elevation,VoidCallback? onBack,TextStyle? textStyle}){
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: color ?? AppColor.appBarColor,
    automaticallyImplyLeading: false,
    elevation: elevation,
    titleSpacing: 6.w,
    leadingWidth: 44.w,
    title: titleWidget ?? Text(title ?? ''),
    leading: haveLeading ? Container(
      margin: const EdgeInsets.only(left: 8).r,
      child: BackButton(
        color: AppColor.iconColor,
        onPressed: onBack ?? (){
          navigatorKey.currentState!.pop();
        },
      ),
    ) : null,
    actions: actions,
    bottom: bottom,
  );
}
