import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:genius_bank/repositories/withdraw_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../Widgets/show_message.dart';
import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import 'add_withdraw_event.dart';
import 'add_withdraw_state.dart';

class AddWithdrawBloc extends Bloc<AddWithdrawEvent, AddWithdrawState> {
  WithdrawRepository repository = WithdrawRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();

  AddWithdrawBloc() : super(AddWithdrawState().init()) {
    on<InitEvent>(_init);
    on<GetAvailableBank>(_getAvailableBank);
    on<SelectMethod>(_selectBank);
    on<SubmitTransfer>(_submitTransfer);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AddWithdrawState> emit) async {
    emit(state.clone());
    add(GetAvailableBank());
  }

  FutureOr<void> _getAvailableBank(GetAvailableBank event, Emitter<AddWithdrawState> emit) async {
    await repository.getMethods(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,methods: data));
      },
      onError:(data){}
    );
  }

  FutureOr<void> _selectBank(SelectMethod event, Emitter<AddWithdrawState> emit) {
    emit(state.clone(method: event.method));
  }

  FutureOr<void> _submitTransfer(SubmitTransfer event, Emitter<AddWithdrawState> emit) async {
    if(!formKey.currentState!.validate()) return;
      Map<String,String> body = {
        AppConstant.currency_id: state.method!.id!.toString(),
        AppConstant.method: state.method?.method ?? '',
        AppConstant.amount: amount.text,
        AppConstant.details: description.text,
      };
      emit(state.clone(loading: true));
      await repository.submitTransfer(
        body: body,
        onSuccess: (data){
          backPage();
          SuccessMessage(message: appLanguage().successfully_transferred);
        },
        onError: (data){}
      );
      emit(state.clone(loading: false));
  }
}
