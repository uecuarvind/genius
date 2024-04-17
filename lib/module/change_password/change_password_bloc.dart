import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/user_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import 'change_password_event.dart';
import 'change_password_state.dart';
class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  UserRepository repository = UserRepository();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController conNewPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ChangePasswordBloc() : super(ChangePasswordState().init()) {
    on<InitEvent>(_init);
    on<SubmitEvent>(_submitData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<ChangePasswordState> emit) async {
    emit(state.clone());
  }

  Future _submitData(SubmitEvent event, Emitter<ChangePasswordState> emit) async {
    if(!formKey.currentState!.validate()) {
      return;
    }
    Map<String,String> body = {
      AppConstant.current_password: oldPasswordController.text,
      AppConstant.new_password: newPasswordController.text,
      AppConstant.renew_password: conNewPasswordController.text,
    };
    emit(state.clone(pageState: PageState.Loading));
    await repository.changePassword(
        body: body,
        onSuccess: (data){
          backPage();
          SuccessMessage(message: appLanguage().password_changed_successfully);
        },
        onError: (data){
        }
    );
    emit(state.clone(pageState: PageState.Success));
  }
}
