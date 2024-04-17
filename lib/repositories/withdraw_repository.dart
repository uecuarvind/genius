import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/withdraw/add_withdraw/data/methods.dart';
import 'package:genius_bank/utils/url.dart';

import '../module/withdraw/all_withdraw/data/withdraw_list.dart';

class WithdrawRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getWithdrawList({required Function(WithdrawList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.withdrawList,
      onSuccess: (Map<String,dynamic> data) {
        WithdrawList transfers = WithdrawList.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getMethods({required Function(Methods) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.methods,
      onSuccess: (Map<String,dynamic> data) {
        Methods methods = Methods.fromJson(data);
        onSuccess(methods);
      },
      onError: onError
    );
  }

  Future submitTransfer({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.submitWithdraw,
      method: Method.POST,
      body: body,
      onSuccess: onSuccess,
      onError: onError
    );
  }
}