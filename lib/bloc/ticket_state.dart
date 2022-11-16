part of 'ticket_bloc.dart';

class TicketState extends Equatable {
  // final List<TicketModel> tickets;
  // const TicketState(this.tickets);

  // @override
  // List<Object> get props => [tickets];
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketLoadedState extends TicketState {
  final List<TicketModel> tickets;
  const TicketLoadedState(this.tickets);

  @override
  List<Object> get props => [tickets];
}

class TicketInitial extends TicketState {}
