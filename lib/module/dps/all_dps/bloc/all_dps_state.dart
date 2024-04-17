import 'package:genius_bank/module/dps/all_dps/data/dps.dart';

import '../../../../app_helper/enums.dart';

class AllDpsState {
  Dps? dps;
  PageState pageState;


  AllDpsState({this.dps, this.pageState = PageState.Loading});

  AllDpsState init() {
    return AllDpsState();
  }

  AllDpsState clone({Dps? dps, PageState? pageState}) {
    return AllDpsState(
      pageState: pageState ?? this.pageState,
      dps: dps ?? this.dps
    );
  }
}
