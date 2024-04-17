



import 'package:flutter/material.dart';

abstract class OthersBankTransferEvent {}

class InitEvent extends OthersBankTransferEvent {
  BuildContext context;
  InitEvent(this.context);
}
class SubmitTransfer extends OthersBankTransferEvent {}
class GetDetails extends OthersBankTransferEvent {}