import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/repositories/wire_transfer_repository.dart';

import '../../../../app_helper/enums.dart';
import 'all_wire_transfer_event.dart';
import 'all_wire_transfer_state.dart';

class AllWireTransferBloc extends Bloc<AllWireTransferEvent, AllWireTransferState> {
  WireTransferRepository repository = WireTransferRepository();

  AllWireTransferBloc() : super(AllWireTransferState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AllWireTransferState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<AllWireTransferState> emit) async {
    await repository.getTransferList(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,transfers: data));
      },
      onError:(data){}
    );
  }
}
