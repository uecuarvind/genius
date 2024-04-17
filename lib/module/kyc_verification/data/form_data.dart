import 'package:flutter/material.dart';

class FormData {
  FormData({
      this.status, 
      this.data, 
      this.error,});

  FormData.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DynamicForm(
          type: v['type'].toString(),
          name: v['name'].toString(),
          required: v['required'].toString() == 'true',
          label: v['name'].toString().replaceAll('_', ' '),
          isTextField: v['type'].toString() != 'file',
          controller: TextEditingController(),
        ));
      });
    }
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  List<DynamicForm>? data;
  List<dynamic>? error;

}

class DynamicForm {
  DynamicForm({
      this.type, 
      this.name, 
      this.required,
      this.label,
      this.data,
      this.isTextField,
      this.controller,
  });

  String? type;
  String? name;
  bool? required;
  String? label;
  dynamic data;
  bool? isTextField;
  TextEditingController? controller;
}