import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genius_bank/config/dependency.dart';
import 'package:genius_bank/data/auth.dart';
import 'package:genius_bank/theme/app_color.dart';

import '../gen/assets.gen.dart';


Widget ImagePlaceHolder({double? height,double? width,BoxFit? fit}){
  return Container(
    color: AppColor.buttonTextColor,
    child: Assets.images.empty.image(fit: fit ?? BoxFit.cover,height: height,width: width,),
  );
}
Widget UserImagePlaceHolder({required double height,BoxFit? fit,double? width}){
  Auth? user;
  try{
    user = instance.get<Auth>();
  }catch(e){}
  return Container(
    color: Colors.transparent,
    child: user!=null ? Avatar(
      name: '${user.data!.user!.fullName}',
      placeholderColors: [
        AppColor.primary.withOpacity(0.85)
      ],
      shape: AvatarShape.circle(height/2.5),
    ) :  SvgPicture.asset(Assets.images.user,height: height,width: width??height,fit: fit ?? BoxFit.none,),
  );
}