import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_button.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/validator.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/theme/app_color.dart';

import '../../../gen/assets.gen.dart';
import '../bloc/reset_password_bloc.dart';
import '../bloc/reset_password_event.dart';
import '../bloc/reset_password_state.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ResetPasswordBloc()..add(InitEvent()),
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {},
        builder: (context, state) => _buildPage(context, state),
      ),
    );
  }

  Widget _buildPage(BuildContext context, ResetPasswordState state) {
    final bloc = BlocProvider.of<ResetPasswordBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).reset_password,
        onBack: bloc.back
      ),
      body: WillPopScope(
        onWillPop: bloc.back,
        child: Form(
          key: bloc.formKey,
          child: ListView(
            padding: EdgeInsets.all(16.r),
            children: [
              Column(
                children: [
                  23.verticalSpace,
                  SvgPicture.asset(
                    Assets.icons.changePassword,
                    height: 84.r,
                    width: 70.r,
                    color: AppColor.primary,
                  ),
                  26.verticalSpace,
                  state.resetPassword == null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${appLanguage(context).forgot_your_password}?",
                        style: appTheme(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 24.sm,
                          color: AppColor.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      15.verticalSpace,
                      Text(
                        appLanguage(context).reset_password_view_msg,
                        style: appTheme(context).textTheme.bodyLarge!.copyWith(
                          color: AppColor.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      25.verticalSpace,
                      DefaultTextField(
                        controller: bloc.emailController,
                        label: appLanguage().email,
                        labelAsTitle: true,
                        validator: Validator.emailValidator,
                        textAlign: TextAlign.center
                      ),
                    ],
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextField(
                          controller: bloc.code,
                          backgroundColor: AppColor.textFieldBackground,
                          label: appLanguage(context).verification_code,
                      ),
                      15.verticalSpace,
                      DefaultTextField(
                          controller: bloc.password,
                          backgroundColor: AppColor.textFieldBackground,
                          label: appLanguage(context).new_password,
                          obscureText: true
                      ),
                      15.verticalSpace,
                      DefaultTextField(
                        controller: bloc.conPassword,
                        backgroundColor: AppColor.textFieldBackground,
                        label: appLanguage(context).confirm_new_password,
                        obscureText: true,
                        validator: (value){
                          if (value== null || value.isEmpty) {
                            return '${appLanguage().confirm_new_password}${appLanguage().required}';
                          } else if(bloc.conPassword.text != bloc.password.text) {
                            return appLanguage().new_password_and_confirm_password_are_not_same;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  DefaultButton(
                    isLoading: state.pageState == PageState.Loading,
                    onTap: () {
                      bloc.add(state.resetPassword==null ? ResetEvent() : ResetSubmitEvent());
                    },
                    child: Text(
                      state.resetPassword==null ? appLanguage().reset_password : appLanguage().change_password,
                      style: appTheme().textTheme.button!.copyWith(color: AppColor.buttonTextColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
