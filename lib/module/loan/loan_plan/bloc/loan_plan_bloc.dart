import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/loan/loan_plan/data/plans.dart';
import 'package:genius_bank/repositories/loan_repository.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../data/apply_loan.dart';
import 'loan_plan_event.dart';
import 'loan_plan_state.dart';

class LoanPlanBloc extends Bloc<LoanPlanEvent, LoanPlanState> {
  LoanRepository repository = LoanRepository();
  LoanPlanBloc() : super(LoanPlanState().init()) {
    on<InitEvent>(_init);
    on<GetPlans>(_getPlans);
    on<CheckAmount>(_checkAmount);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<LoanPlanState> emit) async {
    emit(state.clone());
    add(GetPlans());
  }

  Future _getPlans(GetPlans event, Emitter<LoanPlanState> emit) async {
    await repository.getPlans(
        onSuccess: (Plans data){
          emit(state.clone(plans: data,pageState: PageState.Success));
        },
        onError: (Map<String,dynamic> data){}
    );
  }


  FutureOr<void> _checkAmount(CheckAmount event, Emitter<LoanPlanState> emit) async {
    emit(state.clone(amountVerificationLoading: true));
    await repository.checkAmount(
      body: event.body,
      onSuccess: (ApplyLoan data){
        backPage();
        goToPage(Routes.APPLY_LOAN,arguments: <String, dynamic>{
          AppConstant.plan_data: event.data,
          AppConstant.data: data,
        });
      },
      onError: (Map<String,dynamic> data){}
    );
    emit(state.clone(amountVerificationLoading: false));
  }

}
