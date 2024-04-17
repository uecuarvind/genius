import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../app_helper/enums.dart';
import '../../../../repositories/transfer_repository.dart';
import 'others_banks_event.dart';
import 'others_banks_state.dart';

class OthersBanksBloc extends Bloc<OthersBanksEvent, OthersBanksState> {
  TransferRepository transferRepository = TransferRepository();

  OthersBanksBloc() : super(OthersBanksState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    transferRepository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<OthersBanksState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<OthersBanksState> emit) async {
    await transferRepository.getOthersBankList(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,listData: data));
      },
      onError:(data){}
    );
  }
}
