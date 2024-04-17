

class URL {
    static const String baseUrl = "https://rajvirfinance.in/";//https://royalscripts.com/test/geniusbank/
    static const String privacyUrl = "https://rajvirfinance.in/privacy";//https://royalscripts.com/test/geniusbank/privacy
    static const String aboutUs = "https://rajvirfinance.in/about";//https://royalscripts.com/test/geniusbank/about
    static const String googleAuthenticatorAppLinkAndroid = "https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en";
    static const String googleAuthenticatorAppLinkIos = "https://apps.apple.com/us/app/google-authenticator/id388497605";

    static const int paginate = 16;

    static const String signIn = '${baseUrl}api/user/login';
    static const String signUp = '${baseUrl}api/user/registration';
    static const String refreshToken = '${baseUrl}api/user/refresh/token';
    static const String twoFaOtpVerification = '${baseUrl}api/user/otp-submit';
    static const String user = '${baseUrl}api/user/details';
    static const String contactUs = '${baseUrl}api/contact';
    static const String contactInfo = '${baseUrl}api/contact-info';
    static const String userDashboard = '${baseUrl}api/user/dashboard';
    static const String updateProfile = '${baseUrl}api/user/profile/update';
    static const String resetPassword = '${baseUrl}api/user/forgot';
    static const String resetPasswordSubmit = '${baseUrl}api/user/forgot/submit';
    static const String changePassword = '${baseUrl}api/user/password/update';
    static const String userSubscriptionPlan = '${baseUrl}api/user/subscription-plans';
    static const String getReferrers = '${baseUrl}api/user/referrers';
    static const String getReferrerCommission = '${baseUrl}api/user/referrer-commissions';
    static const String kycForm = '${baseUrl}api/user/kyc-form';
    static const String kycFormSubmit = '${baseUrl}api/user/kyc-form/submit';


    static const String currencies = '${baseUrl}api/currencies';
    static const String dashboard = '${baseUrl}api/user/dashboard';
    static const String blogs = '${baseUrl}api/all-blogs';
    static const String tickets = '${baseUrl}api/user/tickets';
    static const String ticketReply = '${baseUrl}api/user/ticket';
    static const String ticketReplySubmit = '${baseUrl}api/user/ticket/reply';
    static const String ticketStore = '${baseUrl}api/user/ticket/store';
    static String deleteTicket(String id) => '${baseUrl}api/user/ticket/delete/$id';

    //Loans
    static const String loanPlans = '${baseUrl}api/user/loan-plans';
    static const String loanAmountCheck = '${baseUrl}api/user/apply-for-loan';
    static const String submitLoanRequest = '${baseUrl}api/user/loan-request';
    static const String allLoans = '${baseUrl}api/user/all-loans';
    static const String pendingLoans = '${baseUrl}api/user/pending-loans';
    static const String runningLoans = '${baseUrl}api/user/running-loans';
    static const String rejectedLoans = '${baseUrl}api/user/rejected-loans';
    static const String paidLoans = '${baseUrl}api/user/paid-loans';

    //Dps
    static const String dpsPlans = '${baseUrl}api/user/dps-plans';
    static const String submitDpsRequest = '${baseUrl}api/user/dps-submit';
    static const String allDps = '${baseUrl}api/user/all-dps';
    static const String runningDps = '${baseUrl}api/user/running-dps';
    static const String maturedDps = '${baseUrl}api/user/matured-dps';


    //Fdr
    static const String fdrPlans = '${baseUrl}api/user/fdr-plans';
    static const String checkFdrAmount = '${baseUrl}api/user/apply-for-fdr';
    static const String submitFdrRequest = '${baseUrl}api/user/fdr-apply';
    static const String allFdr = '${baseUrl}api/user/all-fdr';
    static const String runningFdr = '${baseUrl}api/user/running-fdr';
    static const String closedFdr = '${baseUrl}api/user/closed-fdr';


    //Deposit
    static const String depositList = '${baseUrl}api/user/deposit/history';
    static const String applyDeposit = '${baseUrl}api/user/deposit';

    //Wire Transfer
    static const String wireTransfer = '${baseUrl}api/user/wire-transfer';
    static const String wireTransferBank= '${baseUrl}api/user/wire-transfer/banks';

    //Withdraw
    static const String withdrawList= '${baseUrl}api/user/withdraws';
    static const String methods= '${baseUrl}api/user/withdraw-methods';
    static const String submitWithdraw= '${baseUrl}api/user/withdraw/store';


    //Transaction
    static const String transferLog= '${baseUrl}api/user/transfer-logs';
    static const String othersBankList= '${baseUrl}api/user/other-bank-transfer';
    static const String savedAccounts= '${baseUrl}api/user/save-account/list';
    static const String searchAccount= '${baseUrl}api/user/username/';
    static const String sendMoney= '${baseUrl}api/user/send-money';
    static const String transactions= '${baseUrl}api/user/transactions';
    static const String bankDetails= '${baseUrl}api/user/other-banks/';
    static const String othersBankTransfer= '${baseUrl}api/user/other-bank/send';


    //Beneficiary
    static const String beneficiaryLog= '${baseUrl}api/user/beneficiaries';
    static const String addBeneficiary= '${baseUrl}api/user/beneficiary';
    static const String getOthersBank= '${baseUrl}api/user/other-banks';
    static const String submitBeneficiary= '${baseUrl}api/user/beneficiary';

    //Request Money
    static const String requestMoneyList= '${baseUrl}api/user/request-money/history';
    static const String receiveRequestMoneyList= '${baseUrl}api/user/receive-request-money/history';
    static const String submitRequestMoney= '${baseUrl}api/user/request-money';
    static const String acceptReceiveRequestMoney= '${baseUrl}api/user/money-send/';

    //2fa verification
    static const String twoFAForm = '${baseUrl}api/user/two-factor';
    static const String disableVerification = '${baseUrl}api/user/disableTwoFactor';
    static const String enableVerification = '${baseUrl}api/user/createTwoFactor';

}
