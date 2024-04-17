import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/dps/all_dps/data/dps.dart';
import 'package:genius_bank/module/loan/log_details/data/logs.dart';
import 'package:genius_bank/utils/url.dart';

import '../module/dps/dps_plan/data/dps_plan.dart';

class DpsRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getAllDps({required String url,required Function(Dps) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url,
      onSuccess: (Map<String,dynamic> data) {
        Dps dps = Dps.fromJson(data);
        onSuccess(dps);
      },
      onError: onError
    );
  }

  Future getLoanLogs({required String url,required Function(Logs) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url,
      onSuccess: (Map<String,dynamic> data) {
        Logs logs = Logs.fromJson(data);
        onSuccess(logs);
      },
      onError: onError
    );
  }

  Future getPlans({required Function(DpsPlan) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.dpsPlans,
      onSuccess: (Map<String,dynamic> data) {
        DpsPlan plans = DpsPlan.fromJson(data);
        onSuccess(plans);
      },
      onError: onError
    );
  }

  Future submitDpsRequest({
    required Map<String, String> body,
    required Function(dynamic) onSuccess,
    required Function(Map<String,dynamic>) onError,
  }) async {
    await apiClient.Request(
      url: URL.submitDpsRequest,
      body: body,
      method: Method.POST,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }
}