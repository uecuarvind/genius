
import 'package:genius_bank/module/support_ticket/data/tickets.dart';

import '../../../app_helper/enums.dart';
import '../../../data/auth.dart';
import '../data/reply.dart';

class TicketDetailsState {
  PageState pageState;
  TicketData? messageData;
  Reply? reply;
  Auth? auth = Auth.getAuth();


  TicketDetailsState({this.pageState = PageState.Initial, this.messageData, this.reply});

  TicketDetailsState init() {
    return TicketDetailsState();
  }

  TicketDetailsState clone({PageState? pageState, TicketData? messageData, Reply? reply}) {
    return TicketDetailsState(
      messageData: messageData ?? this.messageData,
      pageState: pageState ?? this.pageState,
      reply: reply ?? this.reply
    );
  }
}
