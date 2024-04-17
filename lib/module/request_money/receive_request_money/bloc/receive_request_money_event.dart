

abstract class ReceiveRequestMoneyEvent {}

class InitEvent extends ReceiveRequestMoneyEvent {}
class GetData extends ReceiveRequestMoneyEvent {}
class AcceptRequest extends ReceiveRequestMoneyEvent {
  String id;
  AcceptRequest(this.id);
}