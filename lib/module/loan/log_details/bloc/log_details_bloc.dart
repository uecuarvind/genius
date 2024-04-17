import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/loan_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../app_helper/enums.dart';
import 'log_details_event.dart';
import 'log_details_state.dart';

class LogDetailsBloc extends Bloc<LogDetailsEvent, LogDetailsState> {
  LoanRepository repository = LoanRepository();
  Map<String,String>? arguments;

  LogDetailsBloc() : super(LogDetailsState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<LogDetailsState> emit) async {
    emit(state.clone());
    arguments = settings(event.context).arguments as Map<String, String>;
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<LogDetailsState> emit) async {
    await repository.getLoanLogs(
      url: arguments?[AppConstant.url] ?? '',
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,logs: data));
      },
      onError:(data){}
    );
  }
}
