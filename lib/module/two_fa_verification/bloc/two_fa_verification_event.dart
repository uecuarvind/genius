abstract class TwoFAVerificationEvent {}

class InitEvent extends TwoFAVerificationEvent {}

class ChangeTwoFaState extends TwoFAVerificationEvent {
  String code;

  ChangeTwoFaState(this.code);
}