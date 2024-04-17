import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/wire_transfer/add_wire_transfer/data/available_bank.dart';
import 'package:genius_bank/module/wire_transfer/all_wire_transfer/data/wire_transfers.dart';
import 'package:genius_bank/utils/url.dart';

class WireTransferRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getTransferList({required Function(WireTransfers) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.wireTransfer,
      onSuccess: (Map<String,dynamic> data) {
        WireTransfers transfers = WireTransfers.fromJson(data);
        onSuccess(transfers);
      },
      onError: onError
    );
  }

  Future getAvailableBank({required Function(AvailableBank) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.wireTransferBank,
      onSuccess: (Map<String,dynamic> data) {
        AvailableBank banks = AvailableBank.fromJson(data);
        onSuccess(banks);
      },
      onError: onError
    );
  }

  Future submitTransfer({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.wireTransfer,
      method: Method.POST,
      body: body,
      onSuccess: onSuccess,
      onError: onError
    );
  }
}