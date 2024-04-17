import 'package:genius_bank/module/transactions/data/transactions.dart';

import '../../../../app_helper/enums.dart';

class TransactionsState {
  Transactions? transfers;
  PageState pageState;


  TransactionsState({this.transfers, this.pageState = PageState.Loading});

  TransactionsState init() {
    return TransactionsState();
  }

  TransactionsState clone({Transactions? transfers, PageState? pageState}) {
    return TransactionsState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
