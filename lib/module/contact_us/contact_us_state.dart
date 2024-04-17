import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/data/auth.dart';

import 'data/contact_info.dart';

class ContactUsState {
  Auth? auth = Auth.getAuth();
  PageState pageState;
  ContactInfo? contactInfo;


  ContactUsState({this.pageState = PageState.Initial,this.contactInfo});

  ContactUsState init() {
    return ContactUsState();
  }

  ContactUsState clone({PageState? pageState, ContactInfo? contactInfo}) {
    return ContactUsState(
      pageState: pageState ?? this.pageState,
      contactInfo: contactInfo ?? this.contactInfo
    );
  }
}
