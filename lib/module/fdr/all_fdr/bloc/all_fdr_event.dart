import 'package:flutter/material.dart';

abstract class AllFdrEvent {}

class InitEvent extends AllFdrEvent {
  BuildContext context;

  InitEvent(this.context);
}
class GetData extends AllFdrEvent {}