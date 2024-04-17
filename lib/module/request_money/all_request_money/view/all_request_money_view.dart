import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/request_money/all_request_money/data/request_money_list.dart';
import 'package:genius_bank/routes/app_pages.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/all_request_money_bloc.dart';
import '../bloc/all_request_money_event.dart';
import '../bloc/all_request_money_state.dart';

class AllRequestMoneyPage extends StatelessWidget {
  AllRequestMoneyBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AllRequestMoneyBloc()..add(InitEvent()),
      child: BlocBuilder<AllRequestMoneyBloc,AllRequestMoneyState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AllRequestMoneyState state) {
    bloc ??= BlocProvider.of<AllRequestMoneyBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).request_money
      ),
      body: state.lists == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.lists!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.lists!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          RequestData data = state.lists!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
              tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
              collapsedIconColor: AppColor.iconColor,
              iconColor: AppColor.iconColor,
              title: Row(
                children: [
                  Expanded(child: Text(data.receiverName ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),)),
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
                    Expanded(child: Text(appLanguage(context).cost,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.cost.toString(),style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).amount_to_get,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.amountToGet ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).date,style: appTheme(context).textTheme.headlineSmall,)),
                    Text((data.date ?? '').toUpperCase(),style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(data.details ?? '',style: appTheme(context).textTheme.bodyMedium,)
                ),
              ],
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: ()=> sendRequestMoney(),
          icon: Icon(Icons.add,color: AppColor.buttonTextColor,),
          backgroundColor: AppColor.primary,
          label: Text(appLanguage(context).add_request_money,style: appTheme(context).textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),)
      )
    );
  }

  Future sendRequestMoney() async {
    var data = await goToPage(Routes.SUBMIT_REQUEST_MONEY);
    if(data != null && data == true){
      bloc!.add(GetData());
    }
  }
}

