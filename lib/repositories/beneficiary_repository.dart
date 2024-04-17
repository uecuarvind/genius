import 'dart:io';

import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/utils/url.dart';

import '../module/transfer/beneficiary/add_beneficiary/data/others_bank.dart';
import '../module/transfer/beneficiary/beneficiary_list/data/beneficiary_list.dart';

class BeneficiaryRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getBeneficiaryList({required Function(BeneficiaryList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.beneficiaryLog,
      onSuccess: (Map<String,dynamic> data) {
        BeneficiaryList beneficiary = BeneficiaryList.fromJson(data);
        onSuccess(beneficiary);
      },
      onError: onError
    );
  }

  Future addBeneficiary({required Map<String, String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.addBeneficiary,
      body: body,
      method: Method.POST,
      onSuccess: onSuccess,
      onError: onError
    );
  }

  Future getOthersBank({required Function(OthersBank) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.getOthersBank,
      onSuccess: (data){
        onSuccess(OthersBank.fromJson(data));
      },
      onError: onError
    );
  }

  Future submitRequest({
    required Map<String, String> body,
    required Function(dynamic) onSuccess,
    required Function(Map<String,dynamic>) onError,
    List<File> files = const [],
    List<String> fileKeys = const [],
  }) async {
    await apiClient.RequestWithFile(
        url: URL.submitBeneficiary,
        body: body,
        method: Method.POST,
        files: files,
        fileKey: fileKeys,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(data);
        },
        onError: onError
    );
  }

}