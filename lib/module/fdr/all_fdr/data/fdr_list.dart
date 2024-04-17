class FdrList {
  FdrList({
      this.status, 
      this.data, 
      this.error,});

  FdrList.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FdrData.fromJson(v));
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
  List<FdrData>? data;
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

class FdrData {
  FdrData({
      this.id, 
      this.transactionNo, 
      this.planTitle, 
      this.fdrAmount, 
      this.profitRate, 
      this.profitType, 
      this.profitAmount, 
      this.nextProfitTime, 
      this.status,});

  FdrData.fromJson(dynamic json) {
    id = json['id'];
    transactionNo = json['transaction_no'];
    planTitle = json['plan_title'];
    fdrAmount = json['fdr_amount'];
    profitRate = json['profit_rate'];
    profitType = json['profit_type'];
    profitAmount = json['profit_amount'];
    nextProfitTime = json['next_profit_time'];
    status = json['status'];
  }
  num? id;
  String? transactionNo;
  String? planTitle;
  String? fdrAmount;
  String? profitRate;
  String? profitType;
  String? profitAmount;
  String? nextProfitTime;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['transaction_no'] = transactionNo;
    map['plan_title'] = planTitle;
    map['fdr_amount'] = fdrAmount;
    map['profit_rate'] = profitRate;
    map['profit_type'] = profitType;
    map['profit_amount'] = profitAmount;
    map['next_profit_time'] = nextProfitTime;
    map['status'] = status;
    return map;
  }

}