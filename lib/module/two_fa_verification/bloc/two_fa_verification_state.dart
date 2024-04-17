import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/data/auth.dart';

import '../../../data/user.dart';
import '../data/two_fa_data.dart';

class TwoFAVerificationState {
  PageState pageState;
  TwoFaData? faData;
  User user = Auth.getAuth()!.data!.user!;
  bool verificationLoading = false;


  TwoFAVerificationState({this.pageState = PageState.Loading, this.faData,this.verificationLoading = false});

  TwoFAVerificationState init() {
    return TwoFAVerificationState();
  }

  TwoFAVerificationState clone({PageState? pageState, TwoFaData? faData, bool? verificationLoading}) {
    return TwoFAVerificationState(
      pageState: pageState ?? this.pageState,
      faData: faData ?? this.faData,
        verificationLoading: verificationLoading ?? this.verificationLoading
    );
  }
}
