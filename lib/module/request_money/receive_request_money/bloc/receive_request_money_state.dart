import '../../../../app_helper/enums.dart';
import '../data/receive_request_money_list.dart';

class ReceiveRequestMoneyState {
  ReceiveRequestMoneyList? lists;
  PageState pageState;


  ReceiveRequestMoneyState({this.lists, this.pageState = PageState.Loading});

  ReceiveRequestMoneyState init() {
    return ReceiveRequestMoneyState();
  }

  ReceiveRequestMoneyState clone({ReceiveRequestMoneyList? lists, PageState? pageState}) {
    return ReceiveRequestMoneyState(
      pageState: pageState ?? this.pageState,
      lists: lists ?? this.lists
    );
  }
}
