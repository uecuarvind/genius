import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_button.dart';
import 'package:genius_bank/Widgets/default_textfield.dart';
import 'package:genius_bank/Widgets/phone_textfield.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/theme/app_color.dart';
import 'package:genius_bank/utils/dimension.dart';

import 'my_profile_bloc.dart';
import 'my_profile_event.dart';
import 'my_profile_state.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MyProfileBloc()..add(InitEvent()),
      child: BlocConsumer<MyProfileBloc, MyProfileState>(
        listener: (context, state) {},
        builder: (context, state) => Form(
          key: context.read<MyProfileBloc>().formKey,
          child: _buildPage(context, state),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, MyProfileState state) {
    final bloc = BlocProvider.of<MyProfileBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).my_profile,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        children: [
          30.verticalSpace,
          Text(
            appLanguage(context).personal_information,
            style: appTheme(context).textTheme.headlineMedium,
          ),
          20.verticalSpace,
          DefaultTextField(
            controller: bloc.name,
            label: appLanguage(context).name,
          ),
          20.verticalSpace,
          DefaultTextField(
            controller: bloc.email,
            label: appLanguage(context).email,
            enable: false,
          ),
          20.verticalSpace,
          PhoneTextField(
            controller: bloc.phoneController,
            label: appLanguage(context).phone_number,
          ),
          20.verticalSpace,
          DefaultTextField(
            controller: bloc.fax,
            label: appLanguage(context).fax,
          ),
          20.verticalSpace,
          DefaultTextField(
            controller: bloc.city,
            label: appLanguage().city,
          ),
          20.verticalSpace,
          DefaultTextField(
            controller: bloc.country,
            label: appLanguage().country,
          ),
          20.verticalSpace,
          DefaultTextField(
            controller: bloc.address,
            label: appLanguage().address,
          ),
          20.verticalSpace,
          DefaultButton(
            backgroundColor: AppColor.background,
            borderColor: AppColor.primary,
            buttonType: ButtonType.BORDER,
            onTap: () {
              goToPage(Routes.CHANGE_PASSWORD);
            },
            child: Text(
              appLanguage().change_password,
              style: appTheme().textTheme.headlineMedium!.copyWith(color: AppColor.primary),
            ),
          ),
          20.verticalSpace,
          DefaultButton(
            isLoading: bloc.state.pageState == PageState.Loading,
            onTap: () => bloc.add(SubmitEvent()),
            child: Text(
              appLanguage().save_change,
              style: appTheme().textTheme.headlineMedium!.copyWith(color: AppColor.buttonTextColor),
            ),
          ),
          Dimension.bottomSpace
        ],
      ),
    );
  }
}
