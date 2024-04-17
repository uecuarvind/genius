class TwoFaData {
  TwoFaData({
      this.status, 
      this.data, 
      this.error,});

  TwoFaData.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? FAData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  FAData? data;
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

class FAData {
  FAData({
      this.secret, 
      this.qrCodeUrl, 
      this.qrPhoto,});

  FAData.fromJson(dynamic json) {
    secret = json['secret'];
    qrCodeUrl = json['qrCodeUrl'];
    qrPhoto = json['qrPhoto'];
  }
  String? secret;
  String? qrCodeUrl;
  String? qrPhoto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['secret'] = secret;
    map['qrCodeUrl'] = qrCodeUrl;
    map['qrPhoto'] = qrPhoto;
    return map;
  }

}