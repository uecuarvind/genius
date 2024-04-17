import 'package:genius_bank/module/loan/loan_plan/data/apply_loan.dart';
import 'package:genius_bank/module/loan/loan_plan/data/plans.dart';

class ApplyLoanState {
  PlanData? planData;
  ApplyLoan? loanData;
  bool loading;


  ApplyLoanState({this.planData, this.loanData,this.loading = false});

  ApplyLoanState init() {
    return ApplyLoanState();
  }

  ApplyLoanState clone({PlanData? planData, ApplyLoan? loanData,bool? loading}) {
    return ApplyLoanState(
      planData: planData ?? this.planData,
      loanData: loanData ?? this.loanData,
      loading: loading ?? this.loading
    );
  }
}
