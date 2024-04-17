import 'package:flutter/material.dart';

abstract class ApplyLoanEvent {}

class InitEvent extends ApplyLoanEvent {
  BuildContext context;

  InitEvent(this.context);
}

class AddFile extends ApplyLoanEvent {
  dynamic image;
  int index;
  AddFile(this.image, this.index);
}

class SubmitLoanRequest extends ApplyLoanEvent{}