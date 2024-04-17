import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/auth_repository.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../Widgets/default_dialog.dart';
import '../../../config/dependency.dart';
import '../../../controllers/share_helper.dart';
import '../../../data/auth.dart';
import '../view/code_verify.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  var arguments;
  AuthRepository repository = AuthRepository();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();



  SignInBloc() : super(SignInState().init()) {
    on<InitEvent>(_init);
    on<RememberMe>(_changeRemember);
    on<SubmitData>(_submitData);
    on<TwoFaVerification>(_twoFaVerification);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<SignInState> emit) async {
    if (kDebugMode) {
      email.text = 'user@gmail.com';
      password.text = '1234';
    }
    arguments = settings(event.context).arguments;

    emit(state.clone());
  }

  Future _changeRemember(RememberMe event, Emitter<SignInState> emit) async {
    emit(state.clone(rememberMe: event.value));
  }

  Future _submitData(SubmitData event, Emitter<SignInState> emit) async {
    if(!formKey.currentState!.validate()) return;
    emit(state.clone(state: PageState.Loading));
    await repository.postSignIn(
      body: <String,dynamic>{
        AppConstant.email: email.text,
        AppConstant.password: password.text,
      },
      onSuccess: (data) {
        instance.registerSingleton<Auth>(data);
        emit(state.clone(auth: data));
        print("step1........");
        if(data.data!.user!.twofa == "1"){
          print("twofa==1");
          verifyDialog();
        } else {
          print("twofa==0");
          ShareHelper.setAuth(data);
          goAndRemoveAllPages(Routes.MAIN_PAGE);
        }
      },
      onError: (data) {
      },
    );
    emit(state.clone(state: PageState.Success));
  }


  FutureOr<void> _twoFaVerification(TwoFaVerification event, Emitter<SignInState> emit) async {
    emit(state.clone(verificationLoading: true));
    await repository.twoFaOtpVerification(
        body: {
          AppConstant.otp: event.code,
        },
        onSuccess: (data){
          ShareHelper.setAuth(state.auth!);
          backPage();
          goAndRemoveAllPages(Routes.MAIN_PAGE);
        },
        onError: (data){}
    );
    emit(state.clone(verificationLoading: false));
  }

  void verifyDialog(){
    showDialog(
        context: appContext,
        builder: (ctx){
          return DefaultDialog(
            title: appLanguage().verify_your_otp,
            child: CodeVerify(this),
          );
        }
    );
  }
}
