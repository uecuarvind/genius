import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/theme/app_color.dart';

enum ButtonType {SOLID,BORDER}

Widget DefaultButton({
  required VoidCallback onTap,
  required Widget child,
  Color? backgroundColor,
  ButtonType buttonType = ButtonType.SOLID,
  Color? borderColor,
  Color? disableColor,
  Color? loadingColor,
  double? borderRadius,
  bool enable = true,
  bool enableShadow=true,
  EdgeInsetsGeometry? padding,
  bool isLoading=false,
  double? progressbarSize
}){
  return InkWell(
    onTap: enable ? !isLoading ? onTap : null : null,
    borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
    child: Container(
      padding: padding ?? REdgeInsets.all(16).copyWith(top: buttonType == ButtonType.BORDER ? 16.r-2 : 16.r,bottom: buttonType == ButtonType.BORDER ? 16.r-2 : 16.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: buttonType == ButtonType.SOLID ? enable ? backgroundColor ?? AppColor.primary : disableColor ?? AppColor.primary.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
        border: buttonType == ButtonType.BORDER ? Border.all(color: enable ? borderColor ??  AppColor.buttonTextColor : Colors.transparent,width: 2) : null,
        boxShadow: enable ? buttonType == ButtonType.SOLID ? [
          BoxShadow(
            color: (backgroundColor ?? AppColor.primary2).withOpacity(0.25),
            blurRadius: 16.r,
            offset: const Offset(0.0, 5),
          ),
        ] : null : null,
      ),
      child: isLoading ? CircularProgress(color: loadingColor ?? AppColor.buttonTextColor,size: progressbarSize ?? (22.h+1)) : child,
    ),
  );
}