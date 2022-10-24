part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class GetTicketsEvent extends TicketEvent {
  final String userID;

  const GetTicketsEvent(this.userID);

  @override
  List<Object> get props => [userID];
}

class BuyTicketEvent extends TicketEvent {
  final TicketModel ticket;
  final String userID;

  const BuyTicketEvent(this.ticket, this.userID);

  @override
  List<Object> get props => [ticket, userID];
}
