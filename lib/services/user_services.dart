part of 'services.dart';

class UserServices {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  static Future<void> updateUser(UserModel user) async {
    // String genres = '';
    // for (var genre in user.selectedGenres!) {
    //   genres += genre + ((genre != user.selectedGenres?.last) ? ', ' : '');
    // }
    try {
      _userCollection.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'balance': user.balance,
        'selectedGenres': user.selectedGenres,
        'selectedLanguage': user.selectedLanguage,
        'profileImage': user.profilePicture ?? '',
      }, SetOptions(merge: true));
    } catch (e) {
      print("test gagal");
      print(e);
    }
  }

  static Future<void> updateUserPicture(UserModel user) async {
    // String genres = '';
    // for (var genre in user.selectedGenres!) {
    //   genres += genre + ((genre != user.selectedGenres?.last) ? ', ' : '');
    // }
    _userCollection.doc(user.id).update({
      'name': "update test",
      'balance': user.balance,
      'profileImage': user.profilePicture,
    });
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();
    // String email = snapshot.data()['email'];

    return UserModel(
      id,
      snapshot['email'],
      balance: snapshot['balance'],
      profilePicture: snapshot['profileImage'],
      selectedGenres: (snapshot['selectedGenres'] as List)
          .map((e) => e.toString())
          .toList(),
      selectedLanguage: snapshot['selectedLanguage'],
      name: snapshot['name'],
    );
  }
}
