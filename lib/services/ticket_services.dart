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
    QuerySnapshot snapshot = await ticketCollection.get();

    var documents = snapshot.docs.where((element) => element['userID'] == userID);
    print('test');
    print(documents);
    List<TicketModel> tickets = [];
    TheaterModel filteredTheater = dummyTheaters[1];

    for (var doc in documents) {
      for (var theater in dummyTheaters) {
        if (theater.id == doc['theaterID']) {
          filteredTheater = theater;
          break;
        }
      }
      MovieDetailModel movieDetail = await MovieServices.getDetailsByID(doc['movieID']);
      tickets.add(TicketModel(
          movieDetail: movieDetail,
          theater: filteredTheater,
          // theater: dummyTheaters.where((element) => element.id == doc['theaterID']).toList() as TheaterModel,

          time: DateTime.fromMillisecondsSinceEpoch(doc['time']),
          bookingCode: doc['bookingCode'],
          seats: doc['seats'].toString().split(','),
          name: doc['name'],
          totalPrice: doc['totalPrice']));
    }
    return tickets;
  }
}
