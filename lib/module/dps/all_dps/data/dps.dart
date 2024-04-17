class Dps {
  Dps({
      this.status, 
      this.data, 
      this.error,});

  Dps.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DpsData.fromJson(v));
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
  List<DpsData>? data;
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

class DpsData {
  DpsData({
      this.id, 
      this.transactionNo, 
      this.planTitle, 
      this.depositAmount, 
      this.perInstallment, 
      this.maturedAmount, 
      this.totalInstallment, 
      this.givenInstallment, 
      this.nextInstallment, 
      this.status, 
      this.logs,});

  DpsData.fromJson(dynamic json) {
    id = json['id'];
    transactionNo = json['transaction_no'];
    planTitle = json['plan_title'];
    depositAmount = json['deposit_amount'];
    perInstallment = json['per_installment'];
    maturedAmount = json['matured_amount'];
    totalInstallment = json['total_installment'];
    givenInstallment = json['given_installment'];
    nextInstallment = json['next_installment'];
    status = json['status'];
    logs = json['logs'];
  }
  num? id;
  String? transactionNo;
  String? planTitle;
  String? depositAmount;
  String? perInstallment;
  String? maturedAmount;
  String? totalInstallment;
  String? givenInstallment;
  String? nextInstallment;
  String? status;
  String? logs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['transaction_no'] = transactionNo;
    map['plan_title'] = planTitle;
    map['deposit_amount'] = depositAmount;
    map['per_installment'] = perInstallment;
    map['matured_amount'] = maturedAmount;
    map['total_installment'] = totalInstallment;
    map['given_installment'] = givenInstallment;
    map['next_installment'] = nextInstallment;
    map['status'] = status;
    map['logs'] = logs;
    return map;
  }

}