import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/Widgets/dialog_button.dart';
import 'package:genius_bank/module/deposit/all_deposit/bloc/all_deposit_event.dart';
import 'package:genius_bank/module/deposit/all_deposit/bloc/all_deposit_state.dart';

import '../../../../main.dart';
import '../bloc/all_deposit_bloc.dart';

class AmountVerify extends StatelessWidget {
  AllDepositBloc bloc;

  AmountVerify(this.bloc, {super.key});

  GlobalKey<FormState> formKey=GlobalKey();
  TextEditingController amount=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDepositBloc, AllDepositState>(
      bloc: bloc,
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state.amountVerificationLoading,
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                DefaultTextField(
                  controller: amount,
                  label: appLanguage(context).amount,
                  textInputType: const TextInputType.numberWithOptions(decimal: true,),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                16.verticalSpace,
                DialogButton(
                    isLoading:state.amountVerificationLoading,
                    onTap: (state){
                      if(!state){
                        backPage();
                      } else {
                        if(formKey.currentState!.validate()){
                          bloc.add(ApplyForDeposit(amount.text));
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