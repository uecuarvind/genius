import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/Widgets/dialog_button.dart';
import 'package:genius_bank/Widgets/divider_list.dart';

import '../../../../main.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/dimension.dart';
import '../bloc/fdr_plan_bloc.dart';
import '../bloc/fdr_plan_event.dart';
import '../bloc/fdr_plan_state.dart';
import '../data/fdr_plan.dart';

class FdrAmountVerify extends StatelessWidget {
  FdrPlanBloc bloc;
  PlanData data;

  FdrAmountVerify(this.bloc, this.data, {super.key});

  GlobalKey<FormState> formKey=GlobalKey();
  TextEditingController amount=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FdrPlanBloc, FdrPlanState>(
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
                state.checkAmount == null ? DefaultTextField(
                  controller: amount,
                  label: appLanguage(context).amount,
                  textInputType: const TextInputType.numberWithOptions(decimal: true,),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    singleData(title: appLanguage(context).plan_title,data: data.title!,context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).amount,data: state.checkAmount!.data!.fdrAmount ?? '0',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).locked_in_period,data: state.checkAmount!.data!.lockedInPeriod ?? '0',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).get_profit,data: state.checkAmount!.data!.getProfit ?? '0',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).interest_rate_in_total_deposit,data: '${state.checkAmount!.data!.interestRate}',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).amount_to_get,data: state.checkAmount!.data!.profitAmount ?? '0',context: context),
                  ],
                ),
                16.verticalSpace,
                DialogButton(
                  isLoading:state.amountVerificationLoading,
                  onTap: (bottonState){
                    if(!bottonState){
                      backPage();
                    } else {
                      if(formKey.currentState!.validate() && state.checkAmount == null){
                        bloc.add(CheckAmount(
                          {
                            AppConstant.amount:amount.text,
                            AppConstant.planId: data.id!.toString()
                          },
                          data
                        ));
                      } else {
                        bloc.add(SubmitFdr());
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

  Widget singleData({required String title,required String data,required BuildContext context}){
    return DividerList(
      padding: EdgeInsets.only(bottom: 8.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(title,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)),
          Text(data,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)
        ],
      ),
    );
  }

}