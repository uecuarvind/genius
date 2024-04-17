import 'package:genius_bank/module/transfer/beneficiary/beneficiary_list/data/beneficiary_list.dart';

import '../../../../../app_helper/enums.dart';

class BeneficiaryListState {
  BeneficiaryList? listData;
  PageState pageState;


  BeneficiaryListState({this.listData, this.pageState = PageState.Loading});

  BeneficiaryListState init() {
    return BeneficiaryListState();
  }

  BeneficiaryListState clone({BeneficiaryList? listData, PageState? pageState}) {
    return BeneficiaryListState(
      pageState: pageState ?? this.pageState,
      listData: listData ?? this.listData
    );
  }
}
