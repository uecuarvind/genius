import '../../../../app_helper/enums.dart';
import '../../others_banks/data/others_bank.dart';
import '../data/bank_details.dart';

class OthersBankTransferState {
  PageState pageState;
  bool loading;
  BankData? bankData;
  BankDetails? bankDetails;


  OthersBankTransferState({this.pageState = PageState.Loading, this.loading = false, this.bankData, this.bankDetails});

  OthersBankTransferState init() {
    return OthersBankTransferState();
  }

  OthersBankTransferState clone({ PageState? pageState,bool? loading, BankData? bankData, BankDetails? bankDetails}) {
    return OthersBankTransferState(
      pageState: pageState ?? this.pageState,
      loading: loading ?? this.loading,
      bankData: bankData ?? this.bankData,
      bankDetails: bankDetails ?? this.bankDetails
    );
  }
}
