import 'package:flutter/material.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/custom_icons/my_flutter_app_icons.dart' as CustomIcon;
import 'package:genius_bank/data/auth.dart';
import 'package:genius_bank/data/currencies.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/main_page/data/dashboard.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/utils/app_constant.dart';
import 'package:genius_bank/utils/url.dart';

import '../../../data/user.dart';
import '../data/drawer_tab.dart';

class MainPageState {
  PageState pageState;
  Dashboard? dashboard;
  User? user = Auth.getAuth()!.data!.user!;
  Currencies? currencies = Currencies.getCurrencies();
  CurrencyData? selectedCurrency = CurrencyData.getCurrency();
  List<DrawerTab> get drawerTabs => [
    DrawerTab( //Done
      title: appLanguage().loan,
      icon: CustomIcon.MyFlutterApp.cash_loan,
      tabs: [
        SubTab(title: appLanguage().loan_plan,route: Routes.LOAN_PLANS),
        SubTab(title: appLanguage().all_loans,route: Routes.ALL_LOAN,arguments: {
          AppConstant.url: URL.allLoans,
          AppConstant.page: appLanguage().all_loans
        }),
        SubTab(title: appLanguage().pending_loans,route: Routes.ALL_LOAN,arguments: {
          AppConstant.url: URL.pendingLoans,
          AppConstant.page: appLanguage().pending_loans
        }),
        SubTab(title: appLanguage().running_loans,route: Routes.ALL_LOAN,arguments: {
          AppConstant.url: URL.runningLoans,
          AppConstant.page: appLanguage().running_loans
        }),
        SubTab(title: appLanguage().paid_loans,route: Routes.ALL_LOAN,arguments: {
          AppConstant.url: URL.paidLoans,
          AppConstant.page: appLanguage().paid_loans
        }),
        SubTab(title: appLanguage().rejected_loans,route: Routes.ALL_LOAN,arguments: {
          AppConstant.url: URL.rejectedLoans,
          AppConstant.page: appLanguage().rejected_loans
        }),
      ]
    ),
   /* DrawerTab( //Done
      title: appLanguage().dps.toUpperCase(),
      icon: CustomIcon.MyFlutterApp.dps,
      tabs: [
        SubTab(title: appLanguage().dps_plan,route: Routes.DPS_PLAN),
        SubTab(title: appLanguage().all_dps,route: Routes.ALL_DPS,arguments: {
          AppConstant.url: URL.allDps,
          AppConstant.page: appLanguage().all_dps
        }),
        SubTab(title: appLanguage().running_dps,route: Routes.ALL_DPS,arguments: {
          AppConstant.url: URL.runningDps,
          AppConstant.page: appLanguage().running_dps
        }),
        SubTab(title: appLanguage().matured_dps,route: Routes.ALL_DPS,arguments: {
          AppConstant.url: URL.maturedDps,
          AppConstant.page: appLanguage().matured_dps
        }),
      ]
    ),
    DrawerTab( //Done
      title: appLanguage().fdr.toUpperCase(),
      icon: CustomIcon.MyFlutterApp.fdr,
      tabs: [
        SubTab(title: appLanguage().fdr_plan,route: Routes.FDR_PLAN),
        SubTab(title: appLanguage().all_fdr,route: Routes.ALL_FDR,arguments: {
          AppConstant.url: URL.allFdr,
          AppConstant.page: appLanguage().all_fdr
        }),
        SubTab(title: appLanguage().running_fdr,route: Routes.ALL_FDR,arguments: {
          AppConstant.url: URL.runningFdr,
          AppConstant.page: appLanguage().running_fdr
        }),
        SubTab(title: appLanguage().closed_fdr,route: Routes.ALL_FDR,arguments: {
          AppConstant.url: URL.closedFdr,
          AppConstant.page: appLanguage().closed_fdr
        }),
      ]
    ),
    DrawerTab( //Done
      title: appLanguage().request_money,
      icon: CustomIcon.MyFlutterApp.request_money,
      tabs: [
        SubTab(title: appLanguage().send_request_money,route: Routes.REQUEST_MONEY_LIST),
        SubTab(title: appLanguage().receive_request_money,route: Routes.RECEIVE_REQUEST_MONEY),
      ]
    ), */
    DrawerTab( //Done
      title: appLanguage().deposit,
      icon: CustomIcon.MyFlutterApp.deposit,
      route: Routes.DEPOSIT,
      tabs: [],
    ),
  /*  DrawerTab( //Done
      title: appLanguage().wire_transfer,
      icon: CustomIcon.MyFlutterApp.wire_transfer,
      route: Routes.WIRE_TRANSFER,
      tabs: []
    ),
    DrawerTab( //Done
      title: appLanguage().transfer,
      icon: CustomIcon.MyFlutterApp.transaction,
      tabs: [
        SubTab(title: appLanguage().send_money,route: Routes.SEND_MONEY),
        SubTab(title: appLanguage().beneficiary_manage,route: Routes.BENEFICIARY_LIST),
        SubTab(title: appLanguage().other_bank_transfer,route: Routes.OTHERS_BANKS),
        SubTab(title: appLanguage().transfer_history,route: Routes.TRANSFER_LOG),
      ]
    ),
    DrawerTab( //Done
      title: appLanguage().withdraw,
      icon: CustomIcon.MyFlutterApp.withdraw,
      route: Routes.WITHDRAW_LIST,
      tabs: []
    ),
    DrawerTab( //Done
      title: appLanguage().pricing_plan,
      icon: CustomIcon.MyFlutterApp.pricing_plan,
      route: Routes.PRICING_PLAN,
      tabs: []
    ), */
    DrawerTab(
      title: appLanguage().more,
      icon: CustomIcon.MyFlutterApp.more,
      tabs: [
        SubTab(title: appLanguage().two_fa_security,route: Routes.TWO_FA_VERIFICATION),
        SubTab(title: appLanguage().referred_users,route: Routes.MY_REFERRED),
        SubTab(title: appLanguage().referral_commissions, route: Routes.REFERRER_COMMISSION),
        SubTab(title: appLanguage().support_tickets,route: Routes.TICKETS_PAGE),
        SubTab(title: appLanguage().transactions,route: Routes.TRANSACTIONS),
      ]
    ),
    DrawerTab( //Done
      title: appLanguage().settings,
      icon: Icons.settings,
      tabs: [],
      route: Routes.SETTINGS
    ),
  ];


  MainPageState({
    this.dashboard,
    this.pageState = PageState.Loading,
    this.user
  }){
    user = Auth.getAuth()!.data!.user!;
  }

  MainPageState init() {
    return MainPageState();
  }

  MainPageState clone({Dashboard? dashboard,PageState? pageState, User? user}) {
    return MainPageState(
      dashboard: dashboard ?? this.dashboard,
      pageState: pageState ?? this.pageState,
      user: user ?? this.user
    );
  }
}
