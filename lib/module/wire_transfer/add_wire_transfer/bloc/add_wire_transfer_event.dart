import 'package:genius_bank/module/wire_transfer/add_wire_transfer/data/available_bank.dart';

abstract class AddWireTransferEvent {}

class InitEvent extends AddWireTransferEvent {}
class GetAvailableBank extends AddWireTransferEvent {}
class SubmitTransfer extends AddWireTransferEvent {}
class SelectBank extends AddWireTransferEvent {
  BankData bank;
  SelectBank(this.bank);
}