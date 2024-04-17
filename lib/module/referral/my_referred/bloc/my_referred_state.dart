import '../../../../app_helper/enums.dart';
import '../data/referral_user.dart';

class MyReferredState {
  ReferralUser? myReferred;
  PageState pageState;


  MyReferredState({this.myReferred, this.pageState = PageState.Loading});

  MyReferredState init() {
    return MyReferredState();
  }

  MyReferredState clone({ReferralUser? myReferred, PageState? pageState}) {
    return MyReferredState(
      pageState: pageState ?? this.pageState,
      myReferred: myReferred ?? this.myReferred
    );
  }
}
