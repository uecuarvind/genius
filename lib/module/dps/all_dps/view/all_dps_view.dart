import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/dps/all_dps/data/dps.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/all_dps_bloc.dart';
import '../bloc/all_dps_event.dart';
import '../bloc/all_dps_state.dart';

class AllDpsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AllDpsBloc()..add(InitEvent(context)),
      child: BlocBuilder<AllDpsBloc,AllDpsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AllDpsState state) {
    final bloc = BlocProvider.of<AllDpsBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: bloc.arguments?[AppConstant.page] ?? appLanguage(context).all_loans
      ),
      body: state.dps == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.dps!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.dps!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          DpsData data = state.dps!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
              tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
              collapsedIconColor: AppColor.iconColor,
              iconColor: AppColor.iconColor,
              title: Row(
                children: [
                  Expanded(child: Text(data.planTitle ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),)),
                  Text(data.perInstallment ?? '',style: appTheme(context).textTheme.bodyMedium,)
                ],
              ),
              subtitle: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 5.r),
                  decoration: BoxDecoration(
                    color: Helper.getStatusColor(data.status!),
                    borderRadius: BorderRadius.circular(20.r)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.r,vertical: 4.r),
                  child: Text((data.status ?? '').toUpperCase(),style: appTheme(context).textTheme.bodySmall!.copyWith(color: Colors.black),),
                ),
              ),
              children: [
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).txnID,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.transactionNo.toString(),style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).deposit_amount,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.depositAmount ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).matured_amount,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.maturedAmount ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).total_installment,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.totalInstallment ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).given_installment,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.givenInstallment ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).next_installment,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.nextInstallment ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: (){
                      goToPage(Routes.LOG_DETAILS,arguments: {
                        AppConstant.page: appLanguage(context).dps_installment_log,
                        AppConstant.url: data.logs!
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.r).copyWith(left: 16.r),
                      width: .2.sw,
                      decoration: BoxDecoration(
                        color: AppColor.textFieldBackground,
                        borderRadius: BorderRadius.circular(5.r)
                      ),
                      child: Row(
                        children: [
                          Text(appLanguage(context).logs,style: appTheme(context).textTheme.headlineMedium!.copyWith(color: AppColor.primary),),
                          Icon(Icons.keyboard_arrow_right_rounded,color: AppColor.iconColor,size: 18.r,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
    );
  }
}

