part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      'movieId': ticket.movieDetail.id,
      'userID': id ?? "",
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.dateTime.millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userId);

    List<Ticket> tickets = [];
    for (var document in documents) {
      var movieDetail = await MovieServices.getMovieDetail(null,
          movieId: document.data['movieId']);

      tickets.add(Ticket(
          movieDetail,
          document.data['seats'].toString().split(','),
          document.data['bookingCode'],
          document.data['totalPrice'],
          Theater(document.data['theaterName']),
          DateTime.fromMicrosecondsSinceEpoch(document.data['time']),
          document.data['name']));
    }

    return tickets;
  }
}
