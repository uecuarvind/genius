class WireTransfers {
  WireTransfers({
      this.status, 
      this.data, 
      this.error,});

  WireTransfers.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(WireData.fromJson(v));
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
  List<WireData>? data;
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

class WireData {
  WireData({
      this.id, 
      this.date, 
      this.bankName, 
      this.swiftCode, 
      this.currency, 
      this.routingNumber, 
      this.country, 
      this.accountName, 
      this.accountNumber, 
      this.amount, 
      this.status, 
      this.details,});

  WireData.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    bankName = json['bank_name'];
    swiftCode = json['swift_code'];
    currency = json['currency'];
    routingNumber = json['routing_number'];
    country = json['country'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    amount = json['amount'];
    status = json['status'];
    details = json['details'];
  }
  num? id;
  String? date;
  String? bankName;
  String? swiftCode;
  String? currency;
  String? routingNumber;
  String? country;
  String? accountName;
  String? accountNumber;
  String? amount;
  String? status;
  String? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['bank_name'] = bankName;
    map['swift_code'] = swiftCode;
    map['currency'] = currency;
    map['routing_number'] = routingNumber;
    map['country'] = country;
    map['account_name'] = accountName;
    map['account_number'] = accountNumber;
    map['amount'] = amount;
    map['status'] = status;
    map['details'] = details;
    return map;
  }

}