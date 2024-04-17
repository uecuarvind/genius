import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/extensions.dart';
import 'package:genius_bank/controllers/share_helper.dart';
import 'package:genius_bank/data/auth.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/loan_repository.dart';
import 'package:genius_bank/repositories/user_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import 'kyc_verification_event.dart';
import 'kyc_verification_state.dart';

class KycVerificationBloc extends Bloc<KycVerificationEvent, KycVerificationState> {
  UserRepository repository = UserRepository();
  GlobalKey<FormState> formKey = GlobalKey();

  KycVerificationBloc() : super(KycVerificationState().init()) {
    on<InitEvent>(_init);
    on<AddFile>(_addFile);
    on<SubmitLoanRequest>(_submitRequest);
    on<GetForm>(_getForm);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<KycVerificationState> emit) async {
    emit(state.clone());
    add(GetForm());
  }

  FutureOr<void> _addFile(AddFile event, Emitter<KycVerificationState> emit) {
    state.formData!.data![event.index].data = event.image;
    emit(state.clone(formData: state.formData));
  }

  FutureOr<void> _submitRequest(SubmitLoanRequest event, Emitter<KycVerificationState> emit) async {
    if(!formKey.currentState!.validate()) return;

    emit(state.clone(loading: true));
    Map<String,String> body ={};
    List<File> files = [];
    List<String> fileKeys = [];
    if(state.formData!=null && state.formData!.data!.isNotEmpty){
      for (var element in state.formData!.data!) {
        if(element.isTextField!){
          body[element.name!]=element.controller!.text;
        } else {
          fileKeys.add(element.name!);
          files.add(element.data!);
        }
      }
    } else {
      return;
    }
    await repository.submitKyc(
        body: body,
        files: files,
        fileKeys: fileKeys,
        onSuccess: (data){
          Auth auth = Auth.getAuth()!;
          auth.data!.user!.kycStatus = '1';
          ShareHelper.setAuth(auth);
          backPage();
          SuccessMessage(message: appLanguage().kyc_submitted_successfully);
        },
        onError: (Map<String,dynamic> data){}
    );
    emit(state.clone(loading: false));
  }

  FutureOr<void> _getForm(GetForm event, Emitter<KycVerificationState> emit) async {
    await repository.getKycForm(
        onSuccess: (data){
          emit(state.clone(formData: data));
        },
        onError: (Map<String,dynamic> data){}
    );
  }
}
