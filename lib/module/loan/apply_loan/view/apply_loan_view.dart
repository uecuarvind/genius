import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/divider_list.dart';
import 'package:genius_bank/Widgets/get_image.dart';
import 'package:genius_bank/Widgets/widget_validation.dart';
import 'package:genius_bank/module/loan/loan_plan/data/apply_loan.dart';
import 'package:genius_bank/utils/dimension.dart';

import '../../../../Widgets/default_appbar.dart';
import '../../../../Widgets/default_button.dart';
import '../../../../Widgets/default_textfield.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../bloc/apply_loan_bloc.dart';
import '../bloc/apply_loan_event.dart';
import '../bloc/apply_loan_state.dart';

class ApplyLoanPage extends StatelessWidget {
  ApplyLoanBloc? bloc;
  ApplyLoanState? state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ApplyLoanBloc()..add(InitEvent(context)),
      child: BlocBuilder<ApplyLoanBloc,ApplyLoanState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, ApplyLoanState state) {
    this.state ??= state;
    bloc ??= BlocProvider.of<ApplyLoanBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).apply_loan),
      body: Form(
        key: bloc!.formKey,
        child: mainView(context,state)
      ),
    );
  }

  Widget mainView(BuildContext context,ApplyLoanState state) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 16.r,right: 16.r),
      children: [
        16.verticalSpace,
        singleData(
          title: appLanguage(context).plan_title,
          data: state.loanData?.data?.title ?? '',
          context: context
        ),
        singleData(
          title: appLanguage(context).loan_amount,
          data: state.loanData?.data?.loanAmount ?? '',
          context: context
        ),
        singleData(
          title: appLanguage(context).total_installment,
          data: state.loanData?.data?.totalInstallment ?? '',
          context: context
        ),
        singleData(
          title: appLanguage(context).per_installment,
          data: state.loanData?.data?.perInstallment ?? '',
          context: context
        ),
        singleData(
          title: appLanguage(context).total_amount_to_pay,
          data: (state.loanData?.data?.totalAmountPay ?? 0).toString(),
          context: context
        ),
        16.verticalSpace,
        if(state.loanData != null)
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.loanData?.data?.dynamicFields?.fields?.length ?? 0,
            itemBuilder: (ctx,index){
              Fields field = state.loanData!.data!.dynamicFields!.fields![index];
              return field.isTextField! ? Container(
                margin: EdgeInsets.only(bottom: 10.r),
                child: DefaultTextField(
                    controller: field.controller!,
                    label: field.label!,
                    textInputType: getTextInputType(field.key!),
                    enableValidation: ! field.label!.toLowerCase().contains('optional')
                ),
              ) : filePicker(field,context,index);
            }
          ),
        10.verticalSpace,
        DefaultButton(
          onTap: ()=> bloc!.add(SubmitLoanRequest()),
          isLoading: state.loading,
          child: Text(appLanguage(context).submit,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor,fontWeight: Dimension.textMedium),)
        )
      ],
    );
  }

  Widget singleData({required String title,required String data,required BuildContext context}){
    return DividerList(
      padding: EdgeInsets.symmetric(vertical: 12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(title,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)),
          Text(data,style: appTheme(context).textTheme.bodyLarge!.copyWith(fontWeight: Dimension.textMedium),)
        ],
      ),
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

  Widget filePicker(Fields field, BuildContext context,int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.label ?? '',style: appTheme(context).textTheme.headlineMedium,),
          5.verticalSpace,
          WidgetValidation(
            validator: (text){
              if(field.data == null){
                return '${field.label ?? ''}${appLanguage(context).required}';
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
