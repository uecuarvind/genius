import '../../../../app_helper/enums.dart';
import '../data/save_accounts.dart';

class SendMoneyState {
  SaveAccounts? bankList;
  PageState pageState;
  AccountData? selectedBank;
  bool loading;


  SendMoneyState({this.bankList, this.pageState = PageState.Loading, this.loading = false,this.selectedBank});

  SendMoneyState init() {
    return SendMoneyState();
  }

  SendMoneyState clone({SaveAccounts? bankList, PageState? pageState,bool? loading,AccountData? selectedBank}) {
    return SendMoneyState(
      pageState: pageState ?? this.pageState,
      bankList: bankList ?? this.bankList,
      loading: loading ?? this.loading,
      selectedBank: selectedBank ?? this.selectedBank
    );
  }
}
