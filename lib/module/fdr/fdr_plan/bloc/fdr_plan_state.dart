import 'package:genius_bank/app_helper/enums.dart';

import '../data/fdr_check_amount.dart';
import '../data/fdr_plan.dart';

class FdrPlanState {
  PageState pageState;
  FdrPlan? plans;
  bool amountVerificationLoading;
  FdrCheckAmount? checkAmount;


  FdrPlanState({
    this.pageState = PageState.Loading,
    this.plans,
    this.amountVerificationLoading = false,
    this.checkAmount
  });

  FdrPlanState init() {
    return FdrPlanState();
  }

  FdrPlanState clone({PageState? pageState, FdrPlan? plans,bool? amountVerificationLoading,FdrCheckAmount? checkAmount}) {
    return FdrPlanState(
      pageState: pageState ?? this.pageState,
      plans: plans ?? this.plans,
      amountVerificationLoading: amountVerificationLoading ?? this.amountVerificationLoading,
      checkAmount: checkAmount ?? this.checkAmount
    );
  }
}
