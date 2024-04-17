import 'dart:io';
import 'package:flutter/material.dart';
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
import 'kyc_controller.dart';

class KycVerificationScreen extends StatefulWidget{
  const KycVerificationScreen({super.key});

  @override
  State<KycVerificationScreen> createState() =>KycVerificationState();

}

class KycVerificationState extends State<KycVerificationScreen> {
  KycController controller=Get.put(KycController());
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).kyc_form),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            16.verticalSpace,
            Obx(() => Row(
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        controller.tabIndex.value=0;
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        margin:const  EdgeInsets.only(left: 5,right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.tabIndex.value==0?AppColor.primary:Colors.grey
                        ),
                        child:  Text('NON DIGILOCKER',style:TextStyle(fontSize: 14,fontWeight: FontWeight.normal,
                            color:controller.tabIndex.value==0?Colors.white:AppColor.textColor ) ,),
                      ),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        controller.tabIndex.value=1;
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        margin:const  EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.tabIndex.value==1?AppColor.primary:Colors.grey
                        ),
                        child:  Text('DIGILOCKER',style:TextStyle(fontSize: 14,fontWeight: FontWeight.normal,
                            color:controller.tabIndex.value==1?Colors.white:AppColor.textColor ) ,),
                      ),
                    )
                ),
              ],
            )),
            Obx(() => controller.tabIndex.value==0?
            Form(
                key:formKey,
                child:Obx((){
                  controller.count.value;
                  return ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.only(left: 16.r,right: 16.r),
                    children: [
                      20.verticalSpace,
                      Text('Verify Aadhar',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                          color:AppColor.textColor ) ,),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filePicker(0,controller.image0),
                          filePicker(1,controller.image1),
                        ],
                      ),
                      16.verticalSpace,
                      Container(
                        margin: EdgeInsets.only(bottom: 10.r),
                        child: DefaultTextField(
                          controller: controller.aadharNumberController,
                          label: 'Aadhar Number',
                          textInputType:TextInputType.number,
                          //enableValidation: field.required!,
                          isRequired: true,
                        ),
                      ),
                      20.verticalSpace,
                      Text('Verify Pan',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                          color:AppColor.textColor ) ,),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filePicker(2,controller.image2),
                          filePicker(3,controller.image3),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.r),
                        child: DefaultTextField(
                          controller: controller.panCardNumberController,
                          label: 'Pan Number',
                          textInputType:TextInputType.number,
                          //enableValidation: field.required!,
                          isRequired: true,
                        ),
                      ),
                      20.verticalSpace,
                      Text('Verify Voter',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                          color:AppColor.textColor) ,),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filePicker(4,controller.image4),
                          filePicker(5,controller.image5),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.r),
                        child: DefaultTextField(
                          controller: controller.voterIdController,
                          label: 'Voter ID',
                          textInputType:TextInputType.number,
                          //enableValidation: field.required!,
                          isRequired: true,
                        ),
                      ),
                      //: CircularProgress(height: 0.2.sh),
                      10.verticalSpace,
                      DefaultButton(
                          onTap: (){
                           controller.openKycStep2();
                          },
                          // enable: state.formData!=null,
                          isLoading: controller.btnLoading,
                          child: Text(appLanguage(context).submit,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textMedium),)
                      )
                    ],
                  );
                })
            ):
            Center(
              child: Container(
               height: 50,
                margin: const EdgeInsets.only(left: 20,right: 20,top: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Text("Digilocker Verification",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.white),
                textAlign: TextAlign.center,),
              ),
            ))





          ],
        ),
      ),
    );
  }


  TextInputType getTextInputType(String type) {
    switch(type.toLowerCase()){
      case 'text' :
        return TextInputType.text;
      case 'textarea' :
        return TextInputType.text;
      case 'number':
        return TextInputType.number;
      default :
        return TextInputType.text;
    }
  }

  Widget filePicker(int index,File? imageFile) {
    return Container(
      height: 150.r,width: 150.r,
      margin: EdgeInsets.only(bottom: 10.r),
      decoration: BoxDecoration(
          color: AppColor.textFieldBackground,
          borderRadius: BorderRadius.circular(5.r)
      ),
      padding: EdgeInsets.all(10.r),
      child: Stack(
        fit: StackFit.loose,
        children: [
          SizedBox(
              height: 140.r,width: 140.r,
              child: imageFile!=null?
              Image.file(imageFile,height: 140.h,width: 140.h,):
              Assets.images.empty.image(height: 140.h,width: 140.h,)),



          Positioned(
            top: 45,left: 40,
            child: IconButton(
                onPressed: () async {
                  var image = await getSingleImage();
                  if(image!=null){
                    setImages(index, image);
                  }
                },
                icon: Icon(Icons.camera_alt,color: AppColor.iconColor,)
            ),
          )
        ],
      ),
    );
  }


  void setImages(int index,File imageFile){
    switch(index){
      case 0:{
      controller.image0=imageFile;
      controller.increaseCount();
      }break;
      case 1:{
        controller.image1=imageFile;
        controller.increaseCount();
      }break;
      case 2:{
        controller.image2=imageFile;
        controller.increaseCount();
      }break;
      case 3:{
        controller.image3=imageFile;
        controller.increaseCount();
      }break;
      case 4:{
        controller.image4=imageFile;
        controller.increaseCount();
      }break;
      case 5:{
        controller.image5=imageFile;
        controller.increaseCount();
      }break;
    }
  }
}