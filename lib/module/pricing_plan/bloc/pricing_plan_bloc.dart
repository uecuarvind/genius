import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/module/pricing_plan/data/pricing_plan.dart';
import 'package:genius_bank/repositories/user_repository.dart';

import 'pricing_plan_event.dart';
import 'pricing_plan_state.dart';

class PricingPlanBloc extends Bloc<PricingPlanEvent, PricingPlanState> {
  UserRepository repository = UserRepository();
  PricingPlanBloc() : super(PricingPlanState().init()) {
    on<InitEvent>(_init);
    on<GetPlans>(_getPlans);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<PricingPlanState> emit) async {
    emit(state.clone());
    add(GetPlans());
  }

  Future _getPlans(GetPlans event, Emitter<PricingPlanState> emit) async {
    await repository.getSubscriptionPlan(
        onSuccess: (PricingPlan data){
          emit(state.clone(plans: data,pageState: PageState.Success));
        },
        onError: (Map<String,dynamic> data){}
    );
  }

}
