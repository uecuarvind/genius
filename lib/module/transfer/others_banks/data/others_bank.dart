class OthersBank {
  OthersBank({
      this.status, 
      this.data, 
      this.error,});

  OthersBank.fromJson(dynamic json) {
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
      this.bankName, 
      this.accountNumber, 
      this.accountName, 
      this.nickName, 
      this.detailsUrl, 
      this.sendMoneyUrl,});

  BankData.fromJson(dynamic json) {
    id = json['id'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    nickName = json['nick_name'];
    detailsUrl = json['details_url'];
    sendMoneyUrl = json['send_money_url'];
  }
  num? id;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? nickName;
  String? detailsUrl;
  String? sendMoneyUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bank_name'] = bankName;
    map['account_number'] = accountNumber;
    map['account_name'] = accountName;
    map['nick_name'] = nickName;
    map['details_url'] = detailsUrl;
    map['send_money_url'] = sendMoneyUrl;
    return map;
  }

}