
import 'package:flutter/material.dart';

abstract class SignUpEvent {}

class InitEvent extends SignUpEvent {
  BuildContext context;
  InitEvent(this.context);
}

class RememberMe extends SignUpEvent {
  bool value;
  RememberMe(this.value);
}

class SubmitData extends SignUpEvent {}