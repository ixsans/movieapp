part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
}

class PurchaseTicket extends TicketEvent {
  final String userId;
  final Ticket ticket;

  PurchaseTicket(this.userId, this.ticket);

  @override
  List<Object> get props => [userId, ticket];
}

class GetTickets extends TicketEvent {
  final String userId;

  GetTickets(this.userId);

  @override
  List<Object> get props => [userId];
}
