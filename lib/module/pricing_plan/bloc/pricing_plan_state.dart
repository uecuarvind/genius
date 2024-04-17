import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/module/pricing_plan/data/pricing_plan.dart';

class PricingPlanState {
  PageState pageState;
  PricingPlan? plans;
  bool amountVerificationLoading;


  PricingPlanState({
    this.pageState = PageState.Loading,
    this.plans,
    this.amountVerificationLoading = false
  });

  PricingPlanState init() {
    return PricingPlanState();
  }

  PricingPlanState clone({PageState? pageState, PricingPlan? plans,bool? amountVerificationLoading}) {
    return PricingPlanState(
      pageState: pageState ?? this.pageState,
      plans: plans ?? this.plans,
      amountVerificationLoading: amountVerificationLoading ?? this.amountVerificationLoading
    );
  }
}
