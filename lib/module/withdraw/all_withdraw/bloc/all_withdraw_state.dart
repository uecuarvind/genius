import '../../../../app_helper/enums.dart';
import '../data/withdraw_list.dart';

class AllWithdrawState {
  WithdrawList? transfers;
  PageState pageState;


  AllWithdrawState({this.transfers, this.pageState = PageState.Loading});

  AllWithdrawState init() {
    return AllWithdrawState();
  }

  AllWithdrawState clone({WithdrawList? transfers, PageState? pageState}) {
    return AllWithdrawState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
