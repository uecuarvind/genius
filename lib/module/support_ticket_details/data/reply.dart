class Reply {
  Reply({
      this.status, 
      this.data, 
      this.error,});

  Reply.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ReplyData.fromJson(v));
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
  List<ReplyData>? data;
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

class ReplyData {
  ReplyData({
      this.id, 
      this.message, 
      this.userId,
      this.userAdmin,
      this.name, 
      this.photo,
      this.createdAt,
  });

  ReplyData.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    userId = json['user_id'];
    userAdmin = json['user_admin'];
    name = json['name'];
    photo = json['photo'];
    createdAt = json['created_at'];
  }
  num? id;
  String? message;
  String? userId;
  String? userAdmin;
  String? name;
  String? photo;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['user_admin'] = userAdmin;
    map['name'] = name;
    map['photo'] = photo;
    return map;
  }

}