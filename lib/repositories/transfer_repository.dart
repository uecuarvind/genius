import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/transactions/data/transactions.dart';
import 'package:genius_bank/module/transfer/others_bank_transfer/data/bank_details.dart';
import 'package:genius_bank/module/transfer/others_banks/data/others_bank.dart';
import 'package:genius_bank/module/transfer/send_money/data/save_accounts.dart';
import 'package:genius_bank/module/transfer/transfer_list/data/transfer_log.dart';
import 'package:genius_bank/utils/url.dart';

class TransferRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getTransferList({required Function(TransferLog) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.transferLog,
      onSuccess: (Map<String,dynamic> data) {
        TransferLog transfers = TransferLog.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getOthersBankList({required Function(OthersBank) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.othersBankList,
      onSuccess: (Map<String,dynamic> data) {
        OthersBank banks = OthersBank.fromJson(data);
        onSuccess(banks);
      },
      onError: onError
    );
  }

  Future getSavedBankList({required Function(SaveAccounts) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.savedAccounts,
      onSuccess: (Map<String,dynamic> data) {
        SaveAccounts banks = SaveAccounts.fromJson(data);
        onSuccess(banks);
      },
      onError: onError
    );
  }

  Future getTransactions({required Function(Transactions) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.transactions,
      onSuccess: (Map<String,dynamic> data) {
        Transactions transaction = Transactions.fromJson(data);
        onSuccess(transaction);
      },
      onError: onError
    );
  }


  Future searchAccount({required String key,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.searchAccount+key,
      enableShowError: false,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future getBankDetails({required String id,required Function(BankDetails) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.bankDetails+id,
      enableShowError: false,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(BankDetails.fromJson(data));
      },
      onError: onError
    );
  }


  Future sendMoney({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.sendMoney,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }


  Future sendOthersBankTransfer({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.othersBankTransfer,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: onError
    );
  }

}