class Methods {
  Methods({
      this.status, 
      this.data, 
      this.error,});

  Methods.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MethodData.fromJson(v));
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
  List<MethodData>? data;
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

class MethodData {
  MethodData({
      this.id, 
      this.method, 
      this.fixed, 
      this.percentage, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  MethodData.fromJson(dynamic json) {
    id = json['id'];
    method = json['method'];
    fixed = json['fixed'];
    percentage = json['percentage'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? method;
  String? fixed;
  String? percentage;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['method'] = method;
    map['fixed'] = fixed;
    map['percentage'] = percentage;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}