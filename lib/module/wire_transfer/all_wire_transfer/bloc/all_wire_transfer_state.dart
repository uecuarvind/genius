import 'package:genius_bank/module/wire_transfer/all_wire_transfer/data/wire_transfers.dart';

import '../../../../app_helper/enums.dart';

class AllWireTransferState {
  WireTransfers? transfers;
  PageState pageState;


  AllWireTransferState({this.transfers, this.pageState = PageState.Loading});

  AllWireTransferState init() {
    return AllWireTransferState();
  }

  AllWireTransferState clone({WireTransfers? transfers, PageState? pageState}) {
    return AllWireTransferState(
      pageState: pageState ?? this.pageState,
      transfers: transfers ?? this.transfers
    );
  }
}
