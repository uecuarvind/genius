import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/routes/app_pages.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../theme/app_color.dart';
import '../bloc/beneficiary_list_bloc.dart';
import '../bloc/beneficiary_list_event.dart';
import '../bloc/beneficiary_list_state.dart';
import '../data/beneficiary_list.dart';

class BeneficiaryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BeneficiaryListBloc()..add(InitEvent()),
      child: BlocBuilder<BeneficiaryListBloc,BeneficiaryListState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, BeneficiaryListState state) {
    final bloc = BlocProvider.of<BeneficiaryListBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).beneficiary_manage
      ),
      body: state.listData == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.listData!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.listData!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          BeneficiaryData data = state.listData!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
              tilePadding: EdgeInsets.only(left: 16.r,right: 8.r),
              collapsedIconColor: AppColor.iconColor,
              iconColor: AppColor.iconColor,
              title: Text(data.bankName ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),),
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: ()=> goToPage(Routes.ADD_BENEFICIARY),
          icon: Icon(Icons.add,color: AppColor.buttonTextColor,),
          backgroundColor: AppColor.primary,
          label: Text(appLanguage(context).add_beneficiaries,style: appTheme(context).textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),)
      ),
    );
  }
}

