import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/main.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/request_money_repository.dart';
import 'receive_request_money_event.dart';
import 'receive_request_money_state.dart';

class ReceiveRequestMoneyBloc extends Bloc<ReceiveRequestMoneyEvent, ReceiveRequestMoneyState> {
  RequestMoneyRepository repository = RequestMoneyRepository();

  ReceiveRequestMoneyBloc() : super(ReceiveRequestMoneyState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
    on<AcceptRequest>(_acceptRequest);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ReceiveRequestMoneyState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<ReceiveRequestMoneyState> emit) async {
    await repository.getAllReceiveRequestData(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,lists: data));
      },
      onError:(data){}
    );
  }

  FutureOr<void> _acceptRequest(AcceptRequest event, Emitter<ReceiveRequestMoneyState> emit) async {
    await repository.acceptReceiveRequestData(
      id: event.id,
      onSuccess: (data){
        add(GetData());
        SuccessMessage(message: appLanguage().successfully_transferred);
      },
      onError:(data){}
    );
  }
}
