
import 'package:genius_bank/module/support_ticket_details/data/reply.dart';

import '../app_helper/api_client.dart';
import '../module/support_ticket/data/tickets.dart';
import '../module/support_ticket_details/data/new_message.dart';
import '../utils/url.dart';

class TicketRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getTickets({required Function(Tickets) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.tickets,
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(Tickets.fromJson(data));
      },
      onError: onError
    );
  }

  Future getReply({required String id,required Function(Reply) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: '${URL.ticketReply}/$id',
      onSuccess: (Map<String,dynamic> data) {
        onSuccess(Reply.fromJson(data));
      },
      onError: onError
    );
  }
  Future storeData({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.ticketStore,
        body: body,
        method: Method.POST,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  Future deleteData({required String id,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.deleteTicket(id),
        onSuccess: onSuccess,
        onError: onError
    );
  }

  Future sendReply({required Map<String,String> body,required Function(NewMessage) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.ticketReplySubmit,
        method: Method.POST,
        body: body,
        onSuccess: (Map<String,dynamic> data) {
          onSuccess(NewMessage.fromJson(data));
        },
        onError: onError
    );
  }
}