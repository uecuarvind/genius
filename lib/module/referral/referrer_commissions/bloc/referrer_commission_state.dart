import 'package:genius_bank/module/referral/referrer_commissions/data/referrer_commission.dart';

import '../../../../app_helper/enums.dart';

class ReferrerCommissionState {
  ReferrerCommission? referrerCommission;
  PageState pageState;


  ReferrerCommissionState({this.referrerCommission, this.pageState = PageState.Loading});

  ReferrerCommissionState init() {
    return ReferrerCommissionState();
  }

  ReferrerCommissionState clone({ReferrerCommission? referrerCommission, PageState? pageState}) {
    return ReferrerCommissionState(
      pageState: pageState ?? this.pageState,
      referrerCommission: referrerCommission ?? this.referrerCommission
    );
  }
}
