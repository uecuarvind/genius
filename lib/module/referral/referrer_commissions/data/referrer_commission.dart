class ReferrerCommission {
  ReferrerCommission({
      this.status, 
      this.data, 
      this.error,});

  ReferrerCommission.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CommissionData.fromJson(v));
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
  List<CommissionData>? data;
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

class CommissionData {
  CommissionData({
      this.id, 
      this.date, 
      this.type, 
      this.from, 
      this.amount,});

  CommissionData.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    type = json['type'];
    from = json['from'];
    amount = json['amount'];
  }
  num? id;
  String? date;
  String? type;
  String? from;
  String? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['type'] = type;
    map['from'] = from;
    map['amount'] = amount;
    return map;
  }

}