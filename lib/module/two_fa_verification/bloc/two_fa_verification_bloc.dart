import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/user_repository.dart';

import '../../../controllers/share_helper.dart';
import '../../../data/auth.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/url.dart';
import 'two_fa_verification_event.dart';
import 'two_fa_verification_state.dart';

class TwoFAVerificationBloc extends Bloc<TwoFAVerificationEvent, TwoFAVerificationState> {
  UserRepository repository = UserRepository();

  TwoFAVerificationBloc() : super(TwoFAVerificationState().init()) {
    on<InitEvent>(_init);
    on<ChangeTwoFaState>(_changeTwoFaState);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TwoFAVerificationState> emit) async {
    await repository.getTwoFaData(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,faData: data));
      },
      onError: (data){
        emit(state.clone(pageState: PageState.Error));
      }
    );
  }

  FutureOr<void> _changeTwoFaState(ChangeTwoFaState event, Emitter<TwoFAVerificationState> emit) async {
    emit(state.clone(verificationLoading: true));
    await repository.changeTwoFaState(
      url: state.user.twofa! == "1" ? URL.disableVerification : URL.enableVerification,
      body: {
        AppConstant.key: state.faData!.data!.secret!,
        AppConstant.code: event.code,
      },
      onSuccess: (data){
        state.user.twofa = state.user.twofa! == "1" ? "0" : "1";
        emit(state);
        Auth? auth = Auth.getAuth();
        auth!.data!.user = state.user;
        ShareHelper.setAuth(auth);
        backPage();
      },
      onError: (data){}
    );
    emit(state.clone(verificationLoading: false));
  }
}
