import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/app_background.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_button.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/pricing_plan/data/pricing_plan.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/theme/app_color.dart';
import 'package:genius_bank/utils/dimension.dart';

import '../../../../Widgets/circular_progress.dart';
import '../../../../app_helper/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../utils/app_constant.dart';
import '../bloc/pricing_plan_bloc.dart';
import '../bloc/pricing_plan_event.dart';
import '../bloc/pricing_plan_state.dart';
class PricingPlanPage extends StatelessWidget {
  PricingPlanBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PricingPlanBloc()..add(InitEvent()),
      child: BlocBuilder<PricingPlanBloc,PricingPlanState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, PricingPlanState state) {
    bloc ??= BlocProvider.of<PricingPlanBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).pricing_plan
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

  Widget singlePlan(PricingData data, BuildContext context) {
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
                          Text(data.amount ?? '',style: appTheme(context).textTheme.headlineMedium,),
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
                  title: appLanguage(context).max_send_money,
                  data: data.maximumMonthlySend ?? '',
                  context: context
                ),
                singleData(
                  title: appLanguage(context).max_loan_amount,
                  data: data.maximumLoanAmount ?? '',
                  context: context
                ),
                singleData(
                  title: appLanguage(context).plan_valid_for,
                  data: data.endDays ?? '',
                  context: context
                ),
                16.verticalSpace,
                DefaultButton(
                  onTap: ()=> goToPage(Routes.PAYMENT_PAGE,arguments: {
                    AppConstant.url: data.getStarted!
                  }),
                  enable: data.userCurrentPlan!.toLowerCase() != 'yes',
                  padding: EdgeInsets.symmetric(vertical: 8.r),
                  backgroundColor: AppColor.green,
                  child: Text(data.userCurrentPlan!.toLowerCase() == 'yes' ? appLanguage(context).current_plan : appLanguage(context).get_started,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textMedium),)
                ),
                if(data.userCurrentPlan!.toLowerCase() == 'yes')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('(${data.planExpireDate})',style: appTheme(context).textTheme.bodyLarge,),
                      TextButton(
                        onPressed: ()=> goToPage(Routes.PAYMENT_PAGE,arguments: {
                          AppConstant.url: data.getStarted!
                        }),
                        child: Text(appLanguage(context).renew_plan, style: appTheme(context).textTheme.bodyLarge!.copyWith(
                          color: AppColor.primary
                        ),)
                      )
                    ],
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
}

