import 'package:flutter/material.dart';
import 'package:genius_bank/controllers/share_helper.dart';

import '../../../theme/app_color.dart';

class AppControllerState {
  Locale locale = const Locale('en');
  ThemeMode themeMode = ThemeMode.light;

  AppControllerState({this.locale=const Locale('en')});

  Iterable<Locale> supportedLocales = [const Locale('en'), const Locale('bn')];

  Locale? localeResolutionCallBack(List<Locale>? locales, Iterable<Locale> supportedLocale) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locales?.first.languageCode &&
          supportedLocale.countryCode == locales?.first.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocale.first;
  }

  Future<AppControllerState> inti() async{
    locale = Locale(ShareHelper.getLanguage());
    themeMode = ShareHelper.getTheme() == 'light' ? ThemeMode.light : ThemeMode.dark;
    return this;
  }

  AppControllerState copyWith({Locale? locale,bool changeTheme = false}) {
    if(locale!=null){
      ShareHelper.setLanguage(locale.languageCode);
    }
    if(changeTheme){
      String themeName = ShareHelper.getTheme();
      themeMode = themeName == 'light' ? ThemeMode.dark : ThemeMode.light;
      ShareHelper.setTheme(themeName == 'light' ? 'dark' : 'light');
      if(themeMode == ThemeMode.dark){
        AppColor.applyDark();
      } else {
        AppColor.applyLight();
      }
    }
    return AppControllerState(
        locale: locale ?? this.locale
    );
  }
}
