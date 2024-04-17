import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/module/loan/loan_plan/data/plans.dart';

class LoanPlanState {
  PageState pageState;
  Plans? plans;
  bool amountVerificationLoading;


  LoanPlanState({
    this.pageState = PageState.Loading,
    this.plans,
    this.amountVerificationLoading = false
  });

  LoanPlanState init() {
    return LoanPlanState();
  }

  LoanPlanState clone({PageState? pageState, Plans? plans,bool? amountVerificationLoading}) {
    return LoanPlanState(
      pageState: pageState ?? this.pageState,
      plans: plans ?? this.plans,
      amountVerificationLoading: amountVerificationLoading ?? this.amountVerificationLoading
    );
  }
}
