import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/main.dart';

import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/divider_list.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/others_bank_transfer_bloc.dart';
import '../bloc/others_bank_transfer_event.dart';
import '../bloc/others_bank_transfer_state.dart';

class OthersBankTransferPage extends StatelessWidget {
  OthersBankTransferBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OthersBankTransferBloc()..add(InitEvent(context)),
      child: BlocBuilder<OthersBankTransferBloc,OthersBankTransferState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, OthersBankTransferState state) {
    bloc ??= BlocProvider.of<OthersBankTransferBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).other_bank_transfer,
      ),
      body: Form(
        key: bloc!.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          children: [
            16.verticalSpace,
            state.bankDetails!=null ?
            Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: REdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    singleData(title: appLanguage(context).maximum_amount,data: state.bankDetails?.data?.maxAmount ?? '',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).minimum_amount,data: state.bankDetails?.data?.minAmount ?? '',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).daily_amount_limit,data: state.bankDetails?.data?.dailyAmountLimit ?? '',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).daily_monthly_limit,data: state.bankDetails?.data?.monthlyAmountLimit ?? '',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).daily_limit,data: state.bankDetails?.data?.dailyTotalTransaction ?? '',context: context),
                    8.verticalSpace,
                    singleData(title: appLanguage(context).monthly_limit,data: state.bankDetails?.data?.monthlyTotalTransaction ?? '',context: context),
                  ],
                ),
              ),
            ) : CircularProgress(height: 60.h),
            16.verticalSpace,
            DefaultTextField(
              controller: bloc!.bankName,
              label: appLanguage(context).bank,
              enable: false,
            ),
            16.verticalSpace,
            DefaultTextField(
              controller: bloc!.accountNo,
              label: appLanguage(context).account_number,
              enable: false,
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc!.accountName,
              label: appLanguage(context).account_name,
              enable: false,
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc!.amount,
              label: appLanguage(context).amount,
              textInputType: const TextInputType.numberWithOptions(decimal: true,),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ]
            ),
            8.verticalSpace,
            DefaultButton(
              onTap: ()=> bloc!.add(SubmitTransfer()),
              isLoading: state.loading,
              enable: state.bankDetails!=null,
              child: Text(appLanguage(context).submit,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textMedium),)
            ),
            32.verticalSpace
          ],
        ),
      )
    );
  }

  Widget singleData({required String title,required String data,required BuildContext context}){
    return DividerList(
      padding: EdgeInsets.only(bottom: 8.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(title,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)),
          Text(data,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)
        ],
      ),
    );
  }
}

