import 'package:flutter/material.dart';

class OthersBank {
  OthersBank({
      this.status, 
      this.data, 
      this.error,});

  OthersBank.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BankData.fromJson(v));
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
  List<BankData>? data;
  List<dynamic>? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class BankData {
  BankData({
      this.id, 
      this.title, 
      this.minAmount, 
      this.maxAmount, 
      this.dailyAmountLimit, 
      this.monthlyAmountLimit, 
      this.dailyTransactionLimit, 
      this.monthlyTransactionLimit, 
      this.dynamicFields,});

  BankData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    dailyAmountLimit = json['daily_amount_limit'];
    monthlyAmountLimit = json['monthly_amount_limit'];
    dailyTransactionLimit = json['daily_transaction_limit'];
    monthlyTransactionLimit = json['monthly_transaction_limit'];
    if (json['dynamic_fields'] != null) {
      dynamicFields = [];
      json['dynamic_fields'].forEach((v) {
        dynamicFields?.add(DynamicFields.fromJson(v));
      });
    }
  }
  num? id;
  String? title;
  String? minAmount;
  String? maxAmount;
  String? dailyAmountLimit;
  String? monthlyAmountLimit;
  String? dailyTransactionLimit;
  String? monthlyTransactionLimit;
  List<DynamicFields>? dynamicFields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['min_amount'] = minAmount;
    map['max_amount'] = maxAmount;
    map['daily_amount_limit'] = dailyAmountLimit;
    map['monthly_amount_limit'] = monthlyAmountLimit;
    map['daily_transaction_limit'] = dailyTransactionLimit;
    map['monthly_transaction_limit'] = monthlyTransactionLimit;
    if (dynamicFields != null) {
      map['dynamic_fields'] = dynamicFields?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DynamicFields {
  DynamicFields({
    this.fieldName,
    this.type,
    this.validation,
    this.data,
    this.controller
  });

  DynamicFields.fromJson(dynamic json) {
    fieldName = json['field_name'];
    type = json['type'];
    validation = json['validation'];
    controller = TextEditingController();
  }
  String? fieldName;
  String? type;
  String? validation;
  dynamic data;
  TextEditingController? controller;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['field_name'] = fieldName;
    map['type'] = type;
    map['validation'] = validation;
    return map;
  }

}