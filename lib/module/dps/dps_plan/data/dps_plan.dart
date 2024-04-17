class DpsPlan {
  DpsPlan({
      this.status, 
      this.data, 
      this.error,});

  DpsPlan.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PlanData.fromJson(v));
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
  List<PlanData>? data;
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

class PlanData {
  PlanData({
      this.id, 
      this.title, 
      this.interestRate, 
      this.perInstallment, 
      this.totalDeposit, 
      this.afterMatured, 
      this.installmentInterval, 
      this.totalInstallment, 
      this.applyUrl,});

  PlanData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    interestRate = json['interest_rate'];
    perInstallment = json['per_installment'];
    totalDeposit = json['total_deposit'];
    afterMatured = json['after_matured'].toString();
    installmentInterval = json['installment_interval'];
    totalInstallment = json['total_installment'];
    applyUrl = json['apply_url'];
  }
  num? id;
  String? title;
  String? interestRate;
  String? perInstallment;
  String? totalDeposit;
  String? afterMatured;
  String? installmentInterval;
  String? totalInstallment;
  String? applyUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['interest_rate'] = interestRate;
    map['per_installment'] = perInstallment;
    map['total_deposit'] = totalDeposit;
    map['after_matured'] = afterMatured;
    map['installment_interval'] = installmentInterval;
    map['total_installment'] = totalInstallment;
    map['apply_url'] = applyUrl;
    return map;
  }

}