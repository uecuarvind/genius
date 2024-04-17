import 'package:flutter/material.dart';

class ApplyLoan {
  ApplyLoan({
      this.status, 
      this.data, 
      this.error,});

  ApplyLoan.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? LoanData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  LoanData? data;
  List<dynamic>? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LoanData {
  LoanData({
      this.title, 
      this.planId, 
      this.loanAmount, 
      this.perInstallment,
      this.totalInstallment, 
      this.totalAmountPay, 
      this.dynamicFields,});

  LoanData.fromJson(dynamic json) {
    title = json['title'];
    planId = json['plan_id'];
    loanAmount = json['loan_amount'];
    perInstallment = json['per_installment'];
    totalInstallment = json['total_installment'];
    totalAmountPay = json['total_amount_pay'];
    if(json['dynamic_fields'] != null && json['dynamic_fields'].isNotEmpty){
      dynamicFields = DynamicFields.fromJson(json['dynamic_fields']);
    }
  }
  String? title;
  num? planId;
  String? loanAmount;
  String? perInstallment;
  String? totalInstallment;
  String? totalAmountPay;
  DynamicFields? dynamicFields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['plan_id'] = planId;
    map['loan_amount'] = loanAmount;
    map['per_installment'] = perInstallment;
    map['total_installment'] = totalInstallment;
    map['total_amount_pay'] = totalAmountPay;
    if (dynamicFields != null) {
      map['dynamic_fields'] = dynamicFields;
    }
    return map;
  }

}

class DynamicFields{
  List<Fields>? fields;

  DynamicFields({this.fields});

  DynamicFields.fromJson(Map<String, dynamic>json) {
    fields = [];
    json.forEach((key, value) {
      fields?.add(
        Fields(
          key: value,
          label: value.toString().replaceAll('_', ' '),
          isTextField: key.toString() != 'file',
          controller: TextEditingController()
        )
      );
    });
  }
}

class Fields{
  String? key,label;
  dynamic data;
  bool? isTextField;
  TextEditingController? controller;

  Fields({this.key, this.label, this.data, this.isTextField,this.controller});

}