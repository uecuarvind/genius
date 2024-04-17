class Loans {
  Loans({
      this.status, 
      this.data, 
      this.error,});

  Loans.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LoanData.fromJson(v));
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
  List<LoanData>? data;
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

class LoanData {
  LoanData({
      this.id, 
      this.transactionNo, 
      this.planTitle, 
      this.loanAmount, 
      this.perInstallmentAmount, 
      this.totalInstallment, 
      this.givenInstallment, 
      this.nextInstallment, 
      this.status, 
      this.logs,});

  LoanData.fromJson(dynamic json) {
    id = json['id'];
    transactionNo = json['transaction_no'];
    planTitle = json['plan_title'];
    loanAmount = json['loan_amount'];
    perInstallmentAmount = json['per_installment_amount'];
    totalInstallment = json['total_installment'];
    givenInstallment = json['given_installment'];
    nextInstallment = json['next_installment'];
    status = json['status'];
    logs = json['logs'];
  }
  num? id;
  dynamic transactionNo;
  String? planTitle;
  String? loanAmount;
  String? perInstallmentAmount;
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
    map['loan_amount'] = loanAmount;
    map['per_installment_amount'] = perInstallmentAmount;
    map['total_installment'] = totalInstallment;
    map['given_installment'] = givenInstallment;
    map['next_installment'] = nextInstallment;
    map['status'] = status;
    map['logs'] = logs;
    return map;
  }

}