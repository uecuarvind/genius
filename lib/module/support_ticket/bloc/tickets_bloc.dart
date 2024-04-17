import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_helper/enums.dart';
import '../../../main.dart';
import '../../../repositories/ticket_repository.dart';
import 'tickets_event.dart';
import 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  TicketRepository repository = TicketRepository();

  TicketsBloc() : super(TicketsState().init()) {
    on<InitEvent>(_init);
    on<DeleteEvent>(_deleteData);
    on<SendNewDataEvent>(_storeData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TicketsState> emit) async {
    emit(state.clone(
      pageState: PageState.Loading
    ));
    await getOrders(emit);
  }

  Future getOrders(Emitter<TicketsState> emit) async {
    await repository.getTickets(
        onSuccess: (data) {
          emit(state.clone(tickets: data,pageState: PageState.Success));
        },
        onError: (data){
          emit(
            state.clone(
              pageState: PageState.Error,
            ),
          );
        }
    );
  }

  FutureOr<void> _deleteData(DeleteEvent event, Emitter<TicketsState> emit) async {
    await repository.deleteData(
        id: state.tickets!.data![event.index].id!.toString(),
        onSuccess: (data) {
          state.tickets!.data!.removeAt(event.index);
          emit(state.clone());
        },
        onError: (data){
        }
    );
  }

  FutureOr<void> _storeData(SendNewDataEvent event, Emitter<TicketsState> emit) async {
    emit(state.clone(newDataDialogLoading: true));
    await repository.storeData(
        body: event.body,
        onSuccess: (data) {
          backPage(true);
        },
        onError: (data){
        }
    );
    emit(state.clone(newDataDialogLoading: false));
  }
}
