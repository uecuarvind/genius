import 'package:genius_bank/module/transfer/others_banks/data/others_bank.dart';

import '../../../../../app_helper/enums.dart';

class OthersBanksState {
  OthersBank? listData;
  PageState pageState;


  OthersBanksState({this.listData, this.pageState = PageState.Loading});

  OthersBanksState init() {
    return OthersBanksState();
  }

  OthersBanksState clone({OthersBank? listData, PageState? pageState}) {
    return OthersBanksState(
      pageState: pageState ?? this.pageState,
      listData: listData ?? this.listData
    );
  }
}
