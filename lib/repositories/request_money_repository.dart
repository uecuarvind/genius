import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/request_money/all_request_money/data/request_money_list.dart';
import 'package:genius_bank/module/request_money/receive_request_money/data/receive_request_money_list.dart';
import 'package:genius_bank/utils/url.dart';

class RequestMoneyRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getAllRequestData({required Function(RequestMoneyList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.requestMoneyList,
      onSuccess: (Map<String,dynamic> data) {
        RequestMoneyList list = RequestMoneyList.fromJson(data);
        onSuccess(list);
      },
      onError: onError
    );
  }

  Future getAllReceiveRequestData({required Function(ReceiveRequestMoneyList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.receiveRequestMoneyList,
      onSuccess: (Map<String,dynamic> data) {
        ReceiveRequestMoneyList list = ReceiveRequestMoneyList.fromJson(data);
        onSuccess(list);
      },
      onError: onError
    );
  }

  Future acceptReceiveRequestData({required String id, required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.acceptReceiveRequestMoney+id,
      onSuccess: onSuccess,
      onError: onError
    );
  }


  Future submitRequestMoney({
    required Map<String, String> body,
    required Function(dynamic) onSuccess,
    required Function(Map<String,dynamic>) onError,
  }) async {
    await apiClient.Request(
      url: URL.submitRequestMoney,
      body: body,
      method: Method.POST,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }
}