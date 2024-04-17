import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/dps_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../app_helper/enums.dart';
import 'all_dps_event.dart';
import 'all_dps_state.dart';

class AllDpsBloc extends Bloc<AllDpsEvent, AllDpsState> {
  DpsRepository repository = DpsRepository();
  Map<String,String>? arguments;

  AllDpsBloc() : super(AllDpsState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AllDpsState> emit) async {
    emit(state.clone());
    arguments = settings(event.context).arguments as Map<String, String>;
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<AllDpsState> emit) async {
    await repository.getAllDps(
      url: arguments?[AppConstant.url] ?? '',
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,dps: data));
      },
      onError:(data){}
    );
  }
}
