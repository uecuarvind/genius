import 'package:genius_bank/module/deposit/all_deposit/data/deposit_data.dart' as Deposit;
import 'package:genius_bank/module/deposit/all_deposit/data/deposit_list.dart';

import '../../../../app_helper/enums.dart';

class AllDepositState {
  DepositList? deposits;
  Deposit.DepositData? depositData;
  PageState pageState;
  bool amountVerificationLoading;


  AllDepositState({this.deposits, this.pageState = PageState.Loading,this.amountVerificationLoading = false,this.depositData});

  AllDepositState init() {
    return AllDepositState();
  }

  AllDepositState clone({DepositList? deposits, PageState? pageState,bool? amountVerificationLoading,Deposit.DepositData? depositData}) {
    return AllDepositState(
      pageState: pageState ?? this.pageState,
      deposits: deposits ?? this.deposits,
      amountVerificationLoading: amountVerificationLoading ?? this.amountVerificationLoading,
      depositData: depositData ?? this.depositData
    );
  }
}
