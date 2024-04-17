import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import 'transfer_list_event.dart';
import 'transfer_list_state.dart';

class TransferListBloc extends Bloc<TransferListEvent, TransferListState> {
  TransferRepository repository = TransferRepository();

  TransferListBloc() : super(TransferListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TransferListState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<TransferListState> emit) async {
    await repository.getTransferList(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,transfers: data));
      },
      onError:(data){}
    );
  }
}
