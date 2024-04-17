import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransferRepository repository = TransferRepository();

  TransactionsBloc() : super(TransactionsState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TransactionsState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<TransactionsState> emit) async {
    await repository.getTransactions(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,transfers: data));
      },
      onError:(data){}
    );
  }
}
