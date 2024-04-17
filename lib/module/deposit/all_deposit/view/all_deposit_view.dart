import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/extensions.dart';
import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/deposit/all_deposit/data/deposit_list.dart';

import '../../../../Widgets/default_dialog.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/all_deposit_bloc.dart';
import '../bloc/all_deposit_event.dart';
import '../bloc/all_deposit_state.dart';
import 'amount_verify.dart';

class AllDepositPage extends StatelessWidget {
  AllDepositBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AllDepositBloc()..add(InitEvent()),
      child: BlocBuilder<AllDepositBloc,AllDepositState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AllDepositState state) {
    bloc ??= BlocProvider.of<AllDepositBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).deposit
      ),
      body: state.deposits == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.deposits!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.deposits!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          DepositData data = state.deposits!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
              tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
              collapsedIconColor: AppColor.iconColor,
              iconColor: AppColor.iconColor,
              title: Row(
                children: [
                  Expanded(child: Text(data.method ?? appLanguage(context).incomplete_transaction,style: appTheme(context).textTheme.headlineSmall!.copyWith(
                      color: data.method!=null ? AppColor.primary : AppColor.grey
                  ),)),
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
                    Expanded(child: Text(appLanguage(context).email,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.userEmail ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).date,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.depositDate ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
              ],
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>applyDialog(context: context),
        icon: Icon(Icons.add,color: AppColor.buttonTextColor,),
        backgroundColor: AppColor.primary,
        label: Text(appLanguage(context).add_deposit,style: appTheme(context).textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),)
      ),
    );
  }


  void applyDialog({required BuildContext context}){
    showDialog(
        context: context,
        builder: (ctx){
          return DefaultDialog(
            title: appLanguage(context).loan,
            child: AmountVerify(bloc!),
          );
        }
    );
  }
}

