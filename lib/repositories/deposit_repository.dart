import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/deposit/all_deposit/data/deposit_data.dart' as Deposit;
import 'package:genius_bank/module/deposit/all_deposit/data/deposit_list.dart';
import 'package:genius_bank/utils/app_constant.dart';
import 'package:genius_bank/utils/url.dart';

class DepositRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getDepositList({required Function(DepositList) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.depositList,
      onSuccess: (Map<String,dynamic> data) {
        DepositList deposit = DepositList.fromJson(data);
        onSuccess(deposit);
      },
      onError: onError
    );
  }

  Future applyForDeposit({required String amount,required Function(Deposit.DepositData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.applyDeposit,
      method: Method.POST,
      body: {
        AppConstant.amount : amount
      },
      onSuccess: (Map<String,dynamic> data) {
        Deposit.DepositData deposit = Deposit.DepositData.fromJson(data);
        onSuccess(deposit);
      },
      onError: onError
    );
  }
}