import 'package:genius_bank/config/dependency.dart';
import 'package:genius_bank/data/user.dart';
import 'package:genius_bank/main.dart';

class Auth {
  Auth({
      this.status, 
      this.data, 
      this.error,});

  Auth.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? AuthData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = [];
      try{
        json['error'].forEach((v) {
          error?.add(v);
        });
      } catch(e){
        error?.add(appLanguage().somethingWentWrong);
      }
    }
  }
  int? status;
  AuthData? data;
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

  static Auth? getAuth(){
    try{
      return instance.get<Auth>();
    } catch(e){
      return null;
    }
  }

}

class AuthData {
  AuthData({
      this.token, 
      this.user,});

  AuthData.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? token;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}