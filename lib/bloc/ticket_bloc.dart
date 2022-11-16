import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    on<TicketEvent>((event, emit) {});
    on<BuyTicketEvent>((event, emit) async {
      await TicketServices.saveTicket(event.userID, event.ticket);
      List<TicketModel> tickets = await TicketServices.getTickets(event.userID);

      emit(TicketLoadedState(tickets));
    });

    on<GetTicketsEvent>((event, emit) async {
      List<TicketModel> tickets = await TicketServices.getTickets(event.userID);

      emit(TicketLoadedState(tickets));
    });
  }
}
