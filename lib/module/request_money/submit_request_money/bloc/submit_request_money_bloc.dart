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
import 'submit_request_money_event.dart';
import 'submit_request_money_state.dart';

class SubmitRequestMoneyBloc extends Bloc<SubmitRequestMoneyEvent, SubmitRequestMoneyState> {
  DeBouncer debouncer = DeBouncer();
  TransferRepository repository = TransferRepository();
  RequestMoneyRepository requestMoneyRepository = RequestMoneyRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController accountNo = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController details = TextEditingController();
  String searchKey='';

  TabController? tabController;

  SubmitRequestMoneyBloc() : super(SubmitRequestMoneyState().init()) {
    on<InitEvent>(_init);
    on<SubmitTransfer>(_submitTransfer);
    on<SearchAccount>(_searchAccount);
  }

  @override
  Future<void> close() {
    repository.close();
    requestMoneyRepository.close();
    tabController?.dispose();
    return super.close();
  }

  void _init(InitEvent event, Emitter<SubmitRequestMoneyState> emit) async {
    emit(state.clone());
    tabController = TabController(vsync: event.page, length: 2);
    accountNo.addListener(() {
      try {
        if(searchKey!=accountNo.text) {
          debouncer.run(() {
            add(SearchAccount());
          });
          accountName.clear();
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }

  FutureOr<void> _submitTransfer(SubmitTransfer event, Emitter<SubmitRequestMoneyState> emit) async {
    if(!formKey.currentState!.validate()) return;
      Map<String,String> body = {
        AppConstant.account_number: accountNo.text,
        AppConstant.name: accountName.text,
        AppConstant.amount: amount.text,
        AppConstant.details: details.text,
      };
      emit(state.clone(loading: true));
      await requestMoneyRepository.submitRequestMoney(
        body: body,
        onSuccess: (data){
          backPage(true);
          SuccessMessage(message: appLanguage().request_money_send_successfully);
        },
        onError: (data){}
      );
      emit(state.clone(loading: false));
  }

  FutureOr<void> _searchAccount(SearchAccount event, Emitter<SubmitRequestMoneyState> emit) async {
    if(accountNo.text.isEmpty) return;
    searchKey = accountNo.text;
    await repository.searchAccount(
      key: accountNo.text,
      onSuccess: (data){
        if(data['data'].toString() != '[]'){
          accountName.text = data['data'];
        }
      },
      onError: (data){}
    );
  }
}
