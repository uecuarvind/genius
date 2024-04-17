import 'package:genius_bank/module/request_money/all_request_money/data/request_money_list.dart';

import '../../../../app_helper/enums.dart';

class AllRequestMoneyState {
  RequestMoneyList? lists;
  PageState pageState;


  AllRequestMoneyState({this.lists, this.pageState = PageState.Loading});

  AllRequestMoneyState init() {
    return AllRequestMoneyState();
  }

  AllRequestMoneyState clone({RequestMoneyList? lists, PageState? pageState}) {
    return AllRequestMoneyState(
      pageState: pageState ?? this.pageState,
      lists: lists ?? this.lists
    );
  }
}
