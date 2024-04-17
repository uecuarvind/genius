import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/module/reset_password/data/reset_password.dart';

class ResetPasswordState {
  PageState pageState;
  ResetPassword? resetPassword;

  ResetPasswordState({this.pageState = PageState.Initial,this.resetPassword});

  ResetPasswordState init() {
    return ResetPasswordState();
  }

  ResetPasswordState copyWith({PageState? pageState,ResetPassword? resetPassword}) {
    return ResetPasswordState(
      pageState: pageState ?? this.pageState,
      resetPassword: resetPassword ?? this.resetPassword
    );
  }
}
