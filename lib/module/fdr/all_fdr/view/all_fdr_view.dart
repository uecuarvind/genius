import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/fdr/all_fdr/data/fdr_list.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/all_fdr_bloc.dart';
import '../bloc/all_fdr_event.dart';
import '../bloc/all_fdr_state.dart';

class AllFdrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AllFdrBloc()..add(InitEvent(context)),
      child: BlocBuilder<AllFdrBloc,AllFdrState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AllFdrState state) {
    final bloc = BlocProvider.of<AllFdrBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: bloc.arguments?[AppConstant.page] ?? appLanguage(context).all_loans
      ),
      body: state.lists == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.lists!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.lists!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          FdrData data = state.lists!.data![index];
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
                  Text(data.fdrAmount ?? '',style: appTheme(context).textTheme.bodyMedium,)
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
                    Expanded(child: Text(appLanguage(context).profit_rate,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.profitRate ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).profit_type,style: appTheme(context).textTheme.headlineSmall,)),
                    Text((data.profitType ?? '').toUpperCase(),style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(data.nextProfitTime ?? '',style: appTheme(context).textTheme.bodyMedium,)
                ),
              ],
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
    );
  }
}

