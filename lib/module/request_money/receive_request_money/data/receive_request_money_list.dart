class ReceiveRequestMoneyList {
  ReceiveRequestMoneyList({
      this.status, 
      this.data, 
      this.error,});

  ReceiveRequestMoneyList.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RequestData.fromJson(v));
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
  List<RequestData>? data;
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

class RequestData {
  RequestData({
      this.id, 
      this.senderName, 
      this.amount, 
      this.cost, 
      this.amountToGet, 
      this.receiverName, 
      this.status, 
      this.details, 
      this.date,});

  RequestData.fromJson(dynamic json) {
    id = json['id'];
    senderName = json['senderName'];
    amount = json['amount'];
    cost = json['cost'];
    amountToGet = json['amount_to_get'];
    receiverName = json['receiverName'];
    status = json['status'];
    details = json['details'];
    date = json['date'];
  }
  num? id;
  String? senderName;
  String? amount;
  String? cost;
  String? amountToGet;
  String? receiverName;
  String? status;
  dynamic details;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['senderName'] = senderName;
    map['amount'] = amount;
    map['cost'] = cost;
    map['amount_to_get'] = amountToGet;
    map['receiverName'] = receiverName;
    map['status'] = status;
    map['details'] = details;
    map['date'] = date;
    return map;
  }

}