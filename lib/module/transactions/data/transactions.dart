class Transactions {
  Transactions({
      this.status, 
      this.data, 
      this.error,});

  Transactions.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TransactionData.fromJson(v));
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
  List<TransactionData>? data;
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

class TransactionData {
  TransactionData({
      this.id, 
      this.txnid, 
      this.userId, 
      this.email, 
      this.type, 
      this.amount, 
      this.profit, 
      this.date,});

  TransactionData.fromJson(dynamic json) {
    id = json['id'];
    txnid = json['txnid'];
    userId = json['user_id'];
    email = json['email'];
    type = json['type'];
    amount = json['amount'];
    profit = json['profit'];
    date = json['date'];
  }
  num? id;
  String? txnid;
  String? userId;
  String? email;
  String? type;
  String? amount;
  String? profit;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['txnid'] = txnid;
    map['user_id'] = userId;
    map['email'] = email;
    map['type'] = type;
    map['amount'] = amount;
    map['profit'] = profit;
    map['date'] = date;
    return map;
  }

}