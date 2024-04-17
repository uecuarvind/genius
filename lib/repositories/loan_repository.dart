import 'dart:io';

import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/loan/all_loan/data/loans.dart';
import 'package:genius_bank/module/loan/loan_plan/data/apply_loan.dart';
import 'package:genius_bank/module/loan/loan_plan/data/plans.dart';
import 'package:genius_bank/module/loan/log_details/data/logs.dart';
import 'package:genius_bank/utils/url.dart';

class LoanRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getAllLoans({required String url,required Function(Loans) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url,
      onSuccess: (Map<String,dynamic> data) {
        Loans loans = Loans.fromJson(data);
        onSuccess(loans);
      },
      onError: onError
    );
  }

  Future getLoanLogs({required String url,required Function(Logs) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: url,
      onSuccess: (Map<String,dynamic> data) {
        Logs logs = Logs.fromJson(data);
        onSuccess(logs);
      },
      onError: onError
    );
  }

  Future getPlans({required Function(Plans) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.loanPlans,
      onSuccess: (Map<String,dynamic> data) {
        Plans plans = Plans.fromJson(data);
        onSuccess(plans);
      },
      onError: onError
    );
  }

  Future checkAmount({required Map<String, String> body, required Function(ApplyLoan) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.loanAmountCheck,
      body: body,
      method: Method.POST,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(ApplyLoan.fromJson(data));
      },
      onError: onError
    );
  }

  Future submitLoanRequest({
    required Map<String, String> body,
    required Function(dynamic) onSuccess,
    required Function(Map<String,dynamic>) onError,
    List<File> files = const [],
    List<String> fileKeys = const [],
  }) async {
    await apiClient.RequestWithFile(
      url: URL.submitLoanRequest,
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