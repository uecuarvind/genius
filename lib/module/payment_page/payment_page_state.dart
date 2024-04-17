import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/data/auth.dart';

class PaymentPageState {
  String? webUrl;
  Auth? auth = Auth.getAuth();
  PageState pageState;


  PaymentPageState({this.webUrl,this.pageState = PageState.Loading});

  PaymentPageState init() {
    return PaymentPageState();
  }

  PaymentPageState clone({String? webUrl,PageState? pageState}) {
    return PaymentPageState(
      webUrl: webUrl ?? this.webUrl,
      pageState: pageState ?? this.pageState
    );
  }
}
