import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/transfer/send_money/data/save_accounts.dart';

import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/network_image.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/send_money_bloc.dart';
import '../bloc/send_money_event.dart';
import '../bloc/send_money_state.dart';

class SendMoneyPage extends StatefulWidget {
  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> with SingleTickerProviderStateMixin{
  SendMoneyBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SendMoneyBloc()..add(InitEvent(this)),
      child: BlocBuilder<SendMoneyBloc,SendMoneyState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, SendMoneyState state) {
    bloc ??= BlocProvider.of<SendMoneyBloc>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: DefaultAppbar(
          title: appLanguage(context).send_money,
          bottom: TabBar(
            controller: bloc!.tabController,
            labelStyle: appTheme(context).textTheme.bodyLarge!.copyWith(
              fontWeight: Dimension.textMedium,
            ),
            labelColor: AppColor.primary,
            unselectedLabelColor: AppColor.textColor,
            indicatorColor: AppColor.primary,
            tabs: [
              Tab(
                text: appLanguage(context).others_bank,
              ),
              Tab(
                text: appLanguage(context).saved_account,
              ),
            ],
          )
        ),
        body: TabBarView(
          controller: bloc!.tabController,
          children: [
            Form(
              key: bloc!.formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                children: [
                  16.verticalSpace,
                  DefaultTextField(
                    controller: bloc!.accountNo,
                    label: appLanguage(context).account_number,
                    textInputType: TextInputType.number,
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
                    child: Text(appLanguage(context).submit,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textMedium),)
                  ),
                  32.verticalSpace
                ],
              ),
            ),
            accountListView(state,context)
          ],
        )
      ),
    );
  }

  Widget accountListView(SendMoneyState state, BuildContext context){
    return state.bankList != null || state.pageState == PageState.Success ?
    ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: state.bankList!.data!.length,
      itemBuilder: (ctx,index){
        AccountData account = state.bankList!.data![index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
          child: ListTile(
            onTap: ()=> bloc!.add(SelectMethod(account)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.r),
            leading: ClipOval(
              child: CachedImage(
                imageUrl: account.photo ?? '',
                height: 34.r,
                width: 34.r,
              ),
            ),
            title: Text(account.name!,style: appTheme(context).textTheme.headlineMedium,),
            subtitle: Text(account.accNo!,style: appTheme(context).textTheme.bodyMedium!.copyWith(
                color: AppColor.grey
            ),),
          ),
        );
      },
    ) : CircularProgress(height: 24.r);
  }
}

