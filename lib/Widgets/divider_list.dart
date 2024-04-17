import 'package:flutter/material.dart';
import 'package:genius_bank/theme/app_color.dart';

Widget DividerList({
  required Widget child,
  bool showDivider=true,
  Color? color,
  EdgeInsetsGeometry? padding
}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: padding,
        child: child,
      ),
      Visibility(visible:showDivider,child: Divider(height: 1,thickness: 1,color: color ?? AppColor.dividerColor,))
    ],
  );
}