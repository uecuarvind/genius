class TransferLog {
  TransferLog({
      this.status, 
      this.data, 
      this.error,});

  TransferLog.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TransferData.fromJson(v));
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
  List<TransferData>? data;
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

class TransferData {
  TransferData({
      this.id, 
      this.date, 
      this.transactionNo, 
      this.userId, 
      this.receiverId, 
      this.accountNo, 
      this.accountNae, 
      this.type, 
      this.amount, 
      this.status,});

  TransferData.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    transactionNo = json['transaction_no'];
    userId = json['user_id'];
    receiverId = json['receiver_id'];
    accountNo = json['account_no'];
    accountNae = json['account_name'];
    type = json['type'];
    amount = json['amount'];
    status = json['status'];
  }
  num? id;
  String? date;
  String? transactionNo;
  String? userId;
  String? receiverId;
  String? accountNo;
  String? accountNae;
  String? type;
  String? amount;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['transaction_no'] = transactionNo;
    map['user_id'] = userId;
    map['receiver_id'] = receiverId;
    map['account_no'] = accountNo;
    map['account_name'] = accountNae;
    map['type'] = type;
    map['amount'] = amount;
    map['status'] = status;
    return map;
  }

}