import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../main.dart';


class Kyc3Controller extends GetxController {
  RxBool showProgressbar=false.obs;
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController panCardNumberController = TextEditingController();
  TextEditingController voterIdController = TextEditingController();
  Map<String, dynamic> bodyParamsForSalesRegistrationForm = {};
  Map<String, dynamic> bodyParamsForDealerRegistrationForm = {};
  RxInt tabIndex=0.obs;
  final count=0.obs;
  final btnLoading=false;
  File? image0;
  File? image1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  changeProgressbarStatus(bool value){
    showProgressbar.value=value;
  }
  increaseCount()=>count.value++;

  openKycStep2(){
    goToPage(Routes.KYC_VERIFICATION_Step2_New);
  }
/*
  Future<void> callingSalesRegistrationForm() async {
    bodyParamsForSalesRegistrationForm = {
      ApiKeyConstants.contactNumber: phoneNumberController.text.toString(),
      ApiKeyConstants.state: stateController.text.toString(),
      ApiKeyConstants.city: cityController.text.toString(),
      ApiKeyConstants.contactPerson: contactPersonController.text.toString(),
      ApiKeyConstants.address: addressController.text.toString(),
      ApiKeyConstants.userAddress: userAddressController.text.toString(),
      ApiKeyConstants.userLat: "22.7196",
      ApiKeyConstants.userLang: "75.8577",
      ApiKeyConstants.password: passwordController.text.toString(),
      ApiKeyConstants.userEmail: emailController.text.toString(),

    };
    print("bodyParamsForSales:::::$bodyParamsForSalesRegistrationForm");
    commonResponseModel = await ApiMethods.salesRegistrationForm(
        bodyParams: bodyParamsForSalesRegistrationForm);
    if (commonResponseModel!.statusCode==200 &&commonResponseModel!.status! ) {
      print("Registration Successfully complete...");
      showToastMessage("Registration Successfully complete...");
      Get.back();
    }else{
      print("Registration Failed....");
      showToastMessage(commonResponseModel!.message!);
    }
    changeProgressbarStatus(false);
  }*/

}