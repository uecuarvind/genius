import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/extensions.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/loan_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import 'apply_loan_event.dart';
import 'apply_loan_state.dart';

class ApplyLoanBloc extends Bloc<ApplyLoanEvent, ApplyLoanState> {
  LoanRepository repository = LoanRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic>? arguments;

  ApplyLoanBloc() : super(ApplyLoanState().init()) {
    on<InitEvent>(_init);
    on<AddFile>(_addFile);
    on<SubmitLoanRequest>(_submitRequest);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ApplyLoanState> emit) async {
    arguments = settings(event.context).arguments as Map<String, dynamic>;
    emit(state.clone(
      planData: arguments![AppConstant.plan_data],
      loanData: arguments![AppConstant.data]
    ));
  }

  FutureOr<void> _addFile(AddFile event, Emitter<ApplyLoanState> emit) {
    state.loanData!.data!.dynamicFields!.fields![event.index].data = event.image;
    emit(state.clone(loanData: state.loanData!));
  }

  FutureOr<void> _submitRequest(SubmitLoanRequest event, Emitter<ApplyLoanState> emit) async {
    if(!formKey.currentState!.validate()) return;

    emit(state.clone(loading: true));
    Map<String,String> body ={
      AppConstant.plan_id: state.loanData!.data!.planId!.toString(),
      AppConstant.total_installment: state.loanData!.data!.totalInstallment!,
      AppConstant.loan_amount: state.loanData!.data!.loanAmount!.numeric,
      AppConstant.per_installment_amount: state.loanData!.data!.perInstallment!.toString().numeric,
      AppConstant.total_amount: state.loanData!.data!.totalAmountPay!.toString().numeric,
    };
    List<File> files = [];
    List<String> fileKeys = [];
    if(state.loanData!.data!.dynamicFields!=null && state.loanData!.data!.dynamicFields!.fields!.isNotEmpty){
      for (var element in state.loanData!.data!.dynamicFields!.fields!) {
        if(element.isTextField!){
          body[element.key!]=element.controller!.text;
        } else {
          fileKeys.add(element.key!);
          files.add(element.data!);
        }
      }
    }
    await repository.submitLoanRequest(
        body: body,
        files: files,
        fileKeys: fileKeys,
        onSuccess: (data){
          backPage();
          SuccessMessage(message: appLanguage().loan_request_sent_successfully);
        },
        onError: (Map<String,dynamic> data){}
    );
    emit(state.clone(loading: false));

  }
}
