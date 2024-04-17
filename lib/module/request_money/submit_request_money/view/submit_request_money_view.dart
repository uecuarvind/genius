import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/main.dart';

import '../../../../Widgets/default_button.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/submit_request_money_bloc.dart';
import '../bloc/submit_request_money_event.dart';
import '../bloc/submit_request_money_state.dart';

class SubmitRequestMoneyPage extends StatefulWidget {
  @override
  State<SubmitRequestMoneyPage> createState() => _SubmitRequestMoneyPageState();
}

class _SubmitRequestMoneyPageState extends State<SubmitRequestMoneyPage> with SingleTickerProviderStateMixin{
  SubmitRequestMoneyBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SubmitRequestMoneyBloc()..add(InitEvent(this)),
      child: BlocBuilder<SubmitRequestMoneyBloc,SubmitRequestMoneyState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, SubmitRequestMoneyState state) {
    bloc ??= BlocProvider.of<SubmitRequestMoneyBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).request_money,
      ),
      body: Form(
        key: bloc!.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          children: [
            16.verticalSpace,
            DefaultTextField(
              controller: bloc!.accountNo,
              label: appLanguage(context).account_number,
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
            DefaultTextField(
              controller: bloc!.details,
              label: appLanguage(context).details,
              maxLine: 5,
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
      )
    );
  }
}

