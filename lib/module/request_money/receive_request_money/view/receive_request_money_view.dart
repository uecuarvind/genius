import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/request_money/receive_request_money/data/receive_request_money_list.dart';

import '../../../../Widgets/message_dialog.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/receive_request_money_bloc.dart';
import '../bloc/receive_request_money_event.dart';
import '../bloc/receive_request_money_state.dart';

class ReceiveRequestMoneyPage extends StatelessWidget {
  ReceiveRequestMoneyBloc? bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ReceiveRequestMoneyBloc()..add(InitEvent()),
      child: BlocBuilder<ReceiveRequestMoneyBloc,ReceiveRequestMoneyState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, ReceiveRequestMoneyState state) {
    bloc ??= BlocProvider.of<ReceiveRequestMoneyBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).receive_request_money
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
                  Expanded(child: Text(data.senderName ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),)),
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
                    Text(data.date ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                if(data.details != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.verticalSpace,
                      Text(data.details ?? '',style: appTheme(context).textTheme.bodyMedium,),
                    ],
                  ),
                if(data.status != null && data.status!.toLowerCase() != 'succeed')
                  Column(
                    children: [
                      8.verticalSpace,
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: ()=> approveRequestMoney(data),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.r).copyWith(left: 16.r),
                            width: .25.sw,
                            decoration: BoxDecoration(
                                color: AppColor.textFieldBackground,
                                borderRadius: BorderRadius.circular(5.r)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check,color: AppColor.iconColor,size: 18.r,),
                                8.horizontalSpace,
                                Text(appLanguage(context).send,style: appTheme(context).textTheme.headlineMedium!.copyWith(color: AppColor.primary),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
    );
  }

  void approveRequestMoney(RequestData data){
    MessageDialog(
      title: appLanguage().warning,
      message: appLanguage().accept_request_money_message,
      isConfirmDialog: true,
      onTap: (state){
        backPage();
        if(state){
          bloc!.add(AcceptRequest(data.id!.toString()));
        }
      }
    );
  }
}

