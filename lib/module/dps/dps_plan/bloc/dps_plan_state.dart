import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/module/dps/dps_plan/data/dps_plan.dart';

class DpsPlanState {
  PageState pageState;
  DpsPlan? plans;
  bool amountVerificationLoading;


  DpsPlanState({
    this.pageState = PageState.Loading,
    this.plans,
    this.amountVerificationLoading = false
  });

  DpsPlanState init() {
    return DpsPlanState();
  }

  DpsPlanState clone({PageState? pageState, DpsPlan? plans,bool? amountVerificationLoading}) {
    return DpsPlanState(
      pageState: pageState ?? this.pageState,
      plans: plans ?? this.plans,
      amountVerificationLoading: amountVerificationLoading ?? this.amountVerificationLoading
    );
  }
}
