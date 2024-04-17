import 'package:flutter/material.dart';

abstract class LogDetailsEvent {}

class InitEvent extends LogDetailsEvent {
  BuildContext context;

  InitEvent(this.context);
}
class GetData extends LogDetailsEvent {}