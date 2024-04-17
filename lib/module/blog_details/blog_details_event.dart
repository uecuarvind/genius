import 'package:flutter/material.dart';
abstract class BlogDetailsEvent {}

class InitEvent extends BlogDetailsEvent {
  BuildContext context;
  InitEvent(this.context);
}