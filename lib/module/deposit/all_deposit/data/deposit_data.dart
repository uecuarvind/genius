class DepositData {
  DepositData({
      this.status, 
      this.data, 
      this.error,});

  DepositData.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  Data? data;
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

class Data {
  Data({
      this.id, 
      this.depositNumber, 
      this.depositDate, 
      this.method, 
      this.userEmail, 
      this.amount, 
      this.status, 
      this.payUrl,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    depositNumber = json['deposit_number'];
    depositDate = json['deposit_date'];
    method = json['method'];
    userEmail = json['user_email'];
    amount = json['amount'];
    status = json['status'];
    payUrl = json['pay_url'];
  }
  num? id;
  String? depositNumber;
  String? depositDate;
  dynamic method;
  String? userEmail;
  String? amount;
  String? status;
  String? payUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deposit_number'] = depositNumber;
    map['deposit_date'] = depositDate;
    map['method'] = method;
    map['user_email'] = userEmail;
    map['amount'] = amount;
    map['status'] = status;
    map['pay_url'] = payUrl;
    return map;
  }

}