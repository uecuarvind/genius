class Tickets {
  Tickets({
      this.status, 
      this.data, 
      this.error,});

  Tickets.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TicketData.fromJson(v));
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
  List<TicketData>? data;
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

class TicketData {
  TicketData({
      this.id, 
      this.subject, 
      this.message, 
      this.time, 
      this.replyUrl, 
      this.deleteUrl,});

  TicketData.fromJson(dynamic json) {
    id = json['id'];
    subject = json['subject'];
    message = json['message'];
    time = json['time'];
    replyUrl = json['reply_url'];
    deleteUrl = json['delete_url'];
  }
  num? id;
  String? subject;
  String? message;
  String? time;
  String? replyUrl;
  String? deleteUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['subject'] = subject;
    map['message'] = message;
    map['time'] = time;
    map['reply_url'] = replyUrl;
    map['delete_url'] = deleteUrl;
    return map;
  }

}