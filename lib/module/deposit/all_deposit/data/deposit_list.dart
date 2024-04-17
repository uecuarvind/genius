class DepositList {
  DepositList({
      this.status, 
      this.data, 
      this.error,});

  DepositList.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DepositData.fromJson(v));
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
  List<DepositData>? data;
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

class DepositData {
  DepositData({
      this.id, 
      this.depositNumber, 
      this.depositDate, 
      this.method, 
      this.userEmail, 
      this.amount, 
      this.status,});

  DepositData.fromJson(dynamic json) {
    id = json['id'];
    depositNumber = json['deposit_number'];
    depositDate = json['deposit_date'];
    method = json['method'];
    userEmail = json['user_email'];
    amount = json['amount'];
    status = json['status'];
  }
  num? id;
  String? depositNumber;
  String? depositDate;
  String? method;
  String? userEmail;
  String? amount;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deposit_number'] = depositNumber;
    map['deposit_date'] = depositDate;
    map['method'] = method;
    map['user_email'] = userEmail;
    map['amount'] = amount;
    map['status'] = status;
    return map;
  }

}