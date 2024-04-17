import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../theme/app_color.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../routes/app_pages.dart';
import '../bloc/others_banks_bloc.dart';
import '../bloc/others_banks_event.dart';
import '../bloc/others_banks_state.dart';
import '../data/others_bank.dart';

class OthersBanksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OthersBanksBloc()..add(InitEvent()),
      child: BlocBuilder<OthersBanksBloc,OthersBanksState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, OthersBanksState state) {
    final bloc = BlocProvider.of<OthersBanksBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).other_bank_transfer
      ),
      body: state.listData == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.listData!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.listData!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          BankData data = state.listData!.data![index];
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
                  DefaultButton(
                    onTap: ()=> goToPage(Routes.OTHERS_BANK_TRANSFER,arguments: data),
                    padding: EdgeInsets.symmetric(vertical: 4.r,horizontal: 8.r),
                    borderRadius: 2.r,
                    child: Text(appLanguage(context).send,style: appTheme(context).textTheme.bodyMedium!.copyWith(color: AppColor.buttonTextColor,height: 1.4),)
                  )
                ],
              ),
              subtitle: Text(data.nickName ?? '',style: appTheme(context).textTheme.bodyMedium!.copyWith(color: AppColor.grey),),
              children: [
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).account_number,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.accountNumber ?? '',style: appTheme(context).textTheme.bodyMedium,)
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(appLanguage(context).account_name,style: appTheme(context).textTheme.headlineSmall,)),
                    Text(data.accountName ?? '',style: appTheme(context).textTheme.bodyMedium,)
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

