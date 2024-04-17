import 'package:genius_bank/module/wire_transfer/add_wire_transfer/data/available_bank.dart';

import '../../../../app_helper/enums.dart';

class AddWireTransferState {
  AvailableBank? availableBank;
  PageState pageState;
  BankData? selectBank;
  bool loading;


  AddWireTransferState({this.availableBank, this.pageState = PageState.Loading, this.loading = false,this.selectBank});

  AddWireTransferState init() {
    return AddWireTransferState();
  }

  AddWireTransferState clone({AvailableBank? availableBank, PageState? pageState,bool? loading,BankData? selectBank}) {
    return AddWireTransferState(
      pageState: pageState ?? this.pageState,
      availableBank: availableBank ?? this.availableBank,
      loading: loading ?? this.loading,
      selectBank: selectBank ?? this.selectBank
    );
  }
}
