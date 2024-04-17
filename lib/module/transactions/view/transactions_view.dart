import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/transactions/data/transactions.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_event.dart';
import '../bloc/transactions_state.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TransactionsBloc()..add(InitEvent()),
      child: BlocBuilder<TransactionsBloc,TransactionsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, TransactionsState state) {
    final bloc = BlocProvider.of<TransactionsBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).transactions
      ),
      body: state.transfers == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.transfers!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.transfers!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          TransactionData data = state.transfers!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
              tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
              collapsedIconColor: AppColor.iconColor,
              iconColor: AppColor.iconColor,
              title: Row(
                children: [
                  Expanded(child: Text(data.txnid ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),)),
                  Text(data.amount ?? '0',style: appTheme(context).textTheme.bodyMedium!.copyWith(
                    color: data.profit!.toLowerCase() == 'minus' ? AppColor.red : AppColor.green
                  ),)
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
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).email,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.email ?? '',style: appTheme(context).textTheme.bodyMedium,)
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

