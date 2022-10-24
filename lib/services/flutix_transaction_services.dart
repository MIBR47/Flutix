part of 'services.dart';

class FlutixTransactionServices {
  static final CollectionReference transactionCollection = FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(FlutixTransactionModel flutixTransaction) async {
    try {
      transactionCollection.doc().set({
        'userID': flutixTransaction.userID,
        'title': flutixTransaction.title,
        'subtitle': flutixTransaction.subtitle,
        'time': flutixTransaction.time.millisecondsSinceEpoch,
        'amount': flutixTransaction.amount,
        'picture': flutixTransaction.picture,
      }, SetOptions(merge: true));
    } catch (e) {
      print("ticket services gagal");
      print(e);
    }
  }

  static Future<List<FlutixTransactionModel>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.where('userID', isEqualTo: userID).get();
    var documents = snapshot.docs;

    return documents
        .map(
          (element) => FlutixTransactionModel(
            title: element['userID'],
            userID: element['title'],
            subtitle: element['subtitle'],
            time: DateTime.fromMicrosecondsSinceEpoch(
              element['time'],
            ),
            amount: element['amount'],
            picture: element['picture'],
          ),
        )
        .toList();
  }
}
