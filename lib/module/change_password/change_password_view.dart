import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_button.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/theme/app_color.dart';

import 'change_password_bloc.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangePasswordBloc()..add(InitEvent()),
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {},
        builder: (context, state) => Form(
          key: context.read<ChangePasswordBloc>().formKey,
          child: _buildPage(context, state)),
        ),
    );
  }

  Widget _buildPage(BuildContext context, ChangePasswordState state) {
    final bloc = BlocProvider.of<ChangePasswordBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).password,
        haveLeading: true,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        children: [
          30.verticalSpace,
          Text(
            appLanguage(context).change_password,
            style: appTheme(context).textTheme.headlineMedium,
          ),
          20.verticalSpace,
          DefaultTextField(
            controller: bloc.oldPasswordController,
            backgroundColor: AppColor.textFieldBackground,
            label: appLanguage(context).old_password,
            obscureText: true
          ),
          15.verticalSpace,
          DefaultTextField(
            controller: bloc.newPasswordController,
            backgroundColor: AppColor.textFieldBackground,
            label: appLanguage(context).new_password,
            obscureText: true
          ),
          15.verticalSpace,
          DefaultTextField(
            controller: bloc.conNewPasswordController,
            backgroundColor: AppColor.textFieldBackground,
            label: appLanguage(context).confirm_new_password,
            obscureText: true,
            validator: (value){
              if (value== null || value.isEmpty) {
                return '${appLanguage().confirm_new_password}${appLanguage().required}';
              } else if(bloc.conNewPasswordController.text != bloc.newPasswordController.text) {
                return appLanguage().new_password_and_confirm_password_are_not_same;
              } else {
                return null;
              }
            },
          ),
          30.verticalSpace,
          DefaultButton(
            isLoading: bloc.state.pageState == PageState.Loading,
            onTap: () =>bloc.add(SubmitEvent()),
            child: Text(
              appLanguage().change_password,
              style: appTheme().textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
