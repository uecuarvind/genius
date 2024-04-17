import 'package:genius_bank/module/fdr/all_fdr/data/fdr_list.dart';

import '../../../../app_helper/enums.dart';

class AllFdrState {
  FdrList? lists;
  PageState pageState;


  AllFdrState({this.lists, this.pageState = PageState.Loading});

  AllFdrState init() {
    return AllFdrState();
  }

  AllFdrState clone({FdrList? lists, PageState? pageState}) {
    return AllFdrState(
      pageState: pageState ?? this.pageState,
      lists: lists ?? this.lists
    );
  }
}
