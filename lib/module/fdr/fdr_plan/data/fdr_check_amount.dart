class FdrCheckAmount {
  FdrCheckAmount({
      this.status, 
      this.data, 
      this.error,});

  FdrCheckAmount.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? FdrData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  FdrData? data;
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

class FdrData {
  FdrData({
      this.currency, 
      this.planId, 
      this.planTitle, 
      this.interestRate, 
      this.lockedInPeriod, 
      this.fdrAmount, 
      this.getProfit,
      this.profitAmount,});

  FdrData.fromJson(dynamic json) {
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    planId = json['plan_id'];
    planTitle = json['plan_title'];
    interestRate = json['interest_rate_in_total_deposit'];
    lockedInPeriod = json['locked_in_period'];
    fdrAmount = json['fdr_amount'];
    getProfit = json['get_profit'];
    profitAmount = json['amount_to_get'].toString();
  }
  Currency? currency;
  num? planId;
  String? planTitle;
  String? interestRate;
  String? lockedInPeriod;
  String? fdrAmount;
  String? profitAmount;
  String? getProfit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (currency != null) {
      map['currency'] = currency?.toJson();
    }
    map['plan_id'] = planId;
    map['plan_title'] = planTitle;
    map['interest_rate_in_total_deposit'] = interestRate;
    map['locked_in_period'] = lockedInPeriod;
    map['fdr_amount'] = fdrAmount;
    map['get_profit'] = getProfit;
    map['amount_to_get'] = profitAmount;
    return map;
  }

}

class Currency {
  Currency({
      this.id, 
      this.name, 
      this.sign, 
      this.value, 
      this.isDefault,});

  Currency.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    sign = json['sign'];
    value = json['value'];
    isDefault = json['is_default'];
  }
  String? id;
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

}