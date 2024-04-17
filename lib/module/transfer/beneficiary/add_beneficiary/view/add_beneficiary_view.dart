import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/Widgets/dropdown_theme.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';

import '../../../../../Widgets/default_button.dart';
import '../../../../../Widgets/get_image.dart';
import '../../../../../Widgets/widget_validation.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../theme/app_color.dart';
import '../../../../../utils/dimension.dart';
import '../bloc/add_beneficiary_bloc.dart';
import '../bloc/add_beneficiary_event.dart';
import '../bloc/add_beneficiary_state.dart';
import '../data/others_bank.dart';

class AddBeneficiaryPage extends StatelessWidget {
  AddBeneficiaryBloc? bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddBeneficiaryBloc()..add(InitEvent()),
      child: BlocBuilder<AddBeneficiaryBloc,AddBeneficiaryState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, AddBeneficiaryState state) {
    bloc ??= BlocProvider.of<AddBeneficiaryBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).add_beneficiaries
      ),
      body: Form(
        key: bloc!.formKey,
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
                    backgroundColor: AppColor.cardColor,
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
                onChanged: (data)=>bloc!.add(SelectBank(data!)),
              ),
            ) : CircularProgress(height: 24.r),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc!.accountName,
              label: appLanguage(context).account_name,
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc!.accountNumber,
              label: appLanguage(context).account_number,
              textInputType: TextInputType.number
            ),
            8.verticalSpace,
            DefaultTextField(
              controller: bloc!.nickName,
              label: appLanguage(context).nick_name,
            ),
            8.verticalSpace,
            if(state.selectBank!=null)
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.selectBank?.dynamicFields?.length ?? 0,
                  itemBuilder: (ctx,index){
                    DynamicFields field = state.selectBank!.dynamicFields![index];
                    return field.type!.toLowerCase() != 'file' ? Container(
                      margin: EdgeInsets.only(bottom: 10.r),
                      child: DefaultTextField(
                          controller: field.controller!,
                          label: field.fieldName,
                          textInputType: getTextInputType(field.type!),
                          enableValidation: ! field.fieldName!.toLowerCase().contains('optional')
                      ),
                    ) : filePicker(field,context,index);
                  }
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

  TextInputType getTextInputType(String type) {
    switch(type.toLowerCase()){
      case 'text' :
        return TextInputType.text;
      case 'textarea' :
        return TextInputType.text;
      case 'number':
        return TextInputType.number;
      default :
        return TextInputType.text;
    }
  }

  Widget filePicker(DynamicFields field, BuildContext context,int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.fieldName ?? '',style: appTheme(context).textTheme.headlineMedium,),
          5.verticalSpace,
          WidgetValidation(
            validator: (text){
              if(field.data == null){
                return '${field.fieldName ?? ''}${appLanguage(context).required}';
              }
              return null;
            },
            borderRadius: 5.r,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.textFieldBackground,
                  borderRadius: BorderRadius.circular(5.r)
              ),
              padding: EdgeInsets.all(10.r),
              child: Row(
                children: [
                  Expanded(
                    child: field.data!=null ? Image.file(field.data,height: 100.h,width: 100.h,) :
                    Assets.images.empty.image(height: 100.h,width: 100.h,),
                  ),
                  IconButton(
                      onPressed: () async {
                        var image = await getImage();
                        if(image!=null){
                          bloc!.add(AddFile(image,index));
                        }
                      },
                      icon: Icon(Icons.camera_alt,color: AppColor.iconColor,)
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

