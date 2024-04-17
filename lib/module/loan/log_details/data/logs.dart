class Logs {
  Logs({
      this.status, 
      this.data, 
      this.error,});

  Logs.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LogData.fromJson(v));
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
  List<LogData>? data;
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

class LogData {
  LogData({
      this.id, 
      this.date, 
      this.transactionNo, 
      this.amount,});

  LogData.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    transactionNo = json['transaction_no'];
    amount = json['amount'];
  }
  num? id;
  String? date;
  String? transactionNo;
  String? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['transaction_no'] = transactionNo;
    map['amount'] = amount;
    return map;
  }

}