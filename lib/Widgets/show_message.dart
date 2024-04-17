import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/theme/app_color.dart';
import 'package:genius_bank/utils/dimension.dart';


void SuccessMessage({required String message,Function? then}){
  Flushbar(
    messageText: Text(message, style: appTheme().textTheme.bodyText1!.copyWith(fontWeight: Dimension.textMedium),),
    icon: Icon(Icons.check_circle,color: AppColor.textColor,),
    backgroundColor: AppColor.green,
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(appContext).then((value) {
    if(then!=null) {
      then();
    }
  });
}
void ErrorMessage({required var message,Function? then}){
  Flushbar(
    messageText: Text(message, style: appTheme().textTheme.bodyText1!.copyWith(fontWeight: Dimension.textMedium),),
    icon: Icon(Icons.cancel,color: AppColor.textColor,),
    backgroundColor: AppColor.red,
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(appContext).then((value) {
    if(then!=null) {
      then();
    }
  });
}