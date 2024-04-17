import 'package:flutter/material.dart';
import 'package:genius_bank/theme/app_color.dart';

Widget RectangleShape({required double width,required double height,Color? color}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color ?? AppColor.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(height/2)
        ),
      ),
    ],
  );
}