import 'dart:io';
import 'package:flutter/material.dart';
import 'package:genius_bank/module/kyc_verification/kyc2_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/get_image.dart';
import 'package:genius_bank/utils/dimension.dart';
import '../../../../Widgets/default_appbar.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/default_textfield.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../../theme/app_color.dart';

class KycVerification2Screen extends StatefulWidget{
  const KycVerification2Screen({super.key});

  @override
  State<KycVerification2Screen> createState() =>KycVerification2State();

}

class KycVerification2State extends State<KycVerification2Screen> {
  Kyc2Controller controller=Get.put(Kyc2Controller());
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).kyc_form),
      bottomNavigationBar:Container(
        height: 50,
        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
        child: DefaultButton(
            onTap: (){
              //controller.openKycStep2();
            },
            // enable: state.formData!=null,
            isLoading: controller.btnLoading,
            child: Text(appLanguage(context).next,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textMedium),)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text('Select Identity Type',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                color:AppColor.textColor) ,),
            5.verticalSpace,
            Text('should be your government issue photo identity',style:TextStyle(fontSize: 12,fontWeight: FontWeight.normal,
                color:AppColor.textColor) ,),
            Obx(() => Column(
              children: [
                10.verticalSpace,
                GestureDetector(
                  onTap: (){
                    controller.tabIndex.value=0;
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 0.5,color: Colors.grey)
                    ),
                    clipBehavior: Clip.hardEdge,
                    elevation: 5,
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin:const  EdgeInsets.only(left: 5,right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Colors.white
                      ),
                      child:  Row(
                        children: [
                          const SizedBox(width: 10,),
                          controller.tabIndex.value==0?const Icon(Icons.check_circle,color:AppColor.primary,size: 20 ,):
                          const Icon(Icons.circle_outlined,color:Colors.grey,size: 20 ,),
                          const SizedBox(width: 10,),
                          Text('BANK STATEMENT',style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,
                              color:controller.tabIndex.value==0?AppColor.primary:AppColor.textColor ) ,),
                        ],
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                GestureDetector(
                  onTap: (){
                    controller.tabIndex.value=1;
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(width: 0.5,color: Colors.grey)
                    ),
                    clipBehavior: Clip.hardEdge,
                    elevation: 5,
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin:const  EdgeInsets.only(left: 5,right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Colors.white
                      ),
                      child:  Row(
                        children: [
                          const SizedBox(width: 10,),
                          controller.tabIndex.value==1?const Icon(Icons.check_circle,color:AppColor.primary,size: 20 ,):
                          const Icon(Icons.circle_outlined,color:Colors.grey,size: 20 ,),
                          const SizedBox(width: 10,),
                          Text('NET BANKING',style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,
                              color:controller.tabIndex.value==1?AppColor.primary:AppColor.textColor ) ,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),

            20.verticalSpace,
            Text('Select Bank for Statement',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                color:AppColor.textColor) ,),

             20.verticalSpace,
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(width: 0.5,color: Colors.grey)
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 5,
              child:  Container(
                height: 50,
                  margin: const EdgeInsets.only(left: 8,right: 10),
                  alignment: Alignment.center,
                  child: bankDropDownButton()),
            )

          ],
        ),
      ),
    );
  }

  Widget bankDropDownButton(){
    return Obx(() {
      controller.count.value;
      return DropdownButton(
        value: controller.selectedBank,
        hint:const  Text('Select City',   style: TextStyle(fontSize: 12,
            fontWeight:FontWeight.bold,
            color: Colors.black87)),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down,color: AppColor.primary,),

        // Array list of items
        items: controller.bankList.map((String items) {
          return DropdownMenuItem(
            value: items,
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.only(top: 12,left: 5),
              child: Text(items,
                style:const TextStyle(
                    fontSize: 12,
                    fontWeight:FontWeight.bold,
                    color:Colors.black87),),
            ),
          );
        }).toList(),
        isExpanded:true,
        elevation: 2,
        underline: Container(
          color: Colors.white,),
        onChanged: (newValue) {
          //int selectedIndex = controller.cityList.indexWhere((city) => city.id == newValue);
          controller.selectedBank = newValue!;
          controller.incrementCount();
        },
      );
    });
  }

}