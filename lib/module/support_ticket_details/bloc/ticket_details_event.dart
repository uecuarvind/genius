import 'package:flutter/material.dart';

abstract class TicketDetailsEvent {}

class InitEvent extends TicketDetailsEvent {
  BuildContext context;

  InitEvent(this.context);
}
class GetReply extends TicketDetailsEvent {}
class SendMessageEvent extends TicketDetailsEvent {}