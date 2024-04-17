import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/extensions.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/fdr/fdr_plan/data/fdr_check_amount.dart';
import 'package:genius_bank/repositories/fdr_repository.dart';

import '../../../../utils/app_constant.dart';
import '../data/fdr_plan.dart';
import 'fdr_plan_event.dart';
import 'fdr_plan_state.dart';

class FdrPlanBloc extends Bloc<FdrPlanEvent, FdrPlanState> {
  FdrRepository repository = FdrRepository();
  FdrPlanBloc() : super(FdrPlanState().init()) {
    on<InitEvent>(_init);
    on<GetPlans>(_getPlans);
    on<CheckAmount>(_checkAmount);
    on<SubmitFdr>(_submitFdr);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<FdrPlanState> emit) async {
    emit(state.clone());
    add(GetPlans());
  }

  Future _getPlans(GetPlans event, Emitter<FdrPlanState> emit) async {
    await repository.getPlans(
        onSuccess: (FdrPlan data){
          emit(state.clone(plans: data,pageState: PageState.Success));
        },
        onError: (Map<String,dynamic> data){}
    );
  }


  FutureOr<void> _checkAmount(CheckAmount event, Emitter<FdrPlanState> emit) async {
    emit(state.clone(amountVerificationLoading: true));
    await repository.checkAmount(
      body: event.body,
      onSuccess: (FdrCheckAmount data){
        state.checkAmount = data;
      },
      onError: (Map<String,dynamic> data){}
    );
    emit(state.clone(amountVerificationLoading: false));
  }


  FutureOr<void> _submitFdr(SubmitFdr event, Emitter<FdrPlanState> emit) async {
    emit(state.clone(amountVerificationLoading: true));
    await repository.submitFdsRequest(
        body: {
          AppConstant.plan_id: state.checkAmount!.data!.planId!.toString(),
          AppConstant.fdr_amount: state.checkAmount!.data!.fdrAmount!.toString(),
          AppConstant.profit_amount: state.checkAmount!.data!.profitAmount!.numeric,
        },
        onSuccess: (data){
          backPage();
          backPage();
          SuccessMessage(message: data[AppConstant.data]);
        },
        onError: (Map<String,dynamic> data){}
    );
    emit(state.clone(amountVerificationLoading: false));
  }
}
