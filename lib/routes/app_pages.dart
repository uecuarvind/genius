import 'package:flutter/material.dart';
import 'package:genius_bank/module/blog_details/blog_details_view.dart';
import 'package:genius_bank/module/blogs/view/blogs_view.dart';
import 'package:genius_bank/module/change_password/change_password_view.dart';
import 'package:genius_bank/module/contact_us/contact_us_view.dart';
import 'package:genius_bank/module/dps/all_dps/view/all_dps_view.dart';
import 'package:genius_bank/module/kyc_verification/kyc_verification.dart';
import 'package:genius_bank/module/kyc_verification/kyc_verification_2.dart';
import 'package:genius_bank/module/loan/all_loan/view/all_loan_view.dart';
import 'package:genius_bank/module/loan/apply_loan/view/apply_loan_view.dart';
import 'package:genius_bank/module/loan/loan_plan/view/loan_plan_view.dart';
import 'package:genius_bank/module/my_profile/my_profile_view.dart';
import 'package:genius_bank/module/payment_page/payment_page_view.dart';
import 'package:genius_bank/module/pricing_plan/view/pricing_plan_view.dart';
import 'package:genius_bank/module/referral/my_referred/view/my_referred_view.dart';
import 'package:genius_bank/module/referral/referrer_commissions/view/referrer_commission_view.dart';
import 'package:genius_bank/module/reset_password/view/reset_password_view.dart';
import 'package:genius_bank/module/settings/settings_view.dart';
import 'package:genius_bank/module/sign_in/view/sign_in_view.dart';
import 'package:genius_bank/module/sign_up/view/sign_up_view.dart';
import 'package:genius_bank/module/splash/splash_view.dart';
import 'package:genius_bank/module/support_pages/view/support_view.dart';

import '../module/deposit/all_deposit/view/all_deposit_view.dart';
import '../module/dps/dps_plan/view/dps_plan_view.dart';
import '../module/fdr/all_fdr/view/all_fdr_view.dart';
import '../module/fdr/fdr_plan/view/fdr_plan_view.dart';
import '../module/kyc_verification/view/kyc_verification_view.dart';
import '../module/loan/log_details/view/log_details_view.dart';
import '../module/main_page/view/main_page_view.dart';
import '../module/request_money/all_request_money/view/all_request_money_view.dart';
import '../module/request_money/receive_request_money/view/receive_request_money_view.dart';
import '../module/request_money/submit_request_money/view/submit_request_money_view.dart';
import '../module/support_ticket/view/tickets_view.dart';
import '../module/support_ticket_details/view/ticket_details_view.dart';
import '../module/transactions/view/transactions_view.dart';
import '../module/transfer/beneficiary/add_beneficiary/view/add_beneficiary_view.dart';
import '../module/transfer/beneficiary/beneficiary_list/view/beneficiary_list_view.dart';
import '../module/transfer/others_bank_transfer/view/others_bank_transfer_view.dart';
import '../module/transfer/others_banks/view/others_banks_view.dart';
import '../module/transfer/send_money/view/send_money_view.dart';
import '../module/transfer/transfer_list/view/transfer_list_view.dart';
import '../module/two_fa_verification/view/two_fa_verification_view.dart';
import '../module/wire_transfer/add_wire_transfer/view/add_wire_transfer_view.dart';
import '../module/wire_transfer/all_wire_transfer/view/all_wire_transfer_view.dart';
import '../module/withdraw/add_withdraw/view/add_withdraw_view.dart';
import '../module/withdraw/all_withdraw/view/all_withdraw_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static Map<String, WidgetBuilder> routes = {
    INITIAL : (context) => SplashPage(),
    Routes.SIGN_IN : (context) => SignInPage(),
    Routes.SIGN_UP : (context) => SignUpPage(),
    Routes.KYC_VERIFICATION : (context) => KycVerificationPage(),
    Routes.KYC_VERIFICATION_New : (context) => KycVerificationScreen(),
    Routes.KYC_VERIFICATION_Step2_New : (context) => KycVerification2Screen(),
    Routes.MAIN_PAGE : (context) => MainPage(),
    Routes.EDIT_PROFILE : (context) => MyProfilePage(),
    Routes.CHANGE_PASSWORD : (context) => ChangePasswordPage(),
    Routes.RESET_PASSWORD : (context) => ResetPasswordPage(),
    Routes.SETTINGS : (context) => SettingsPage(),
    Routes.SUPPORT_PAGES : (context) => SupportPage(),
    Routes.CONTACT_US : (context) => ContactUsPage(),
    Routes.LOAN_PLANS : (context) => LoanPlanPage(),
    Routes.APPLY_LOAN : (context) => ApplyLoanPage(),
    Routes.ALL_LOAN : (context) => AllLoanPage(),
    Routes.LOG_DETAILS : (context) => LogDetailsPage(),
    Routes.ALL_DPS : (context) => AllDpsPage(),
    Routes.DPS_PLAN : (context) => DpsPlanPage(),
    Routes.FDR_PLAN : (context) => FdrPlanPage(),
    Routes.ALL_FDR : (context) => AllFdrPage(),
    Routes.DEPOSIT : (context) => AllDepositPage(),
    Routes.WIRE_TRANSFER : (context) => AllWireTransferPage(),
    Routes.ADD_WIRE_TRANSFER : (context) => AddWireTransferPage(),
    Routes.WITHDRAW_LIST : (context) => AllWithdrawPage(),
    Routes.ADD_WITHDRAW : (context) => AddWithdrawPage(),
    Routes.TRANSFER_LOG : (context) => TransferListPage(),
    Routes.BENEFICIARY_LIST : (context) => BeneficiaryListPage(),
    Routes.ADD_BENEFICIARY : (context) => AddBeneficiaryPage(),
    Routes.OTHERS_BANKS : (context) => OthersBanksPage(),
    Routes.OTHERS_BANK_TRANSFER : (context) => OthersBankTransferPage(),
    Routes.PAYMENT_PAGE : (context) => PaymentPagePage(),
    Routes.SEND_MONEY : (context) => SendMoneyPage(),
    Routes.PRICING_PLAN : (context) => PricingPlanPage(),
    Routes.REQUEST_MONEY_LIST : (context) => AllRequestMoneyPage(),
    Routes.SUBMIT_REQUEST_MONEY : (context) => SubmitRequestMoneyPage(),
    Routes.RECEIVE_REQUEST_MONEY : (context) => ReceiveRequestMoneyPage(),
    Routes.MY_REFERRED : (context) => MyReferredPage(),
    Routes.REFERRER_COMMISSION : (context) => ReferrerCommissionPage(),
    Routes.TRANSACTIONS : (context) => TransactionsPage(),
    Routes.BLOGS : (context) => BlogsPage(),
    Routes.BLOG_DETAILS : (context) => BlogDetailsPage(),
    Routes.TICKETS_PAGE : (context) => TicketsPage(),
    Routes.TICKET_DETAILS_PAGE : (context) => TicketDetailsPage(),
    Routes.TWO_FA_VERIFICATION : (context) => TwoFAVerificationPage(),
  };
}
