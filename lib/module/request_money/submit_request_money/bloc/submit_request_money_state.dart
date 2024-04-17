import '../../../../app_helper/enums.dart';

class SubmitRequestMoneyState {
  PageState pageState;
  bool loading;


  SubmitRequestMoneyState({this.pageState = PageState.Loading, this.loading = false});

  SubmitRequestMoneyState init() {
    return SubmitRequestMoneyState();
  }

  SubmitRequestMoneyState clone({ PageState? pageState,bool? loading}) {
    return SubmitRequestMoneyState(
      pageState: pageState ?? this.pageState,
      loading: loading ?? this.loading,
    );
  }
}
