import '../data/others_bank.dart';

abstract class AddBeneficiaryEvent {}

class InitEvent extends AddBeneficiaryEvent {}
class GetAvailableBank extends AddBeneficiaryEvent {}
class SubmitTransfer extends AddBeneficiaryEvent {}
class SelectBank extends AddBeneficiaryEvent {
  BankData bank;
  SelectBank(this.bank);
}

class AddFile extends AddBeneficiaryEvent {
  dynamic image;
  int index;
  AddFile(this.image, this.index);
}