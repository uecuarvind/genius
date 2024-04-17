import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/controllers/connnectivity_helper.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/theme/app_color.dart';
import 'package:genius_bank/utils/dimension.dart';

Widget AppBackground({required Widget child,bool visibleWarning = true}){
  return Container(
    /*decoration: BoxDecoration(
      image: DecorationImage(
        opacity: 0.5,
        image: AssetImage(Assets.background1),
        fit: BoxFit.cover,
      ),
    ),*/
    child: Column(
      children: [
        Expanded(child: child),
        ValueListenableBuilder<ConnectivityResult>(
          valueListenable: ConnectivityHelper.networkState,
          builder: (context,value,child){
            return Visibility(
              visible: value == ConnectivityResult.none,
              child: Container(
                color: AppColor.red,
                width: 1.sw,
                padding: EdgeInsets.symmetric(vertical: 2.r,horizontal: 16.r),
                margin: EdgeInsets.only(bottom: Dimension.paddingBottom),
                child: Text(appLanguage(context).no_internet_connection,style: appTheme(context).textTheme.bodyText2!.copyWith(color: AppColor.buttonTextColor,),textAlign: TextAlign.center,),
              ),
            );
          }
        )
      ],
    ),
  );
}