class Dashboard {
  Dashboard({
      this.status, 
      this.data, 
      this.error,});

  Dashboard.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  Data? data;
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

class Data {
  Data({
      this.accountNumber, 
      this.availableBalance, 
      this.deposits, 
      this.withdraws, 
      this.transactions, 
      this.loans, 
      this.dps, 
      this.fdr, 
      this.referralLink,});

  Data.fromJson(dynamic json) {
    accountNumber = json['account_number'];
    availableBalance = json['available_balance'];
    deposits = json['deposits'];
    withdraws = json['withdraws'];
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(Transactions.fromJson(v));
      });
    }
    loans = json['loans'];
    dps = json['dps'];
    fdr = json['fdr'];
    referralLink = json['referral_link'];
  }
  String? accountNumber;
  String? availableBalance;
  num? deposits;
  num? withdraws;
  List<Transactions>? transactions;
  num? loans;
  num? dps;
  num? fdr;
  String? referralLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_number'] = accountNumber;
    map['available_balance'] = availableBalance;
    map['deposits'] = deposits;
    map['withdraws'] = withdraws;
    if (transactions != null) {
      map['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    map['loans'] = loans;
    map['dps'] = dps;
    map['fdr'] = fdr;
    map['referral_link'] = referralLink;
    return map;
  }

}

class Transactions {
  Transactions({
      this.id, 
      this.txnid, 
      this.userId, 
      this.email, 
      this.type, 
      this.amount, 
      this.profit, 
      this.date,});

  Transactions.fromJson(dynamic json) {
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