import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:genius_bank/repositories/transfer_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../Widgets/show_message.dart';
import '../../../../app_helper/debouncer.dart';
import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import 'send_money_event.dart';
import 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  DeBouncer debouncer = DeBouncer();
  TransferRepository repository = TransferRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController accountNo = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController amount = TextEditingController();
  String searchKey='';

  TabController? tabController;

  SendMoneyBloc() : super(SendMoneyState().init()) {
    on<InitEvent>(_init);
    on<GetAvailableBank>(_getAvailableBank);
    on<SelectMethod>(_selectBank);
    on<SubmitTransfer>(_submitTransfer);
    on<SearchAccount>(_searchAccount);
  }

  @override
  Future<void> close() {
    repository.close();
    tabController?.dispose();
    return super.close();
  }

  void _init(InitEvent event, Emitter<SendMoneyState> emit) async {
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
    add(GetAvailableBank());
  }

  FutureOr<void> _getAvailableBank(GetAvailableBank event, Emitter<SendMoneyState> emit) async {
    await repository.getSavedBankList(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,bankList: data));
      },
      onError:(data){}
    );
  }

  FutureOr<void> _selectBank(SelectMethod event, Emitter<SendMoneyState> emit) {
    emit(state.clone(selectedBank: event.account));
    accountName.text = event.account.name ?? '';
    accountNo.text = event.account.accNo ?? '';
    tabController?.animateTo(0,duration: const Duration(milliseconds: 500));
  }

  FutureOr<void> _submitTransfer(SubmitTransfer event, Emitter<SendMoneyState> emit) async {
    if(!formKey.currentState!.validate()) return;
      Map<String,String> body = {
        AppConstant.account_number: accountNo.text,
        AppConstant.account_name: accountName.text,
        AppConstant.amount: amount.text,
      };
      emit(state.clone(loading: true));
      await repository.sendMoney(
        body: body,
        onSuccess: (data){
          backPage();
          SuccessMessage(message: appLanguage().successfully_transferred);
        },
        onError: (data){}
      );
      emit(state.clone(loading: false));
  }

  FutureOr<void> _searchAccount(SearchAccount event, Emitter<SendMoneyState> emit) async {
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
