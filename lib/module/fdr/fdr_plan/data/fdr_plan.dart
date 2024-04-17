class FdrPlan {
  FdrPlan({
      this.status, 
      this.data, 
      this.error,});

  FdrPlan.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PlanData.fromJson(v));
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
  List<PlanData>? data;
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

class PlanData {
  PlanData({
      this.id, 
      this.title, 
      this.interestRate, 
      this.minAmount, 
      this.maxAmount, 
      this.intervalType, 
      this.lockedInPeriod, 
      this.getProfitEvery, 
      this.applyUrl,});

  PlanData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    interestRate = json['interest_rate'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    intervalType = json['interval_type'];
    lockedInPeriod = json['locked_in_period'];
    getProfitEvery = json['get_profit_every'];
    applyUrl = json['apply_url'];
  }
  num? id;
  String? title;
  String? interestRate;
  String? minAmount;
  String? maxAmount;
  String? intervalType;
  String? lockedInPeriod;
  String? getProfitEvery;
  String? applyUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['interest_rate'] = interestRate;
    map['min_amount'] = minAmount;
    map['max_amount'] = maxAmount;
    map['interval_type'] = intervalType;
    map['locked_in_period'] = lockedInPeriod;
    map['get_profit_every'] = getProfitEvery;
    map['apply_url'] = applyUrl;
    return map;
  }

}