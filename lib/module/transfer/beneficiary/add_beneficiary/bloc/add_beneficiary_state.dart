import 'package:genius_bank/module/transfer/beneficiary/add_beneficiary/data/others_bank.dart';

import '../../../../../app_helper/enums.dart';

class AddBeneficiaryState {
  OthersBank? availableBank;
  PageState pageState;
  BankData? selectBank;
  bool loading;


  AddBeneficiaryState({this.availableBank, this.pageState = PageState.Loading, this.loading = false,this.selectBank});

  AddBeneficiaryState init() {
    return AddBeneficiaryState();
  }

  AddBeneficiaryState clone({OthersBank? availableBank, PageState? pageState,bool? loading,BankData? selectBank}) {
    return AddBeneficiaryState(
      pageState: pageState ?? this.pageState,
      availableBank: availableBank ?? this.availableBank,
      loading: loading ?? this.loading,
      selectBank: selectBank ?? this.selectBank
    );
  }
}
