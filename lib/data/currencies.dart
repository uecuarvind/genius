

import '../config/dependency.dart';

class Currencies {
  Currencies({
      this.status, 
      this.data, 
      this.error,});

  Currencies.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CurrencyData.fromJson(v));
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
  List<CurrencyData>? data;
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

  static Currencies? getCurrencies(){
    try{
      return instance.get<Currencies>();
    } catch(e){
      return null;
    }
  }

}

class CurrencyData {
  CurrencyData({
      this.id, 
      this.name, 
      this.sign, 
      this.value, 
      this.isDefault,});

  CurrencyData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    sign = json['sign'];
    value = json['value'];
    isDefault = json['is_default'];
  }
  num? id;
  String? name;
  String? sign;
  String? value;
  String? isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['sign'] = sign;
    map['value'] = value;
    map['is_default'] = isDefault;
    return map;
  }
  static CurrencyData? getCurrency(){
    try{
      return instance.get<CurrencyData>();
    } catch(e){
      return null;
    }
  }
}