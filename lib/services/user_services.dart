part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('user');

  static Future<void> updateUser(User user) async {
    try {
      _userCollection.document(user.id).setData({
        'email': user.email,
        'name': user.name,
        'balance': user.balance,
        'selectedGenres': user.selectedGenres,
        'selectedLanguage': user.selectedLanguage,
        'profilePicture': user.profilePicture ?? ""
      });
    } catch (e) {
      print("ERROR: " + e.toString());
    }
  }

  static Future<User> getUser(String uid) async {
    DocumentSnapshot snapshot = await _userCollection.document(uid).get();
    return User(
      uid,
      snapshot.data['email'],
      balance: snapshot.data['balance'],
      name: snapshot.data['name'],
      profilePicture: snapshot.data['profilePicture'],
      selectedGenres: (snapshot.data['selectedGenres'] as List)
          .map((e) => e.toString())
          .toList(),
      selectedLanguage: snapshot.data['selectedLanguage'],
    );
  }
}
