

abstract class AllDepositEvent {}

class InitEvent extends AllDepositEvent {}
class GetData extends AllDepositEvent {}
class ApplyForDeposit extends AllDepositEvent {
  String amount;

  ApplyForDeposit(this.amount);
}