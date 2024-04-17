
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/repositories/support_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../Widgets/show_message.dart';
import '../../main.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  SupportRepository repository = SupportRepository();

  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  FocusNode phoneFocusNode=FocusNode();
  TextEditingController email=TextEditingController();
  TextEditingController subject=TextEditingController();
  TextEditingController message=TextEditingController();
  GlobalKey<FormState>fromKey=GlobalKey();

  ContactUsBloc() : super(ContactUsState().init()) {
    on<InitEvent>(_init);
    on<GetInfo>(_getInfo);
    on<SubmitMessageEvent>(_submitMessage);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ContactUsState> emit) async {
    if(state.auth!=null){
      name.text=state.auth!.data!.user!.fullName ?? '';
      email.text=state.auth!.data!.user!.email ?? '';
      phone.text=state.auth!.data!.user!.phone ?? '';
    }
    emit(state.clone());
    add(GetInfo());
  }

  FutureOr<void> _submitMessage(SubmitMessageEvent event, Emitter<ContactUsState> emit) async {
    if(!fromKey.currentState!.validate()) return;
    emit(state.clone(pageState: PageState.Loading));

    Map<String,String> body={
      AppConstant.name:name.text,
      AppConstant.email:email.text,
      AppConstant.phone:phone.text,
      AppConstant.subject:subject.text,
      AppConstant.message:message.text,
    };

    await repository.contactUs(
      body: body,
      onSuccess: (data){
        if(state.auth!.data!.user==null){
          name.text='';
          email.text='';
          phone.text='';
        }
        subject.text='';
        message.text='';
        emit(state.clone(pageState: PageState.Success));
        backPage();
        SuccessMessage(message: data[AppConstant.data][AppConstant.message]);
      },
      onError: (Map<String,dynamic> data){
        emit(state.clone(pageState: PageState.Error));
      }
    );
  }

  FutureOr<void> _getInfo(GetInfo event, Emitter<ContactUsState> emit) async {
    await repository.getContactInfo(
      onSuccess: (data){
        emit(state.clone(contactInfo: data));
      },
      onError: (Map<String,dynamic> data){
        emit(state.clone(pageState: PageState.Error));
      }
    );
  }
}
