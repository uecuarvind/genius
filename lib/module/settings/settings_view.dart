import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/message_dialog.dart';
import 'package:genius_bank/app_helper/extensions.dart';
import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/controllers/app_controller/bloc/app_controller_event.dart';
import 'package:genius_bank/controllers/app_controller/data/languages.dart';
import 'package:genius_bank/controllers/share_helper.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/theme/app_color.dart';
import 'package:genius_bank/utils/dimension.dart';

import '../../gen/assets.gen.dart';
import '../../utils/url.dart';
import 'settings_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsPage extends StatelessWidget {
  SettingsBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsBloc()..add(InitEvent(context)),
      child: BlocBuilder<SettingsBloc,SettingsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, SettingsState state) {
    bloc ??= BlocProvider.of<SettingsBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).settings),
      body: mainView(context),
    );
  }

  Widget mainView(BuildContext context){
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              sections(
                icon: Assets.icons.accountSetting.keyName,
                title: appLanguage().account_setting,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => goToPage(Routes.CHANGE_PASSWORD),
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Text(appLanguage().change_password,style: appTheme().textTheme.bodyLarge,)),
                            Icon(Icons.arrow_forward_ios,color: AppColor.iconColor,size: 14.r,)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              sections(
                icon: Assets.icons.systemSetting.keyName,
                title: appLanguage().system_setting,
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(appLanguage().change_language,style: appTheme().textTheme.bodyLarge,),
                      collapsedIconColor: AppColor.iconColor,
                      iconColor: AppColor.iconColor,
                      children: Languages.languages.asMap().map((key, value) => MapEntry(key,
                        ListTile(
                          onTap: ()=> bloc!.appController!.add(ChangeLanguage(value.locale)),
                          title: Text(value.name,style: appTheme().textTheme.bodyLarge,),
                          leading: ClipOval(
                            child: Image.asset(value.flag,height: 30.r,width: 30.r,fit: BoxFit.cover,),
                          ),
                          trailing: Visibility(
                            visible: bloc!.appController!=null && bloc!.appController!.state.locale == value.locale,
                            child: Icon(Icons.check_circle,color: AppColor.green,),
                          ),
                        )
                      )).values.toList(),
                    ),
                    ExpansionTile(
                      title: Text(appLanguage().theme,style: appTheme().textTheme.bodyLarge,),
                      collapsedIconColor: AppColor.iconColor,
                      iconColor: AppColor.iconColor,
                      children: appLanguage().theme_data.toList.asMap().map((key, value) => MapEntry(key,
                        ListTile(
                          onTap: ()=> bloc!.appController!.add(ChangeTheme()),
                          title: Text(value,style: appTheme().textTheme.bodyLarge,),
                          contentPadding: REdgeInsets.symmetric(horizontal: 16).copyWith(left: 32),
                          trailing: Visibility(
                            visible: ShareHelper.getTheme() == value.toLowerCase(),
                            child: Icon(Icons.check_circle,color: AppColor.green,),
                          ),
                        )
                      )).values.toList(),
                    ),
                  ],
                )
              ),
              sections(
                icon: Assets.icons.legalsSupport.keyName,
                title: appLanguage().legals_support,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: ()=> goToPage(Routes.BLOGS),
                        child: Container(
                          width: 1.sw,
                          padding: EdgeInsets.all(16.r),
                          child: Text(appLanguage().blog,style: appTheme().textTheme.bodyLarge,),
                        )
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        width: 1.sw,
                        padding: EdgeInsets.all(16.r),
                        child: Text(appLanguage().terms_and_condition,style: appTheme().textTheme.bodyLarge,),
                      )
                    ),
                    InkWell(
                      onTap: ()=> Helper.goBrowser(URL.privacyUrl),
                      child: Container(
                        width: 1.sw,
                        padding: EdgeInsets.all(16.r),
                        child: Text(appLanguage().privacy_policy,style: appTheme().textTheme.bodyLarge,),
                      )
                    ),
                    InkWell(
                      onTap: ()=> Helper.goBrowser(URL.aboutUs),
                      child: Container(
                        width: 1.sw,
                        padding: EdgeInsets.all(16.r),
                        child: Text(appLanguage().about_us,style: appTheme().textTheme.bodyLarge,),
                      )
                    ),
                    InkWell(
                      onTap: ()=> goToPage(Routes.CONTACT_US),
                      child: Container(
                        width: 1.sw,
                        padding: EdgeInsets.all(16.r),
                        child: Text(appLanguage().contact_us,style: appTheme().textTheme.bodyLarge,),
                      )
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            onTap: ()=> logoutDialog(),
            leading: SvgPicture.asset(Assets.icons.logout,color: AppColor.iconColor,height: 24.r,),
            title: Text(appLanguage(context).logout,style: appTheme(context).textTheme.headlineLarge,),
          ),
        )
      ],
    );
  }

  Widget sections({required String icon, required String title, required Widget child}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.r,right: 16.r,bottom: 18.r,top: 30.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(icon,height: 20.r,width: 20.r,color: AppColor.iconColor,),
              SizedBox(width: 16.r,),
              Expanded(child: Text(title,style: appTheme().textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textSemiBold),))
            ],
          ),
        ),
        Divider(thickness: 1,height: 1,color: AppColor.dividerColor,),
        child
      ],
    );
  }

  void logoutDialog(){
    MessageDialog(
      title: appLanguage().logout,
      message: appLanguage().are_you_sure_you_want_to_logout,
      isConfirmDialog: true,
      onTap: (state){
        backPage();
        if(state){
          ShareHelper.logOut();
        }
      }
    );
  }
}

