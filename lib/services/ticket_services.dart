part of 'services.dart';

class TicketServices {
  static final CollectionReference ticketCollection = FirebaseFirestore.instance.collection('tickets');
  static Future<void> saveTicket(String id, TicketModel ticket) async {
    try {
      ticketCollection.doc().set({
        'movieID': ticket.movieDetail?.id ?? "",
        'userID': id,
        'theaterID': ticket.theater?.id ?? "",
        'time': ticket.time?.millisecondsSinceEpoch,
        'bookingCode': ticket.bookingCode,
        'seats': ticket.seatsInString,
        'name': ticket.name,
        'totalPrice': ticket.totalPrice,
      }, SetOptions(merge: true));
    } catch (e) {
      print("ticket services gagal");
      print(e);
    }
  }

  static Future<List<TicketModel>> getTickets(String userID) async {
    QuerySnapshot snapshot = await ticketCollection.where('userID', isEqualTo: userID).get();
    var documents = snapshot.docs;
    List<TicketModel> tickets = [];
    for (var doc in documents) {
      MovieDetailModel movieDetail = await MovieServices.getDetails(doc['movieID']);
      tickets.add(TicketModel(
          movieDetail: movieDetail,
          theater: dummyTheaters.where((element) => element.id == doc['theaterID']) as TheaterModel,
          time: DateTime.fromMillisecondsSinceEpoch(doc['time']),
          bookingCode: doc['bookingcode'],
          seats: doc['seats'],
          name: doc['name'],
          totalPrice: doc['totalPrice']));
    }
    return tickets;
  }
}
