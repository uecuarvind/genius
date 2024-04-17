
import 'package:get/get.dart';


class Kyc2Controller extends GetxController {
  RxBool showProgressbar=false.obs;
  Map<String, dynamic> bodyParamsForSalesRegistrationForm = {};
  RxInt tabIndex=0.obs;
  final count=0.obs;
  final btnLoading=false;
  String selectedBank='Panjab Nation Bank';
  List<String> bankList=['Panjab Nation Bank','State Bank Of India','ICICI','Canera Bank','Gramin Bank','HDFC','PayTM Bank','AU Bank'];



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

  incrementCount()=>count.value++;
  changeProgressbarStatus(bool value){
    showProgressbar.value=value;
  }
  increaseCount()=>count.value++;
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