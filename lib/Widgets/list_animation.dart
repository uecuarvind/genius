import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:genius_bank/utils/app_constant.dart';
enum AnimationFrom{top,bottom}
Widget ListAnimation({required int index,required Widget child,AnimationFrom animationFrom = AnimationFrom.top,int? delay}){
  return AnimationConfiguration.staggeredList(
    position: index,
    duration: Duration(milliseconds: delay ?? AppConstant.AnimationDelay),
    child: SlideAnimation(
      verticalOffset: animationFrom== AnimationFrom.top ? -50.0 : 50,
      child: FadeInAnimation(
        child: child,
  )));
}