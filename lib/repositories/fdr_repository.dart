import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/fdr/all_fdr/data/fdr_list.dart';
import 'package:genius_bank/utils/url.dart';

import '../module/fdr/fdr_plan/data/fdr_check_amount.dart';
import '../module/fdr/fdr_plan/data/fdr_plan.dart';

class FdrRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getAllFdr({required String url,required Function(FdrList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url,
      onSuccess: (Map<String,dynamic> data) {
        FdrList list = FdrList.fromJson(data);
        onSuccess(list);
      },
      onError: onError
    );
  }


  Future getPlans({required Function(FdrPlan) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.fdrPlans,
      onSuccess: (Map<String,dynamic> data) {
        FdrPlan plans = FdrPlan.fromJson(data);
        onSuccess(plans);
      },
      onError: onError
    );
  }

  Future checkAmount({required Map<String,String> body,required Function(FdrCheckAmount) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.checkFdrAmount,
      body: body,
      method: Method.POST,
      onSuccess: (Map<String,dynamic> data) {
        FdrCheckAmount fdrData = FdrCheckAmount.fromJson(data);
        onSuccess(fdrData);
      },
      onError: onError
    );
  }

  Future submitFdsRequest({
    required Map<String, String> body,
    required Function(dynamic) onSuccess,
    required Function(Map<String,dynamic>) onError,
  }) async {
    await apiClient.Request(
      url: URL.submitFdrRequest,
      body: body,
      method: Method.POST,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }
}