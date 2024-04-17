import 'package:genius_bank/module/loan/log_details/data/logs.dart';

import '../../../../app_helper/enums.dart';

class LogDetailsState {
  Logs? logs;
  PageState pageState;


  LogDetailsState({this.logs, this.pageState = PageState.Loading});

  LogDetailsState init() {
    return LogDetailsState();
  }

  LogDetailsState clone({Logs? logs, PageState? pageState}) {
    return LogDetailsState(
      pageState: pageState ?? this.pageState,
      logs: logs ?? this.logs
    );
  }
}
