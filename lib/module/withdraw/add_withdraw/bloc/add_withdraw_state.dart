import 'package:genius_bank/module/withdraw/add_withdraw/data/methods.dart';

import '../../../../app_helper/enums.dart';

class AddWithdrawState {
  Methods? methods;
  PageState pageState;
  MethodData? method;
  bool loading;


  AddWithdrawState({this.methods, this.pageState = PageState.Loading, this.loading = false,this.method});

  AddWithdrawState init() {
    return AddWithdrawState();
  }

  AddWithdrawState clone({Methods? methods, PageState? pageState,bool? loading,MethodData? method}) {
    return AddWithdrawState(
      pageState: pageState ?? this.pageState,
      methods: methods ?? this.methods,
      loading: loading ?? this.loading,
      method: method ?? this.method
    );
  }
}
