part of 'services.dart';

class MovieTransactionServices {
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(MovieTransaction transaction) async {
    await transactionCollection.document().setData({
      'userID': transaction.userId,
      'title': transaction.title,
      'subTitle': transaction.subTitle,
      'time': transaction.time.millisecondsSinceEpoch,
      'amount': transaction.amount,
      'picture': transaction.picture
    });
  }

  static Future<List<MovieTransaction>> getTransactions(String userId) async {
    QuerySnapshot snapshot = await transactionCollection.getDocuments();
    var documents = snapshot.documents.where((e) => e.data['userID'] == userId);
    print("SIZZZ");
    var data = [];
    try {
      data = documents
          .map((e) => MovieTransaction(
                userId: e.data['userID'],
                title: e.data['title'],
                subTitle: e.data['subTitle'],
                amount: e.data['amount'],
                time: DateTime.fromMicrosecondsSinceEpoch(e.data['time']),
                picture: e.data['picture'],
              ))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    print("SIZZZ ${data.length}");
    return data;
  }
}
