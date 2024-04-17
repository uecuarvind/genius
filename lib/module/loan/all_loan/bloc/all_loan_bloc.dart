import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/loan_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../app_helper/enums.dart';
import 'all_loan_event.dart';
import 'all_loan_state.dart';

class AllLoanBloc extends Bloc<AllLoanEvent, AllLoanState> {
  LoanRepository repository = LoanRepository();
  Map<String,String>? arguments;

  AllLoanBloc() : super(AllLoanState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AllLoanState> emit) async {
    emit(state.clone());
    arguments = settings(event.context).arguments as Map<String, String>;
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<AllLoanState> emit) async {
    await repository.getAllLoans(
      url: arguments?[AppConstant.url] ?? '',
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,loans: data));
      },
      onError:(data){}
    );
  }
}
