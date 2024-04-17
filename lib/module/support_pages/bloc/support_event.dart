import 'package:flutter/material.dart';

abstract class SupportEvent {}

class InitEvent extends SupportEvent {
  BuildContext context;
  InitEvent(this.context);
}