import 'dart:convert';

import 'package:genius_bank/config/dependency.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/auth.dart';
import '../theme/app_color.dart';

class ShareHelper{
  static SharedPreferences? preferences;
  static Future init() async{
    await SharedPreferences.getInstance().then((pr) {
      preferences = pr;
      getAuth();
      if(getTheme() != 'light'){
        AppColor.applyDark();
      }
    });
  }


  static String getLanguage() {
    return preferences!.getString(AppConstant.Share_Language) ?? 'en';
  }

  static void setLanguage(String key) {
    preferences!.setString(AppConstant.Share_Language,key);
  }

  static String getTheme() {
    return preferences!.getString(AppConstant.Share_Theme) ?? 'light';
  }

  static void setTheme(String key) {
    preferences!.setString(AppConstant.Share_Theme,key);
  }

  static void setAuth(Auth auth) {
    instance.registerSingleton<Auth>(auth);
    preferences!.setString(AppConstant.Share_Auth, jsonEncode(auth.toJson()));
  }

  static Auth? getAuth() {
    //preferences!.remove(AppConstant.Share_Auth);
    if(!preferences!.containsKey(AppConstant.Share_Auth)) return null;

    Auth auth = Auth.fromJson(jsonDecode(preferences!.getString(AppConstant.Share_Auth)!));
    instance.registerSingleton<Auth>(auth);
    return auth;
  }





  ShareHelper.logOut({bool forceLogout = true}){
    try{
      instance.unregister<Auth>();
    }catch(e){}
    preferences!.remove(AppConstant.Share_Auth);
    if(forceLogout){
      goAndRemoveAllPages(Routes.SIGN_IN);
    }
  }

}
