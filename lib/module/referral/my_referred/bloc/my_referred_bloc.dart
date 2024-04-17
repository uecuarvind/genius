import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/repositories/user_repository.dart';

import '../../../../app_helper/enums.dart';
import 'my_referred_event.dart';
import 'my_referred_state.dart';

class MyReferredBloc extends Bloc<MyReferredEvent, MyReferredState> {
  UserRepository repository = UserRepository();

  MyReferredBloc() : super(MyReferredState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<MyReferredState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<MyReferredState> emit) async {
    await repository.getReferralData(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,myReferred: data));
      },
      onError:(data){}
    );
  }
}
