import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/Widgets/dialog_button.dart';
import 'package:genius_bank/module/two_fa_verification/bloc/two_fa_verification_bloc.dart';
import 'package:genius_bank/module/two_fa_verification/bloc/two_fa_verification_event.dart';
import 'package:genius_bank/module/two_fa_verification/bloc/two_fa_verification_state.dart';

import '../../../../main.dart';
import '../../../../utils/app_constant.dart';

class CodeVerify extends StatelessWidget {
  TwoFAVerificationBloc bloc;

  CodeVerify(this.bloc, {super.key});

  GlobalKey<FormState> formKey=GlobalKey();
  TextEditingController code=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TwoFAVerificationBloc, TwoFAVerificationState>(
      bloc: bloc,
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state.verificationLoading,
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                DefaultTextField(
                  controller: code,
                  label: appLanguage(context).verification_code,
                  textInputType: const TextInputType.numberWithOptions(decimal: true,),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                16.verticalSpace,
                DialogButton(
                    isLoading:state.verificationLoading,
                    onTap: (state){
                      if(!state){
                        backPage();
                      } else {
                        if(formKey.currentState!.validate()){
                          bloc.add(ChangeTwoFaState(code.text));
                        }
                      }
                    },
                    positiveButton: appLanguage(context).submit,
                    negativeButton: appLanguage(context).cancel
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}