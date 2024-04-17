import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/referrer_commission_bloc.dart';
import '../bloc/referrer_commission_event.dart';
import '../bloc/referrer_commission_state.dart';
import '../data/referrer_commission.dart';

class ReferrerCommissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ReferrerCommissionBloc()..add(InitEvent()),
      child: BlocBuilder<ReferrerCommissionBloc,ReferrerCommissionState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, ReferrerCommissionState state) {
    final bloc = BlocProvider.of<ReferrerCommissionBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).referral_commissions
      ),
      body: state.referrerCommission == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.referrerCommission!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.referrerCommission!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          CommissionData data = state.referrerCommission!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
              tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
              collapsedIconColor: AppColor.iconColor,
              iconColor: AppColor.iconColor,
              title: Row(
                children: [
                  Expanded(child: Text(data.from ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),)),
                  Text(data.amount ?? '',style: appTheme(context).textTheme.bodyMedium,)
                ],
              ),
              subtitle: Text(data.date ?? '',style: appTheme(context).textTheme.bodySmall!.copyWith(color: AppColor.grey),textAlign: TextAlign.right,),
              children: [
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).type,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.type ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
              ],
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
    );
  }
}

