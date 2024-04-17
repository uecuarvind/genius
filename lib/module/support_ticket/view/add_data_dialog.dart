import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/module/support_ticket/bloc/tickets_bloc.dart';
import 'package:genius_bank/module/support_ticket/bloc/tickets_state.dart';

import '../../../Widgets/default_button.dart';
import '../../../Widgets/default_textfield.dart';
import '../../../main.dart';
import '../../../theme/app_color.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/dimension.dart';
import '../bloc/tickets_event.dart';

class AddDataDialog extends StatelessWidget {

  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey();

  TicketsBloc bloc;
  AddDataDialog(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsBloc, TicketsState>(
      bloc: bloc,
      builder: (context, state) {
        return Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              DefaultTextField(
                controller: subject,
                label: appLanguage(context).subject
              ),
              16.verticalSpace,
              DefaultTextField(
                controller: message,
                label: appLanguage(context).message
              ),
              16.verticalSpace,
              DefaultButton(
                isLoading: state.newDataDialogLoading,
                onTap: (){
                  if(formKey.currentState!.validate()){
                    bloc.add(SendNewDataEvent(
                        {
                          AppConstant.subject: subject.text,
                          AppConstant.message: message.text,
                        }
                    ));
                  }
                },
                child: Text(appLanguage(context).send_message,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor),),
              ),
              Dimension.bottomSpace
            ],
          ),
        );
      },
    );
  }
}
