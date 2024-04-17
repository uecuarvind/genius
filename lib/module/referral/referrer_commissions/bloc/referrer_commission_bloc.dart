import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/repositories/user_repository.dart';

import '../../../../app_helper/enums.dart';
import 'referrer_commission_event.dart';
import 'referrer_commission_state.dart';

class ReferrerCommissionBloc extends Bloc<ReferrerCommissionEvent, ReferrerCommissionState> {
  UserRepository repository = UserRepository();

  ReferrerCommissionBloc() : super(ReferrerCommissionState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ReferrerCommissionState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<ReferrerCommissionState> emit) async {
    await repository.getReferrerCommission(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,referrerCommission: data));
      },
      onError:(data){}
    );
  }
}
