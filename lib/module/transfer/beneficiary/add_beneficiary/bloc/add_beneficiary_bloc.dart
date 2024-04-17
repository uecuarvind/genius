import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../Widgets/show_message.dart';
import '../../../../../app_helper/enums.dart';
import '../../../../../main.dart';
import '../../../../../repositories/beneficiary_repository.dart';
import '../../../../../utils/app_constant.dart';
import 'add_beneficiary_event.dart';
import 'add_beneficiary_state.dart';

class AddBeneficiaryBloc extends Bloc<AddBeneficiaryEvent, AddBeneficiaryState> {
  BeneficiaryRepository repository = BeneficiaryRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nickName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController accountName = TextEditingController();

  AddBeneficiaryBloc() : super(AddBeneficiaryState().init()) {
    on<InitEvent>(_init);
    on<GetAvailableBank>(_getAvailableBank);
    on<SelectBank>(_selectBank);
    on<SubmitTransfer>(_submitTransfer);
    on<AddFile>(_addFile);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AddBeneficiaryState> emit) async {
    emit(state.clone());
    add(GetAvailableBank());
  }

  FutureOr<void> _getAvailableBank(GetAvailableBank event, Emitter<AddBeneficiaryState> emit) async {
    await repository.getOthersBank(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,availableBank: data));
      },
      onError:(data){}
    );
  }

  FutureOr<void> _selectBank(SelectBank event, Emitter<AddBeneficiaryState> emit) {
    emit(state.clone(selectBank: event.bank));
  }

  FutureOr<void> _addFile(AddFile event, Emitter<AddBeneficiaryState> emit) {
    state.selectBank!.dynamicFields![event.index].data = event.image;
    emit(state.clone(selectBank: state.selectBank!));
  }

  FutureOr<void> _submitTransfer(SubmitTransfer event, Emitter<AddBeneficiaryState> emit) async {
    if(!formKey.currentState!.validate()) return;
    emit(state.clone(loading: true));
    Map<String,String> body ={
      AppConstant.other_bank_id: state.selectBank!.id!.toString(),
      AppConstant.account_number: accountNumber.text,
      AppConstant.account_name: accountName.text,
      AppConstant.nick_name: nickName.text,
    };
    List<File> files = [];
    List<String> fileKeys = [];
    if(state.selectBank!.dynamicFields!=null && state.selectBank!.dynamicFields!.isNotEmpty){
      for (var element in state.selectBank!.dynamicFields!) {
        if(element.type!.toLowerCase() != 'file'){
          body[element.fieldName!]=element.controller!.text;
        } else {
          fileKeys.add(element.fieldName!);
          files.add(element.data!);
        }
      }
    }
    await repository.submitRequest(
        body: body,
        files: files,
        fileKeys: fileKeys,
        onSuccess: (data){
          backPage();
          SuccessMessage(message: appLanguage().beneficiary_added_successfully);
        },
        onError: (Map<String,dynamic> data){}
    );
    emit(state.clone(loading: false));
  }
}
