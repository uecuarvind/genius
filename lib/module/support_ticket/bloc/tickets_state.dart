
import '../../../app_helper/enums.dart';
import '../data/tickets.dart';

class TicketsState {
  Tickets? tickets;
  PageState? pageState;
  bool newDataDialogLoading;


  TicketsState({this.tickets, this.pageState = PageState.Loading,this.newDataDialogLoading = false});

  TicketsState init() {
    return TicketsState();
  }

  TicketsState clone({Tickets? tickets,PageState? pageState, bool? isDisputes,bool? newDataDialogLoading}) {
    return TicketsState(
      tickets: tickets ?? this.tickets,
      pageState: pageState ?? this.pageState,
      newDataDialogLoading: newDataDialogLoading ?? this.newDataDialogLoading
    );
  }
}
