import 'package:flutter/src/widgets/framework.dart';

abstract class SignInEvent {}

class InitEvent extends SignInEvent {
  BuildContext context;
  InitEvent(this.context);
}

class RememberMe extends SignInEvent {
  bool value;
  RememberMe(this.value);
}

class SubmitData extends SignInEvent {}
class TwoFaVerification extends SignInEvent {
  String code;

  TwoFaVerification(this.code);
}