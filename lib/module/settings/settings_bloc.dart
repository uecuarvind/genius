import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/controllers/app_controller/bloc/app_controller_bloc.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  AppControllerBloc? appController;

  SettingsBloc() : super(SettingsState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<SettingsState> emit) async {
    appController = event.context.read<AppControllerBloc>();
    emit(state.clone());
  }
}
