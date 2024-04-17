import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/config/dependency.dart';
import 'package:genius_bank/controllers/share_helper.dart';
import 'package:genius_bank/data/auth.dart';
import 'package:genius_bank/module/reset_password/data/reset_password.dart';
import 'package:genius_bank/utils/app_constant.dart';
import 'package:genius_bank/utils/url.dart';

class AuthRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future postSignIn({required Map<String,dynamic> body,required Function(Auth) onSuccess,required Function(Map<String,dynamic>) onError,bool enableShowError = true}) async {
    await apiClient.Request(
        url: URL.signIn,
        withAuth: false,
        method: Method.POST,
        body: body,
        enableShowError: enableShowError,
        onSuccess: (Map<String,dynamic> data) {
          print("success login.....");
          Auth auth = Auth.fromJson(data);
          onSuccess(auth);
        },
        onError: (Map<String,dynamic> data) {
          print("failed login.....$data");
          onError(data);
        }
    );
  }

  Future postRestPassword({required Map<String,dynamic> body,required Function(ResetPassword) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.resetPassword,
        withAuth: false,
        method: Method.POST,
        enableShowError: false,
        body: body,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(ResetPassword.fromJson(data));
        },
        onError: (Map<String,dynamic> data) {
          ErrorMessage(message: data[AppConstant.error]);
          onError(data);
        }
    );
  }

  Future restPasswordSubmit({required Map<String,dynamic> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.resetPasswordSubmit,
        withAuth: false,
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


  Future postSignUp({required Map<String,dynamic> body,required Function(Auth) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.signUp,
        withAuth: false,
        method: Method.POST,
        body: body,
        onSuccess: (Map<String,dynamic> data) async {
          Auth auth = Auth.fromJson(data);
          ShareHelper.setAuth(auth);
          onSuccess(auth);
        },
        onError: (Map<String,dynamic> data) {
          onError(data);
        }
    );
  }

  Future getRefreshToken({required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError, required Auth auth}) async {
    instance.registerSingleton<Auth>(auth);
    ShareHelper.setAuth(auth);
    await apiClient.Request(
        url: URL.refreshToken,
        body: {},
        method: Method.POST,
        enableShowError: false,
        onSuccess: (Map<String,dynamic> data) async {
          onSuccess(data);
        },
        onError: (Map<String,dynamic> data) {
          auth.data!.token = data['access_token'];
          ShareHelper.setAuth(auth);
          onSuccess(auth);
        }
    );
  }

  Future twoFaOtpVerification({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.twoFaOtpVerification,
        method: Method.POST,
        body: body,
        onSuccess: onSuccess,
        onError: onError
    );
  }
}