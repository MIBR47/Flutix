part of 'ticket_bloc.dart';

class TicketState extends Equatable {
  final List<TicketModel> tickets;
  const TicketState(this.tickets);

  @override
  List<Object> get props => [tickets];
}

// class TicketInitial extends TicketState {}
