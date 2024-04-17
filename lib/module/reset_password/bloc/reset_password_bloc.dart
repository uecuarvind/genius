import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/Widgets/message_dialog.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/auth_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import 'reset_password_event.dart';
import 'reset_password_state.dart';
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  AuthRepository authRepository = AuthRepository();

  ResetPasswordBloc() : super(ResetPasswordState().init()) {
    on<InitEvent>(_init);
    on<ResetEvent>(_rest);
    on<ResetSubmitEvent>(_restSubmit);
  }

  void _init(InitEvent event, Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith());
  }

  Future<void> _rest(ResetEvent event, Emitter<ResetPasswordState> emit) async {
    if (!formKey.currentState!.validate() || state.pageState==PageState.Loading) {
      return;
    }
    emit(state.copyWith(pageState: PageState.Loading));
    await authRepository.postRestPassword(
      body: <String,dynamic>{
        AppConstant.email: emailController.text,
      },
      onSuccess: (data) {
        emit(state.copyWith(resetPassword: data));
        MessageDialog(title: appLanguage().reset_password, message: appLanguage().reset_password_send_msg.replaceAll('@',emailController.text));
      },
      onError: (data) {
      },
    );
    emit(state.copyWith(pageState: PageState.Success));
  }

  Future<void> _restSubmit(ResetSubmitEvent event, Emitter<ResetPasswordState> emit) async {
    if (!formKey.currentState!.validate() || state.pageState==PageState.Loading) {
      return;
    }
    if(state.resetPassword!.data!.resetToken != code.text){
      ErrorMessage(message: appLanguage().reset_code_does_not_match);
      return;
    }
    emit(state.copyWith(pageState: PageState.Loading));
    await authRepository.restPasswordSubmit(
      body: <String,dynamic>{
        AppConstant.new_password: password.text,
        AppConstant.confirm_password: conPassword.text,
        AppConstant.reset_token: code.text,
        AppConstant.user_id: state.resetPassword!.data!.userId!.toString(),
      },
      onSuccess: (data) {
        backPage();
        SuccessMessage(message: data[AppConstant.data][AppConstant.message]);
      },
      onError: (data) {
      },
    );
    emit(state.copyWith(pageState: PageState.Success));
  }

  @override
  Future<void> close() {
    authRepository.close();
    return super.close();
  }

  Future<bool> back() {
    if(state.resetPassword!=null){
      emit(state.init());
    } else {
      backPage();
    }
    return Future.value(false);
  }
}
