class AvailableBank {
  AvailableBank({
      this.status, 
      this.data, 
      this.error,});

  AvailableBank.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BankData.fromJson(v));
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
  List<BankData>? data;
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

class BankData {
  BankData({
      this.id, 
      this.title, 
      this.swiftCode, 
      this.currency, 
      this.routingNumber, 
      this.country,});

  BankData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    swiftCode = json['swift_code'];
    currency = json['currency'];
    routingNumber = json['routing_number'];
    country = json['country'];
  }
  num? id;
  String? title;
  String? swiftCode;
  String? currency;
  String? routingNumber;
  String? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['swift_code'] = swiftCode;
    map['currency'] = currency;
    map['routing_number'] = routingNumber;
    map['country'] = country;
    return map;
  }

}