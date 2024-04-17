import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:genius_bank/repositories/wire_transfer_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../Widgets/show_message.dart';
import '../../../../app_helper/enums.dart';
import '../../../../main.dart';
import 'add_wire_transfer_event.dart';
import 'add_wire_transfer_state.dart';

class AddWireTransferBloc extends Bloc<AddWireTransferEvent, AddWireTransferState> {
  WireTransferRepository repository = WireTransferRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController swiftCode = TextEditingController();
  TextEditingController currency = TextEditingController();
  TextEditingController routingNumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController note = TextEditingController();

  AddWireTransferBloc() : super(AddWireTransferState().init()) {
    on<InitEvent>(_init);
    on<GetAvailableBank>(_getAvailableBank);
    on<SelectBank>(_selectBank);
    on<SubmitTransfer>(_submitTransfer);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AddWireTransferState> emit) async {
    emit(state.clone());
    add(GetAvailableBank());
  }

  FutureOr<void> _getAvailableBank(GetAvailableBank event, Emitter<AddWireTransferState> emit) async {
    await repository.getAvailableBank(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,availableBank: data));
      },
      onError:(data){}
    );
  }

  FutureOr<void> _selectBank(SelectBank event, Emitter<AddWireTransferState> emit) {
    emit(state.clone(selectBank: event.bank));
    swiftCode.text = event.bank.swiftCode ?? '';
    currency.text = event.bank.currency ?? '';
    routingNumber.text = event.bank.routingNumber ?? '';
    country.text = event.bank.country ?? '';
  }

  FutureOr<void> _submitTransfer(SubmitTransfer event, Emitter<AddWireTransferState> emit) async {
    if(!formKey.currentState!.validate()) return;
      Map<String,String> body = {
        AppConstant.wire_transfer_bank_id: state.selectBank!.id!.toString(),
        AppConstant.swift_code: state.selectBank?.swiftCode ?? '',
        AppConstant.currency: state.selectBank?.currency ?? '',
        AppConstant.routing_number: state.selectBank?.routingNumber ?? '',
        AppConstant.country: state.selectBank?.country ?? '',
        AppConstant.account_number: accountNumber.text,
        AppConstant.account_holder_name: accountName.text,
        AppConstant.amount: amount.text,
        AppConstant.note: note.text,
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
