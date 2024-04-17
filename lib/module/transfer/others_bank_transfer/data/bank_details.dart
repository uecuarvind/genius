class BankDetails {
  BankDetails({
      this.status, 
      this.data, 
      this.error,});

  BankDetails.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? BankDetailsData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  BankDetailsData? data;
  List<dynamic>? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class BankDetailsData {
  BankDetailsData({
      this.beneficiaryId, 
      this.otherBankId, 
      this.minAmount, 
      this.maxAmount, 
      this.dailyAmountLimit, 
      this.monthlyAmountLimit, 
      this.dailyTotalTransaction, 
      this.monthlyTotalTransaction, 
      this.bankName, 
      this.accountName,});

  BankDetailsData.fromJson(dynamic json) {
    beneficiaryId = json['beneficiary_id'];
    otherBankId = json['other_bank_id'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    dailyAmountLimit = json['daily_amount_limit'];
    monthlyAmountLimit = json['monthly_amount_limit'];
    dailyTotalTransaction = json['daily_total_transaction'];
    monthlyTotalTransaction = json['monthly_total_transaction'];
    bankName = json['bank_name'];
    accountName = json['account_name'];
  }
  num? beneficiaryId;
  String? otherBankId;
  String? minAmount;
  String? maxAmount;
  String? dailyAmountLimit;
  String? monthlyAmountLimit;
  String? dailyTotalTransaction;
  String? monthlyTotalTransaction;
  String? bankName;
  String? accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['beneficiary_id'] = beneficiaryId;
    map['other_bank_id'] = otherBankId;
    map['min_amount'] = minAmount;
    map['max_amount'] = maxAmount;
    map['daily_amount_limit'] = dailyAmountLimit;
    map['monthly_amount_limit'] = monthlyAmountLimit;
    map['daily_total_transaction'] = dailyTotalTransaction;
    map['monthly_total_transaction'] = monthlyTotalTransaction;
    map['bank_name'] = bankName;
    map['account_name'] = accountName;
    return map;
  }

}