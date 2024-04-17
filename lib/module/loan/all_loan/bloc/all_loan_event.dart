import 'package:flutter/material.dart';

abstract class AllLoanEvent {}

class InitEvent extends AllLoanEvent {
  BuildContext context;

  InitEvent(this.context);
}
class GetData extends AllLoanEvent {}