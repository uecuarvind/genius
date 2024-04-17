import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/routes/app_pages.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/all_withdraw_bloc.dart';
import '../bloc/all_withdraw_event.dart';
import '../bloc/all_withdraw_state.dart';
import '../data/withdraw_list.dart';

class AllWithdrawPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AllWithdrawBloc()..add(InitEvent()),
      child: BlocBuilder<AllWithdrawBloc,AllWithdrawState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AllWithdrawState state) {
    final bloc = BlocProvider.of<AllWithdrawBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).withdraw
      ),
      body: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.transfers!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          WithdrawData data = state.transfers!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
              tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
              collapsedIconColor: AppColor.iconColor,
              iconColor: AppColor.iconColor,
              title: Row(
                children: [
                  Expanded(child: Text(data.method ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),)),
                  Text(data.amount ?? '',style: appTheme(context).textTheme.bodyMedium,)
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
                    Expanded(child: Text(appLanguage(context).fee,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.fee ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
              ],
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=> goToPage(Routes.ADD_WITHDRAW),
        icon: Icon(Icons.add,color: AppColor.buttonTextColor,),
        backgroundColor: AppColor.primary,
        label: Text(appLanguage(context).add_withdraw,style: appTheme(context).textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),)
      ),
    );
  }
}

