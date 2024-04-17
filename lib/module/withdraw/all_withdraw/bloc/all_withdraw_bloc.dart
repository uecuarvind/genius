import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/withdraw_repository.dart';
import 'all_withdraw_event.dart';
import 'all_withdraw_state.dart';

class AllWithdrawBloc extends Bloc<AllWithdrawEvent, AllWithdrawState> {
  WithdrawRepository repository = WithdrawRepository();

  AllWithdrawBloc() : super(AllWithdrawState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AllWithdrawState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<AllWithdrawState> emit) async {
    await repository.getWithdrawList(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,transfers: data));
      },
      onError:(data){}
    );
  }
}
