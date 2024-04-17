
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/data/auth.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/user_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';
import 'package:phone_form_field/phone_form_field.dart';

import 'my_profile_event.dart';
import 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  UserRepository repository = UserRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fax = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController address = TextEditingController();

  PhoneController phoneController = PhoneController(AppConstant.defaultPhoneNumber);

  MyProfileBloc() : super(MyProfileState().init()) {
    on<InitEvent>(_init);
    on<SubmitEvent>(_submitData);
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<MyProfileState> emit) async {
    name.text = state.auth!.data!.user!.fullName ?? '';
    email.text = state.auth!.data!.user!.email ?? '';
    fax.text = state.auth!.data!.user!.fax ?? '';
    zipCode.text = state.auth!.data!.user!.zipCode ?? '';
    city.text = state.auth!.data!.user!.city ?? '';
    country.text = state.auth!.data!.user!.country ?? '';
    address.text = state.auth!.data!.user!.address ?? '';
    try {
      phoneController.value = PhoneNumber.parse(state.auth!.data!.user!.phone ?? '');
    } catch(e){}
    emit(state.clone());
  }

  Future _submitData(SubmitEvent event, Emitter<MyProfileState> emit) async {
    if(!formKey.currentState!.validate()) {
      return;
    } else if(!phoneController.value!.isValid()) {
      ErrorMessage(message: appLanguage().please_enter_valid_phone_number);
      return;
    }
    Map<String,String> body = {
      AppConstant.name: name.text,
      AppConstant.email: email.text,
      AppConstant.phone: phoneController.value!.international,
      AppConstant.fax: fax.text,
      AppConstant.zip: zipCode.text,
      AppConstant.city: city.text,
      AppConstant.country: country.text,
      AppConstant.address: address.text,
    };

    emit(state.clone(pageState: PageState.Loading));
    await repository.updateProfile(
      body: body,
      onSuccess: (Auth data){
        emit(state.clone(pageState: PageState.Success,auth: data));
        backPage();
        SuccessMessage(message: appLanguage().profile_updated_successfully);
      },
      onError: (data){
        emit(state.clone(pageState: PageState.Error));
      }
    );

  }
}
