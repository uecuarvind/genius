import 'package:genius_bank/module/withdraw/add_withdraw/data/methods.dart';

abstract class AddWithdrawEvent {}

class InitEvent extends AddWithdrawEvent {}
class GetAvailableBank extends AddWithdrawEvent {}
class SubmitTransfer extends AddWithdrawEvent {}
class SelectMethod extends AddWithdrawEvent {
  MethodData method;
  SelectMethod(this.method);
}