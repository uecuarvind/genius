class SaveAccounts {
  SaveAccounts({
      this.status, 
      this.data, 
      this.error,});

  SaveAccounts.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AccountData.fromJson(v));
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
  List<AccountData>? data;
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

class AccountData {
  AccountData({
      this.id, 
      this.name, 
      this.accNo, 
      this.photo, 
      this.saveAccountData,});

  AccountData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    accNo = json['acc_no'];
    photo = json['photo'];
    saveAccountData = json['save_account_data'];
  }
  num? id;
  String? name;
  String? accNo;
  String? photo;
  String? saveAccountData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['acc_no'] = accNo;
    map['photo'] = photo;
    map['save_account_data'] = saveAccountData;
    return map;
  }

}