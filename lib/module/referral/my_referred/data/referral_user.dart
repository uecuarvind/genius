class ReferralUser {
  ReferralUser({
      this.status, 
      this.data, 
      this.error,});

  ReferralUser.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ReferralData.fromJson(v));
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
  List<ReferralData>? data;
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

class ReferralData {
  ReferralData({
      this.id, 
      this.name, 
      this.joinedAt,});

  ReferralData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    joinedAt = json['joined_at'];
  }
  num? id;
  String? name;
  String? joinedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['joined_at'] = joinedAt;
    return map;
  }

}