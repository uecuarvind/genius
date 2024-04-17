import 'package:flutter/material.dart';

abstract class TicketsEvent {}

class InitEvent extends TicketsEvent {}

class DeleteEvent extends TicketsEvent {
  int index;
  DeleteEvent(this.index);
}

class SendNewDataEvent extends TicketsEvent {
  Map<String,String> body;

  SendNewDataEvent(this.body);
}