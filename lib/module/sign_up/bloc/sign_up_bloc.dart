import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/auth_repository.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/utils/app_constant.dart';
import 'package:phone_form_field/phone_form_field.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepository repository = AuthRepository();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  PhoneController phoneController = PhoneController(AppConstant.defaultPhoneNumber);



  SignUpBloc() : super(SignUpState().init()) {
    on<InitEvent>(_init);
    on<RememberMe>(_changeRemember);
    on<SubmitData>(_submitData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<SignUpState> emit) async {
    emit(state.clone());
  }

  Future _changeRemember(RememberMe event, Emitter<SignUpState> emit) async {
    emit(state.clone(rememberMe: event.value));
  }

  Future _submitData(SubmitData event, Emitter<SignUpState> emit) async {
    if(!formKey.currentState!.validate()) {
      return;
    } else if(!phoneController.value!.isValid()) {
      ErrorMessage(message: appLanguage().please_enter_valid_phone_number);
      return;
    }
    emit(state.clone(state: PageState.Loading));
    await repository.postSignUp(
      body: <String,dynamic>{
        AppConstant.name: name.text,
        AppConstant.email: email.text,
        AppConstant.phone: phoneController.value!.international,
        AppConstant.password: password.text,
        AppConstant.bank_plan_id: "1",
      },
      onSuccess: (data) {
        goAndRemoveAllPages(Routes.MAIN_PAGE);
      },
      onError: (data) {
      },
    );
    emit(state.clone(state: PageState.Success));
  }
}
