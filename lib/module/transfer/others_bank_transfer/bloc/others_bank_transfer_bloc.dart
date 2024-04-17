import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:genius_bank/repositories/transfer_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../Widgets/show_message.dart';
import '../../../../app_helper/debouncer.dart';
import '../../../../main.dart';
import '../../../../repositories/request_money_repository.dart';
import '../../others_banks/data/others_bank.dart';
import 'others_bank_transfer_event.dart';
import 'others_bank_transfer_state.dart';

class OthersBankTransferBloc extends Bloc<OthersBankTransferEvent, OthersBankTransferState> {
  DeBouncer debouncer = DeBouncer();
  TransferRepository repository = TransferRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountNo = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController amount = TextEditingController();
  String searchKey='';

  OthersBankTransferBloc() : super(OthersBankTransferState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitTransfer);
    on<GetDetails>(_getDetails);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<OthersBankTransferState> emit) async {
    BankData data = settings(event.context).arguments as BankData;
    emit(state.clone(bankData: data));
    bankName.text = data.bankName ?? '';
    accountNo.text = data.accountNumber ?? '';
    accountName.text = data.accountName ?? '';
    add(GetDetails());
  }

  FutureOr<void> _submitTransfer(SubmitTransfer event, Emitter<OthersBankTransferState> emit) async {
    if(!formKey.currentState!.validate()) return;
      Map<String,String> body = {
        AppConstant.beneficiary_id: state.bankDetails!.data!.beneficiaryId!.toString(),
        AppConstant.other_bank_id: state.bankDetails!.data!.otherBankId!.toString(),
        AppConstant.bank_name: bankName.text,
        AppConstant.account_name: accountName.text,
        AppConstant.amount: amount.text,
      };
      emit(state.clone(loading: true));
      await repository.sendOthersBankTransfer(
        body: body,
        onSuccess: (data){
          backPage(true);
          SuccessMessage(message: appLanguage().successfully_transferred);
        },
        onError: (data){}
      );
      emit(state.clone(loading: false));
  }

  FutureOr<void> _getDetails(GetDetails event, Emitter<OthersBankTransferState> emit) async {
    if(accountNo.text.isEmpty) return;
    searchKey = accountNo.text;
    await repository.getBankDetails(
      id: state.bankData!.id!.toString(),
      onSuccess: (data){
        emit(state.clone(bankDetails: data));
      },
      onError: (data){}
    );
  }
}
