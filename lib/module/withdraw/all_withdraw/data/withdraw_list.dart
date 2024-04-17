class WithdrawList {
  WithdrawList({
      this.status, 
      this.data, 
      this.error,});

  WithdrawList.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(WithdrawData.fromJson(v));
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
  List<WithdrawData>? data;
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

class WithdrawData {
  WithdrawData({
      this.id, 
      this.date, 
      this.method, 
      this.amount, 
      this.fee, 
      this.status, 
      this.details,});

  WithdrawData.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    method = json['method'];
    amount = json['amount'];
    fee = json['fee'];
    status = json['status'];
    details = json['details'];
  }
  num? id;
  String? date;
  String? method;
  String? amount;
  String? fee;
  String? status;
  String? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['method'] = method;
    map['amount'] = amount;
    map['fee'] = fee;
    map['status'] = status;
    map['details'] = details;
    return map;
  }

}