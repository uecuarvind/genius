import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/withdraw/add_withdraw/data/methods.dart';

import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/dropdown_theme.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/add_withdraw_bloc.dart';
import '../bloc/add_withdraw_event.dart';
import '../bloc/add_withdraw_state.dart';

class AddWithdrawPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddWithdrawBloc()..add(InitEvent()),
      child: BlocBuilder<AddWithdrawBloc,AddWithdrawState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AddWithdrawState state) {
    final bloc = BlocProvider.of<AddWithdrawBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).withdraw
      ),
      body: Form(
        key: bloc.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          children: [
            16.verticalSpace,
            state.methods != null || state.pageState == PageState.Success ?
            DropdownTheme(
              child: DropdownSearch<MethodData>(
                popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    menuProps: MenuProps(
                        backgroundColor: AppColor.cardColor
                    )
                ),
                itemAsString: (MethodData data)=> data.method!,
                compareFn: (data,data2)=>data.id == data2.id,
                items: state.methods!.data!,
                dropdownDecoratorProps: dropdownDecoration(
                  label: appLanguage(context).withdraw_method,
                  hint: appLanguage(context).select_bank,
                ),
                onChanged: (data)=>bloc.add(SelectMethod(data!)),
                validator: (data){
                  if(data == null){
                    return '${appLanguage(context).withdraw_method}${appLanguage(context).required}';
                  }
                  return null;
                },
              ),
            ) : CircularProgress(height: 24.r),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc.amount,
              label: appLanguage(context).amount,
              textInputType: const TextInputType.numberWithOptions(decimal: true,),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ]
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc.description,
              label: appLanguage(context).description,
              maxLine: 5,
            ),
            8.verticalSpace,
            DefaultButton(
              onTap: ()=> bloc.add(SubmitTransfer()),
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

