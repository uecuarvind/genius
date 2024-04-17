import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/controllers/connnectivity_helper.dart';
import 'package:injectable/injectable.dart';

import 'app_controller_event.dart';
import 'app_controller_state.dart';

@injectable
class AppControllerBloc extends Bloc<AppControllerEvent, AppControllerState> {
  ConnectivityHelper connectivityHelper = ConnectivityHelper();
  AppControllerBloc() : super(AppControllerState()..inti()){
    on<InitAppEvent>(init);
    on<ChangeLanguage>(changeLanguage);
    on<ChangeTheme>(changeTheme);
  }

  Future<void> init(InitAppEvent event, Emitter<AppControllerState> emit,) async {
    state.inti();
  }

  Future<void> changeLanguage(ChangeLanguage event, Emitter<AppControllerState> emit,) async {
    emit(state.copyWith(locale:event.locale));
  }

  FutureOr<void> changeTheme(ChangeTheme event, Emitter<AppControllerState> emit) {
    emit(state.copyWith(changeTheme: true));
  }
}
