



abstract class SubmitRequestMoneyEvent {}

class InitEvent extends SubmitRequestMoneyEvent {
  dynamic page;
  InitEvent(this.page);
}
class SubmitTransfer extends SubmitRequestMoneyEvent {}
class SearchAccount extends SubmitRequestMoneyEvent {}