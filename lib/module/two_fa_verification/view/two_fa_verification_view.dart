import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_button.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/two_fa_verification/view/code_verify.dart';
import 'package:genius_bank/utils/url.dart';

import '../../../Widgets/default_dialog.dart';
import '../../../app_helper/helper.dart';
import '../../../theme/app_color.dart';
import '../../../utils/dimension.dart';
import '../bloc/two_fa_verification_bloc.dart';
import '../bloc/two_fa_verification_event.dart';
import '../bloc/two_fa_verification_state.dart';

class TwoFAVerificationPage extends StatelessWidget {
  TwoFAVerificationBloc? bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TwoFAVerificationBloc()..add(InitEvent()),
      child: BlocBuilder<TwoFAVerificationBloc,TwoFAVerificationState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, TwoFAVerificationState state) {
    bloc ??= BlocProvider.of<TwoFAVerificationBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).two_fa_security),
      body: state.pageState==PageState.Success ? Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2)
            ),
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: Container(
              padding: REdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appLanguage(context).setup_key,style: appTheme(context).textTheme.bodyMedium,),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.textFieldBackground,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical:8.r,horizontal: 16.r).copyWith(right: 4.r),
                    margin: EdgeInsets.only(top: 8.r),
                    child: Row(
                      children: [
                        Expanded(child: Text(state.faData?.data?.secret ?? '',style: appTheme(context).textTheme.bodyMedium,)),
                        16.horizontalSpace,
                        InkWell(
                          onTap: ()=> Helper.copyText(state.faData?.data?.secret ?? ''),
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: const BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.copy,color: AppColor.buttonTextColor,size: 18.r,),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: REdgeInsets.all(16),
            child: HtmlWidget(state.faData!.data!.qrPhoto!),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: DefaultButton(
              onTap: ()=> verifyDialog(context: context),
              buttonType: ButtonType.BORDER,
              borderColor: AppColor.grey,
              child: Text(state.user.twofa != "1" ? appLanguage(context).enable_two_factor_authenticator : appLanguage(context).disable_two_factor_authenticator,style: appTheme(context).textTheme.headlineMedium!.copyWith(fontWeight: Dimension.textMedium))
            ),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
            child: DefaultButton(
              onTap: ()=> Helper.goBrowser(Platform.isAndroid ? URL.googleAuthenticatorAppLinkAndroid : URL.googleAuthenticatorAppLinkIos),
              buttonType: ButtonType.BORDER,
              borderColor: AppColor.grey,
              child: Text(appLanguage(context).download_app.toUpperCase(),style: appTheme(context).textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textMedium))
            ),
          ),
        ],
      ) : CircularProgress(height: 1.sh),
    );
  }

  void verifyDialog({required BuildContext context}){
    showDialog(
        context: context,
        builder: (ctx){
          return DefaultDialog(
            title: appLanguage(context).verify_your_otp,
            child: CodeVerify(bloc!),
          );
        }
    );
  }
}

