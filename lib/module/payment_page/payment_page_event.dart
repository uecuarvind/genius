import 'package:flutter/material.dart';
import 'package:genius_bank/app_helper/enums.dart';

abstract class PaymentPageEvent {}

class InitEvent extends PaymentPageEvent {
  BuildContext context;
  InitEvent(this.context);
}
class PageLoadEvent extends PaymentPageEvent {
  PageState pageState;

  PageLoadEvent(this.pageState);
}