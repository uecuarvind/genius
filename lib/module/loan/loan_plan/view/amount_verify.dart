import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/Widgets/dialog_button.dart';
import 'package:genius_bank/module/loan/loan_plan/bloc/loan_plan_state.dart';
import 'package:genius_bank/module/loan/loan_plan/data/plans.dart';

import '../../../../main.dart';
import '../../../../utils/app_constant.dart';
import '../bloc/loan_plan_bloc.dart';
import '../bloc/loan_plan_event.dart';

class AmountVerify extends StatelessWidget {
  LoanPlanBloc bloc;
  PlanData data;

  AmountVerify(this.bloc, this.data, {super.key});

  GlobalKey<FormState> formKey=GlobalKey();
  TextEditingController amount=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanPlanBloc, LoanPlanState>(
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
                          bloc.add(CheckAmount(
                            {
                              AppConstant.amount:amount.text,
                              AppConstant.planId: data.id!.toString()
                            },
                            data
                          ));
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