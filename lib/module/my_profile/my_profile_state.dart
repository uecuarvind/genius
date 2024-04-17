import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/data/auth.dart';

class MyProfileState {
  Auth? auth;
  PageState pageState;


  MyProfileState({this.pageState = PageState.Initial,this.auth});

  MyProfileState init() {
    return MyProfileState(
      auth: Auth.getAuth()
    );
  }

  MyProfileState clone({PageState? pageState,Auth? auth}) {
    return MyProfileState(
      pageState: pageState ?? this.pageState,
      auth: auth ?? this.auth,
    );
  }
}
