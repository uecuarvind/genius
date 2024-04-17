import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/app_background.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_button.dart';
import 'package:genius_bank/Widgets/default_dialog.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/loan/loan_plan/data/plans.dart';
import 'package:genius_bank/theme/app_color.dart';
import 'package:genius_bank/utils/dimension.dart';

import '../../../../Widgets/circular_progress.dart';
import '../../../../app_helper/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../bloc/loan_plan_bloc.dart';
import '../bloc/loan_plan_event.dart';
import '../bloc/loan_plan_state.dart';
import 'amount_verify.dart';

class LoanPlanPage extends StatelessWidget {
  LoanPlanBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoanPlanBloc()..add(InitEvent()),
      child: BlocBuilder<LoanPlanBloc,LoanPlanState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, LoanPlanState state) {
    bloc ??= BlocProvider.of<LoanPlanBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).loan_plan
      ),
      body: AppBackground(
        child: state.pageState == PageState.Loading ? CircularProgress(height: 1.sh) :
          ListView.builder(
            shrinkWrap: true,
            itemCount: state.plans!.data!.length,
            itemBuilder: (ctx,index){
              return singlePlan(state.plans!.data![index],context);
            }
          )
      ),
    );
  }

  Widget singlePlan(PlanData data, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.cardColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(width: 1,color: AppColor.dividerColor)
            ),
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(data.title ?? '',style: appTheme(context).textTheme.headlineLarge,)),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.textFieldBackground,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        children: [
                          Text(data.perInstallment ?? '0 %',style: appTheme(context).textTheme.headlineMedium,),
                          Text(appLanguage(context).per_installment,style: appTheme(context).textTheme.bodyLarge,),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:EdgeInsets.symmetric(vertical: 10.r),
                  child: Divider(color: AppColor.dividerColor,thickness: 1,height: 1,),
                ),
                singleData(
                  title: appLanguage(context).minimum_amount,
                  data: data.minAmount ?? '',
                  context: context
                ),
                singleData(
                  title: appLanguage(context).maximum_amount,
                  data: data.maxAmount ?? '',
                  context: context
                ),
                singleData(
                  title: appLanguage(context).installment_interval,
                  data: data.installmentInterval ?? '',
                  context: context
                ),
                singleData(
                  title: appLanguage(context).total_interval,
                  data: data.totalInstallment ?? '',
                  context: context
                ),
                16.verticalSpace,
                DefaultButton(
                  onTap: ()=>applyDialog(context: context,data: data),
                  padding: EdgeInsets.symmetric(vertical: 8.r),
                  backgroundColor: AppColor.green,
                  child: Text(appLanguage(context).apply,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textMedium),)
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 20.r,
          child: Assets.images.bookmarkTag.image(height: 50.h),
        )
      ],
    );
  }

  Widget singleData({required String title,required String data,required BuildContext context}){
    return Container(
      margin: EdgeInsets.only(bottom: 12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline_rounded,color: AppColor.primary,size: 14.h,),
          8.horizontalSpace,
          Expanded(child: Text(title,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)),
          Text(data,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)
        ],
      ),
    );
  }

  void applyDialog({required BuildContext context, required PlanData data}){
    showDialog(
      context: context,
      builder: (ctx){
        return DefaultDialog(
          title: appLanguage(context).loan,
          child: AmountVerify(bloc!,data),
        );
      }
    );
  }
}

