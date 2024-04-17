import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:genius_bank/utils/app_constant.dart';

Widget GridAnimation({required int index,required Widget child,int column=2}){
  return AnimationConfiguration.staggeredGrid(
    position: index,
    duration: Duration(milliseconds: AppConstant.AnimationDelay),
    columnCount: column,
    child: ScaleAnimation(
      child: FadeInAnimation(
        child: child,
      ),
    ),
  );
}