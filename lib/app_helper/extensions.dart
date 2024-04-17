import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genius_bank/config/dependency.dart';
import 'package:genius_bank/theme/app_color.dart';

import '../data/currencies.dart';

extension StringExtensions on String {

  String get price {
    CurrencyData data = instance.get<CurrencyData>();
    return '${data.sign}${actualPrice.toStringAsFixed(1)}';
  }

  String get priceWith2Decimal {
    CurrencyData data = instance.get<CurrencyData>();
    return '${data.sign}${actualPrice.toStringAsFixed(2)}';
  }

  String get currency {
    CurrencyData data = instance.get<CurrencyData>();
    return '${data.sign}$this';
  }

  String get numeric {
    return replaceAll(RegExp(r'\D'),'');
  }

  String get capitalCase {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
  String get capitalize {
    return replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.capitalCase).join(' ');
  }

  double get actualPrice {
    CurrencyData data = instance.get<CurrencyData>();
    return data.value!.toDouble * toDouble;
  }

  int get toInt {
    try {
      return int.parse(this);
    } catch(e) {
      return toDouble.round();
    }
  }

  double get toDouble {
    try{
      return double.parse(this);
    } catch(e){
      return 0.0;
    }
  }

  List<String> get toList {
    List<String> list = [];
    try {
      json.decode(this).forEach((v) {
        list.add(v.toString());
      });
    } catch(e) {
      list.add(this);
    }
    return list;
  }

  Color get toColor {
    return AppColor.getColorFromColorCode(this);
  }
}
