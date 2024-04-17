import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/Widgets/default_dialog.dart';
import 'package:genius_bank/controllers/connnectivity_helper.dart';
import 'package:genius_bank/data/auth.dart';
import 'package:genius_bank/data/currencies.dart';
import 'package:genius_bank/repositories/auth_repository.dart';
import 'package:genius_bank/repositories/splash_repository.dart';
import 'package:genius_bank/repositories/user_repository.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/theme/app_color.dart';

import '../../main.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashRepository repository = SplashRepository();
  AuthRepository authRepository = AuthRepository();
  UserRepository userRepository = UserRepository();
  int dataLoaded = 0,needData = 1;

  SplashBloc() : super(SplashState()){
    on<InitSplashEvent>(init);
  }

  Future<void> init(InitSplashEvent event, Emitter<SplashState> emit,) async {
    state.init();
    ConnectivityHelper.listen(listen: (bool result) async {
      if(result){
        getAppCurrencies();
      }
    });
  }

  @override
  Future<void> close() {
    userRepository.close();
    authRepository.close();
    repository.close();
    ConnectivityHelper.closeListen();
    return super.close();
  }

  Future getRefreshToken(Auth auth) async {
    await authRepository.getRefreshToken(
      auth:auth,
      onSuccess: (data){
        try{
          Auth auth = data;
          if(auth.data!.token != null && auth.data!.token!.isEmpty) {
            dataLoaded ++;
            needData ++;
            goNext();
            getAuthUser();
          } else {
            emit(state.clone(auth: null));
            dataLoaded ++;
            goNext();
          }
        } catch(e){
          dataLoaded ++;
          goNext();
        }
      },
      onError: (Map<String,dynamic> data){
        dataLoaded ++;
        goNext();
      }
    );
  }

  Future getAuthUser() async {
    await userRepository.getUser(
      enableShowError: false,
      forceLogout: false,
      onSuccess: (Auth auth){
        dataLoaded ++;
        emit(state.clone(auth: auth));
        goNext();
      },
      onError: (Map<String,dynamic> data){
        dataLoaded ++;
        needData ++;
        getRefreshToken(Auth.fromJson(data));
        goNext();
      }
    );
  }


  Future getAppCurrencies() async {
    /*
    await repository.getAppCurrencies(
        onSuccess: (Currencies settings){
          dataLoaded ++;
          if(Auth.getAuth()!=null){
            needData ++;
            getAuthUser();
          } else {
            goNext();
          }
        },
        onError: (Map<String,dynamic> data){
        }
    );
    */
    dataLoaded ++;
    if(Auth.getAuth()!=null){
      print("login");
      needData ++;
      getAuthUser();
    } else {
      print("not login");
      goNext();
    }
  }


  void goNext(){
    if(dataLoaded>=needData) {
      if(state.auth!=null) {
        print("MAIN pAGE");
        goAndRemoveAllPages(Routes.MAIN_PAGE);
      } else {
        print("Sigin page");
        goAndRemoveAllPages(Routes.SIGN_IN);
      }
    }
  }

  void showMaintainMessage(){
    showDialog<void>(
      context: appContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        return DefaultDialog(
          title: appLanguage().warning,
          barrierDismissible: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //HtmlWidget(appSettings?.data?.maintainText ?? ""),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: (){
                    backPage();
                    if(Platform.isAndroid){
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  },
                  child: Text(appLanguage().ok,style: appTheme().textTheme.headlineLarge!.copyWith(color: AppColor.primary),)
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
