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
import 'package:genius_bank/module/wire_transfer/all_wire_transfer/data/wire_transfers.dart';
import 'package:genius_bank/routes/app_pages.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/all_wire_transfer_bloc.dart';
import '../bloc/all_wire_transfer_event.dart';
import '../bloc/all_wire_transfer_state.dart';

class AllWireTransferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AllWireTransferBloc()..add(InitEvent()),
      child: BlocBuilder<AllWireTransferBloc,AllWireTransferState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AllWireTransferState state) {
    final bloc = BlocProvider.of<AllWireTransferBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).wire_transfer
      ),
      body: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.transfers!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          WireData data = state.transfers!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
              tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
              collapsedIconColor: AppColor.iconColor,
              iconColor: AppColor.iconColor,
              title: Row(
                children: [
                  Expanded(child: Text(data.bankName ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),)),
                  Text('${data.amount}',style: appTheme(context).textTheme.bodyMedium,)
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
                    Expanded(child: Text(appLanguage(context).swift_code,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.swiftCode ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).currency,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.currency ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).routing_number,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.routingNumber ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).country,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.country ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).receiver_account_name,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.accountName ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).receiver_account_number,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.accountNumber ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
              ],
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=> goToPage(Routes.ADD_WIRE_TRANSFER),
        icon: Icon(Icons.add,color: AppColor.buttonTextColor,),
        backgroundColor: AppColor.primary,
        label: Text(appLanguage(context).add_transfer,style: appTheme(context).textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),)
      ),
    );
  }
}

