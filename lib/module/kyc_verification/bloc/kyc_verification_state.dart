import 'package:genius_bank/module/kyc_verification/data/form_data.dart';

class KycVerificationState {
  FormData? formData;
  bool loading;


  KycVerificationState({this.formData,this.loading = false});

  KycVerificationState init() {
    return KycVerificationState();
  }

  KycVerificationState clone({FormData? formData,bool? loading}) {
    return KycVerificationState(
      formData: formData ?? this.formData,
      loading: loading ?? this.loading
    );
  }
}
