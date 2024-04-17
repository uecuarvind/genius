import 'dart:io';

import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/config/dependency.dart';
import 'package:genius_bank/controllers/share_helper.dart';
import 'package:genius_bank/data/auth.dart';
import 'package:genius_bank/module/kyc_verification/data/form_data.dart';
import 'package:genius_bank/module/pricing_plan/data/pricing_plan.dart';
import 'package:genius_bank/module/referral/my_referred/data/referral_user.dart';
import 'package:genius_bank/module/referral/referrer_commissions/data/referrer_commission.dart';
import 'package:genius_bank/module/two_fa_verification/data/two_fa_data.dart';
import 'package:genius_bank/utils/url.dart';

import '../data/user.dart';

class UserRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getUser({required Function(Auth) onSuccess,required Function(Map<String,dynamic>) onError,bool enableShowError = true,bool forceLogout = true}) async {
    await apiClient.Request(
        url: URL.user,
        enableShowError: enableShowError,
        forceLogout: forceLogout,
        onSuccess: (Map<String,dynamic> data) {
          User user = User.fromJson(data['data']);
          Auth? auth = Auth.getAuth();
          auth!.data!.user = user;
          ShareHelper.setAuth(auth);
          onSuccess(auth);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }




  Future changePassword({required Map<String,String> body, required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.changePassword,
      method: Method.POST,
      body: body,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(data);
      },
      onError: (Map<String,dynamic> data) {
        onError(data);
      }
    );
  }



  Future updateProfile({required Map<String,String> body, required Function(Auth) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.updateProfile,
        method: Method.POST,
        body: body,
        onSuccess: (Map<String,dynamic> data) {
          User user = User.fromJson(data['data']);
          Auth? auth = Auth.getAuth();
          auth!.data!.user = user;
          instance.registerSingleton<Auth>(auth);
          onSuccess(auth);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future getSubscriptionPlan({required Function(PricingPlan) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.userSubscriptionPlan,
        onSuccess: (Map<String,dynamic> data) {
          PricingPlan plans = PricingPlan.fromJson(data);
          onSuccess(plans);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future getReferralData({required Function(ReferralUser) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.getReferrers,
        onSuccess: (Map<String,dynamic> data) {
          ReferralUser users = ReferralUser.fromJson(data);
          onSuccess(users);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future getReferrerCommission({required Function(ReferrerCommission) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.getReferrerCommission,
        onSuccess: (Map<String,dynamic> data) {
          ReferrerCommission users = ReferrerCommission.fromJson(data);
          onSuccess(users);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future getKycForm({required Function(FormData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.kycForm,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(FormData.fromJson(data));
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future getTwoFaData({required Function(TwoFaData) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.twoFAForm,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(TwoFaData.fromJson(data));
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future changeTwoFaState({required String url, required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: url,
        method: Method.POST,
        body: body,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  Future submitKyc({
    required Map<String, String> body,
    required Function(dynamic) onSuccess,
    required Function(Map<String,dynamic>) onError,
    List<File> files = const [],
    List<String> fileKeys = const [],
  }) async {
    await apiClient.RequestWithFile(
        url: URL.kycFormSubmit,
        body: body,
        method: Method.POST,
        files: files,
        fileKey: fileKeys,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(data);
        },
        onError: onError
    );
  }
}