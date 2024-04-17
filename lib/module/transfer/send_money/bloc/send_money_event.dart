

import '../data/save_accounts.dart';

abstract class SendMoneyEvent {}

class InitEvent extends SendMoneyEvent {
  dynamic page;
  InitEvent(this.page);
}
class GetAvailableBank extends SendMoneyEvent {}
class SubmitTransfer extends SendMoneyEvent {}
class SearchAccount extends SendMoneyEvent {}
class SelectMethod extends SendMoneyEvent {
  AccountData account;
  SelectMethod(this.account);
}