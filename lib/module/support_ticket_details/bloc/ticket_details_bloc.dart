import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/repositories/ticket_repository.dart';

import '../../../app_helper/enums.dart';
import '../../../main.dart';
import '../../../utils/app_constant.dart';
import '../../support_ticket/data/tickets.dart';
import 'ticket_details_event.dart';
import 'ticket_details_state.dart';

class TicketDetailsBloc extends Bloc<TicketDetailsEvent, TicketDetailsState> {
  TicketRepository repository = TicketRepository();

  TextEditingController message = TextEditingController();

  TicketDetailsBloc() : super(TicketDetailsState().init()) {
    on<InitEvent>(_init);
    on<SendMessageEvent>(_sendMessage);
    on<GetReply>(_getReply);
  }
  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<TicketDetailsState> emit) async {
    emit(state.clone(
      messageData: settings(event.context).arguments as TicketData
    ));
    add(GetReply());
  }

  FutureOr<void> _sendMessage(SendMessageEvent event, Emitter<TicketDetailsState> emit) async {
    if(message.text.isEmpty) return;
    emit(state.clone(pageState: PageState.Loading));

    Map<String,String> body={
      AppConstant.message:message.text,
      AppConstant.conversation_id:state.messageData!.id!.toString(),
    };
    await repository.sendReply(
        body: body,
        onSuccess: (data) {
          message.clear();
          state.reply!.data!.add(data.data!);
          emit(state.clone(pageState: PageState.Success));
        },
        onError: (data){
          emit(state.clone(pageState: PageState.Error));
        }
    );
  }

  FutureOr<void> _getReply(GetReply event, Emitter<TicketDetailsState> emit) async {
    await repository.getReply(
        id: state.messageData!.id!.toString(),
        onSuccess: (data) {
          emit(state.clone(reply: data,pageState: PageState.Success));
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
}
