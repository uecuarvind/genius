import 'package:flutter/material.dart';

abstract class AllDpsEvent {}

class InitEvent extends AllDpsEvent {
  BuildContext context;

  InitEvent(this.context);
}
class GetData extends AllDpsEvent {}