import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/app_background.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_button.dart';
import 'package:genius_bank/Widgets/network_image.dart';
import 'package:genius_bank/Widgets/swipe_refresh.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/custom_icons/my_flutter_app_icons.dart' as CustomIcons;
import 'package:genius_bank/data/currencies.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/main_page/data/drawer_tab.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/theme/app_color.dart';
import 'package:genius_bank/utils/dimension.dart';

import '../../../Widgets/default_textfield.dart';
import '../../../Widgets/dropdown_theme.dart';
import '../../../gen/assets.gen.dart';
import '../bloc/main_page_bloc.dart';
import '../bloc/main_page_event.dart';
import '../bloc/main_page_state.dart';
import '../data/dashboard.dart';

class MainPage extends StatelessWidget {
  MainPageBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainPageBloc()..add(InitEvent()),
      child: BlocBuilder<MainPageBloc,MainPageState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, MainPageState state) {
    bloc ??= BlocProvider.of<MainPageBloc>(context);

    return Scaffold(
      key: bloc!.scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Assets.banner.image(height: 24.r,color: AppColor.logoColor),
          ],
        ),
        leadingWidth: 40.r,
       /* actions: [
          currencyView(state,context),
          16.horizontalSpace
        ],*/
      ),
      drawer: drawerView(context,state),
      body: AppBackground(
        child: SwipeRefresh(
          controller: bloc!.refreshController,
          onRefresh: ()=>bloc!.add(InitEvent()),
          child: state.pageState == PageState.Loading ? CircularProgress(height: 1.sh) :
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              if(state.user!.kycStatus != '1')
                Card(
                  margin: EdgeInsets.all(16.r).copyWith(bottom: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)
                  ),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    child: Row(
                      children: [
                        Expanded(child: Text(appLanguage(context).kyc_info_needed,style: appTheme(context).textTheme.bodyMedium,)),
                        16.horizontalSpace,
                        DefaultButton(
                            onTap: () async {
                              await goToPage(Routes.KYC_VERIFICATION);
                              bloc!.add(UpdateUser());
                            },
                            padding: EdgeInsets.symmetric(horizontal: 16.r,vertical: 8.r),
                            borderRadius: 3.r,
                            child: Text(appLanguage(context).submit,style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.buttonTextColor),)
                        )
                      ],
                    ),
                  ),
                ),
              Card(
                margin: EdgeInsets.all(16.r).copyWith(bottom: 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)
                ),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  child: Row(
                    children: [
                      Expanded(child: Text(appLanguage(context).kyc_info_needed,style: appTheme(context).textTheme.bodyMedium,)),
                      16.horizontalSpace,
                      DefaultButton(
                          onTap: () async {
                            await goToPage(Routes.KYC_VERIFICATION_New);
                            //bloc!.add(UpdateUser());
                          },
                          padding: EdgeInsets.symmetric(horizontal: 16.r,vertical: 8.r),
                          borderRadius: 3.r,
                          child: Text(appLanguage(context).submit,style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.buttonTextColor),)
                      )
                    ],
                  ),
                ),
              ),
              singleSection(
                  title: appLanguage(context).account_number.toUpperCase(),
                  data: state.dashboard?.data?.accountNumber ?? '',
                  color: const Color(0xFFff8500),
                  icon: Icons.wallet,
                  tileButton: IconButton(
                      onPressed: ()=> Helper.copyText(state.dashboard?.data?.accountNumber ?? ''),
                      icon: Icon(Icons.copy,color: AppColor.grey,)
                  )
              ),
              singleSection(
                  title: appLanguage(context).available_balance.toUpperCase(),
                  data: state.dashboard?.data?.availableBalance ?? '',
                  color: const Color(0xFF92278f),
                  icon: CustomIcons.MyFlutterApp.balance,
                  iconSize: 18.r
              ),
              GridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 2.5,
                children: [
                  singleSection(
                      title: appLanguage(context).deposit.toUpperCase(),
                      data: (state.dashboard?.data?.deposits ?? 0).toString(),
                      color: const Color(0xFF8dc63f),
                      icon: CustomIcons.MyFlutterApp.deposit,
                      iconSize: 18.r,
                      isSwitched: true,
                      padding: EdgeInsets.only(top: 8.r,left: 6.r, right: 4.r)
                  ),
                  singleSection(
                      title: appLanguage(context).withdraw.toUpperCase(),
                      data: (state.dashboard?.data?.withdraws ?? 0).toString(),
                      color: const Color(0xFFd63939),
                      icon: Icons.attach_money,
                      isSwitched: true,
                      padding: EdgeInsets.only(top: 8.r,left: 4.r, right: 6.r)
                  ),
                  singleSection(
                      title: appLanguage(context).transactions.toUpperCase(),
                      data: (state.dashboard?.data?.transactions?.length ?? 0).toString(),
                      color: const Color(0xFF00bfff),
                      icon: CustomIcons.MyFlutterApp.transaction,
                      iconSize: 18.r,
                      isSwitched: true,
                      padding: EdgeInsets.only(top: 8.r,left: 6.r, right: 4.r)
                  ),
                  singleSection(
                      title: appLanguage(context).loan.toUpperCase(),
                      data: (state.dashboard?.data?.loans ?? 0).toString(),
                      color: const Color(0xFFff8500),
                      icon: CustomIcons.MyFlutterApp.loan,
                      iconSize: 18.r,
                      isSwitched: true,
                      padding: EdgeInsets.only(top: 8.r,left: 4.r, right: 6.r)
                  ),
                  singleSection(
                      title: appLanguage(context).dps.toUpperCase(),
                      data: (state.dashboard?.data?.dps ?? 0).toString(),
                      color: const Color(0xFF92278f),
                      icon: Icons.wallet,
                      isSwitched: true,
                      padding: EdgeInsets.only(top: 8.r,left: 6.r, right: 4.r,bottom: 8.r)
                  ),
                  singleSection(
                      title: appLanguage(context).fdr.toUpperCase(),
                      data: (state.dashboard?.data?.fdr ?? 0).toString(),
                      color: const Color(0xFF2fb344),
                      icon: CustomIcons.MyFlutterApp.fds,
                      iconSize: 18.r,
                      isSwitched: true,
                      padding: EdgeInsets.symmetric(vertical: 8.r).copyWith(left: 4.r, right: 6.r)
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)
                ),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appLanguage(context).your_referral_link,style: appTheme(context).textTheme.bodyMedium,),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.textFieldBackground,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical:8.r,horizontal: 16.r).copyWith(right: 4.r),
                        margin: EdgeInsets.only(top: 8.r),
                        child: Row(
                          children: [
                            Expanded(child: Text(state.dashboard?.data?.referralLink ?? '',style: appTheme(context).textTheme.bodyMedium,)),
                            16.horizontalSpace,
                            InkWell(
                              onTap: ()=> Helper.copyText(state.dashboard?.data?.referralLink ?? ''),
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
                padding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
                child: Text(appLanguage(context).recent_transaction,style: appTheme(context).textTheme.headlineMedium,),
              ),
              ListView.builder(
                  itemCount: state.dashboard?.data?.transactions?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (ctx,index){
                    Transactions data = state.dashboard!.data!.transactions![index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)
                      ),
                      elevation: 4,
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.symmetric(horizontal: 16.r).copyWith(bottom: 8.r),
                        tilePadding: EdgeInsets.only(right: 8.r,left: 16.r),
                        collapsedIconColor: AppColor.iconColor,
                        iconColor: AppColor.iconColor,
                        title: Row(
                          children: [
                            Expanded(child: Text(appLanguage(context).txnID,style: appTheme(context).textTheme.headlineSmall,)),
                            Text(data.txnid ?? '',style: appTheme(context).textTheme.bodyMedium,)
                          ],
                        ),
                        subtitle: Align(
                          alignment: Alignment.topRight,
                          child: Text(data.date ?? '',style: appTheme(context).textTheme.bodySmall!.copyWith(color: AppColor.grey),),
                        ),
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(appLanguage(context).type,style: appTheme(context).textTheme.headlineSmall,)),
                              Text(data.type ?? '',style: appTheme(context).textTheme.bodyMedium,)
                            ],
                          ),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(child: Text(appLanguage(context).amount,style: appTheme(context).textTheme.headlineSmall,)),
                              Text(data.amount ?? '',style: appTheme(context).textTheme.bodyMedium!.copyWith(color: AppColor.primary),)
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              ),
              16.verticalSpace
            ],
          )
        )
      ),
    );
  }

  Widget singleSection({
    required String title,
    required String data,
    required Color color,
    required IconData icon,
    double? iconSize,
    bool isSwitched = false,
    EdgeInsetsGeometry? padding,
    IconButton? tileButton
  }){
    return Card(
      margin: padding ?? EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2)
      ),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.all(8.r),
        child: Row(
          children: [
            Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(width: 1,color: color.withOpacity(0.5)),
              ),
              padding: EdgeInsets.all(8.r),
              margin: EdgeInsets.only(right: 8.r),
              child: Icon(icon,color: color,size: iconSize ?? 24.r,),
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: !isSwitched ? [
                Text(title ,style: appTheme().textTheme.bodySmall!.copyWith(fontWeight: Dimension.textMedium,color: AppColor.grey),),
                Text(data ,style: appTheme().textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textSemiBold),),
              ] : [
                Text(data ,style: appTheme().textTheme.headlineLarge!.copyWith(fontWeight: Dimension.textSemiBold),),
                Text(title ,style: appTheme().textTheme.bodySmall!.copyWith(fontWeight: Dimension.textMedium,color: AppColor.grey),),
              ],
            )),
            if(tileButton!=null)
              tileButton
          ],
        ),
      ),
    );
  }

  Widget drawerView(BuildContext context, MainPageState state) {
    return Drawer(
      backgroundColor: AppColor.background,
      elevation: 10,
      child: Column(
        children: [
          DrawerHeader(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
                color: AppColor.cardColor
            ),
            child: InkWell(
              onTap: ()=> goToProfilePage(),
              child: Row(
                children: [
                  ClipOval(
                    child: CachedImage(
                      imageUrl: state.user?.propic ?? '',
                      isProfileImage: true,
                      height: 60.h,
                      width: 60.h,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.user?.fullName ?? '',style: appTheme(context).textTheme.headlineMedium,),
                        Text(state.user?.email ?? '',style: appTheme(context).textTheme.bodyMedium!.copyWith(color: AppColor.grey),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.drawerTabs.length,
              itemBuilder: (ctx,index){
                DrawerTab tab = state.drawerTabs[index];
                return ExpansionTile(
                  iconColor: AppColor.iconColor,
                  collapsedIconColor: AppColor.iconColor,
                  title: Text(tab.title,style: appTheme(context).textTheme.headlineMedium,),
                  trailing: tab.tabs.isEmpty ? const SizedBox.shrink() : null,
                  childrenPadding: EdgeInsets.only(left: 16.r),
                  leading: Icon(tab.icon,color: AppColor.iconColor,size: 20.r,),
                  onExpansionChanged: (value){
                    if(tab.tabs.isEmpty){
                      navigatePage(tab.route,tab.arguments);
                    }
                  },
                  children: tab.tabs.asMap().map((index, value) => MapEntry(index,
                    InkWell(
                      onTap: ()=>navigatePage(value.route,value.arguments),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.r),
                        padding: EdgeInsets.only(left: 16.r),
                        child: Row(
                          children: [
                            Text(value.title,style: appTheme(context).textTheme.headlineMedium!.copyWith(
                              fontWeight: Dimension.textSemiBold,
                              color: AppColor.grey
                            ),),
                          ],
                        ),
                      ),
                    )
                  )).values.toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void navigatePage(String? route,dynamic arguments){
    bloc!.scaffoldKey.currentState!.openEndDrawer();
    if(route!=null){
      goToPage(route,arguments: arguments);
    }
  }

  Future<void> goToProfilePage() async {
    bloc!.scaffoldKey.currentState!.openEndDrawer();
    await goToPage(Routes.EDIT_PROFILE);
    bloc!.add(UpdateUser());
  }

  Widget currencyView(MainPageState state,BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120.w,
          height: 30.h,
          child: DropdownTheme(
            child: DropdownSearch<CurrencyData>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                menuProps: MenuProps(
                  backgroundColor: AppColor.cardColor
                )
              ),
              itemAsString: (CurrencyData data)=> data.name!,
              compareFn: (data,data2)=>data.id == data2.id,
              items: state.currencies!.data!,
              selectedItem: state.selectedCurrency,
              dropdownDecoratorProps: dropdownDecoration(
                padding: EdgeInsets.symmetric(horizontal: 10.r)
              ),
              onChanged: (data)=> bloc!.add(ChangeCurrency(data!)),
            ),
          ),
        ),
      ],
    );
  }
}

