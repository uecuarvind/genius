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
import 'package:genius_bank/module/wire_transfer/add_wire_transfer/data/available_bank.dart';

import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/dropdown_theme.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/dimension.dart';
import '../bloc/add_wire_transfer_bloc.dart';
import '../bloc/add_wire_transfer_event.dart';
import '../bloc/add_wire_transfer_state.dart';

class AddWireTransferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddWireTransferBloc()..add(InitEvent()),
      child: BlocBuilder<AddWireTransferBloc,AddWireTransferState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AddWireTransferState state) {
    final bloc = BlocProvider.of<AddWireTransferBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).wire_transfer
      ),
      body: Form(
        key: bloc.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          children: [
            16.verticalSpace,
            state.availableBank != null || state.pageState == PageState.Success ?
            DropdownTheme(
              child: DropdownSearch<BankData>(
                popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    menuProps: MenuProps(
                        backgroundColor: AppColor.cardColor
                    )
                ),
                itemAsString: (BankData data)=> data.title!,
                compareFn: (data,data2)=>data.id == data2.id,
                items: state.availableBank!.data!,
                dropdownDecoratorProps: dropdownDecoration(
                  label: appLanguage(context).bank,
                  hint: appLanguage(context).select_bank,
                ),
                validator: (data){
                  if(data == null){
                    return '${appLanguage(context).bank}${appLanguage(context).required}';
                  }
                  return null;
                },
                onChanged: (data)=>bloc.add(SelectBank(data!)),
              ),
            ) : CircularProgress(height: 24.r),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc.swiftCode,
              label: appLanguage(context).swift_code,
              enable: false,
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc.currency,
              label: appLanguage(context).currency,
              enable: false,
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc.routingNumber,
              label: appLanguage(context).routing_number,
              enable: false,
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc.country,
              label: appLanguage(context).country,
              enable: false,
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc.accountNumber,
              label: appLanguage(context).account_number,
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc.accountName,
              label: appLanguage(context).account_holder_number,
            ),
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
              controller: bloc.note,
              label: appLanguage(context).note,
              enableValidation: false,
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

