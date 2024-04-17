import '../../../../app_helper/enums.dart';
import '../data/loans.dart';

class AllLoanState {
  Loans? loans;
  PageState pageState;


  AllLoanState({this.loans, this.pageState = PageState.Loading});

  AllLoanState init() {
    return AllLoanState();
  }

  AllLoanState clone({Loans? loans, PageState? pageState}) {
    return AllLoanState(
      pageState: pageState ?? this.pageState,
      loans: loans ?? this.loans
    );
  }
}
