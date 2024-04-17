class PricingPlan {
  PricingPlan({
      this.status, 
      this.data, 
      this.error,});

  PricingPlan.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PricingData.fromJson(v));
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
  List<PricingData>? data;
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

class PricingData {
  PricingData({
      this.id, 
      this.title, 
      this.amount, 
      this.authUser, 
      this.attribute, 
      this.userCurrentPlan,
      this.planExpireDate,
      this.maximumDailySend,
      this.maximumMonthlySend, 
      this.maximumDailyReceive, 
      this.maximumMonthlyReceive, 
      this.maximumDailyWithdraw, 
      this.maximumMonthlyWithdraw, 
      this.maximumLoanAmount, 
      this.endDays, 
      this.getStarted,});

  PricingData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    authUser = json['auth_user'];
    userCurrentPlan = json['user_current_plan'];
    planExpireDate = json['plan_expire_date'];
    attribute = json['attribute'] != null ? json['attribute'].cast<String>() : [];
    maximumDailySend = json['maximum_daily_send'];
    maximumMonthlySend = json['maximum_monthly_send'];
    maximumDailyReceive = json['maximum_daily_receive'];
    maximumMonthlyReceive = json['maximum_monthly_receive'];
    maximumDailyWithdraw = json['maximum_daily_withdraw'];
    maximumMonthlyWithdraw = json['maximum_monthly_withdraw'];
    maximumLoanAmount = json['maximum_loan_amount'];
    endDays = json['end_days'];
    getStarted = json['get_started'];
  }
  num? id;
  String? title;
  String? amount;
  num? authUser;
  List<String>? attribute;
  String? maximumDailySend;
  String? userCurrentPlan;
  String? planExpireDate;
  String? maximumMonthlySend;
  String? maximumDailyReceive;
  String? maximumMonthlyReceive;
  String? maximumDailyWithdraw;
  String? maximumMonthlyWithdraw;
  String? maximumLoanAmount;
  String? endDays;
  String? getStarted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['auth_user'] = authUser;
    map['attribute'] = attribute;
    map['maximum_daily_send'] = maximumDailySend;
    map['maximum_monthly_send'] = maximumMonthlySend;
    map['maximum_daily_receive'] = maximumDailyReceive;
    map['maximum_monthly_receive'] = maximumMonthlyReceive;
    map['maximum_daily_withdraw'] = maximumDailyWithdraw;
    map['maximum_monthly_withdraw'] = maximumMonthlyWithdraw;
    map['maximum_loan_amount'] = maximumLoanAmount;
    map['end_days'] = endDays;
    map['get_started'] = getStarted;
    return map;
  }

}