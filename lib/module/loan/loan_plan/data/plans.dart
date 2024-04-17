class Plans {
  Plans({
      this.status, 
      this.data, 
      this.error,});

  Plans.fromJson(dynamic json) {
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
      this.perInstallment, 
      this.minAmount, 
      this.maxAmount, 
      this.installmentInterval, 
      this.totalInstallment,});

  PlanData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    perInstallment = json['per_installment'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    installmentInterval = json['installment_interval'];
    totalInstallment = json['total_installment'];
  }
  num? id;
  String? title;
  String? perInstallment;
  String? minAmount;
  String? maxAmount;
  String? installmentInterval;
  String? totalInstallment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['per_installment'] = perInstallment;
    map['min_amount'] = minAmount;
    map['max_amount'] = maxAmount;
    map['installment_interval'] = installmentInterval;
    map['total_installment'] = totalInstallment;
    return map;
  }

}