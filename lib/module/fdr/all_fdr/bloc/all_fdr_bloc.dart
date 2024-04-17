import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/fdr_repository.dart';
import 'all_fdr_event.dart';
import 'all_fdr_state.dart';

class AllFdrBloc extends Bloc<AllFdrEvent, AllFdrState> {
  FdrRepository repository = FdrRepository();
  Map<String,String>? arguments;

  AllFdrBloc() : super(AllFdrState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AllFdrState> emit) async {
    emit(state.clone());
    arguments = settings(event.context).arguments as Map<String, String>;
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<AllFdrState> emit) async {
    await repository.getAllFdr(
      url: arguments?[AppConstant.url] ?? '',
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,lists: data));
      },
      onError:(data){}
    );
  }
}
