import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/request_money_repository.dart';
import 'all_request_money_event.dart';
import 'all_request_money_state.dart';

class AllRequestMoneyBloc extends Bloc<AllRequestMoneyEvent, AllRequestMoneyState> {
  RequestMoneyRepository repository = RequestMoneyRepository();

  AllRequestMoneyBloc() : super(AllRequestMoneyState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AllRequestMoneyState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<AllRequestMoneyState> emit) async {
    await repository.getAllRequestData(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,lists: data));
      },
      onError:(data){}
    );
  }
}
