import 'package:genius_bank/app_helper/enums.dart';

class SignUpState {
  bool rememberMe = true;
  PageState pageState;


  SignUpState({this.rememberMe = true,this.pageState = PageState.Initial});

  SignUpState init() {
    return SignUpState();
  }

  SignUpState clone({bool? rememberMe,PageState? state}) {
    return SignUpState(
      rememberMe: rememberMe ?? this.rememberMe,
      pageState: state ?? pageState
    );
  }
}
