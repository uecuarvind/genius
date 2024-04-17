import 'reply.dart';

class NewMessage {
  NewMessage({
      this.status, 
      this.data, 
      this.error,});

  NewMessage.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? ReplyData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  ReplyData? data;
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
