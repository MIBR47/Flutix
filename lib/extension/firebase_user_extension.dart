// part of 'extensions.dart';
part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserModel convertToUserModel(
          {String name = "No Name",
          List<String> selectedGenres = const [],
          String selectedlanguage = 'English',
          int balance = 50000}) =>
      UserModel(
        uid,
        email!,
        name: name,
        balance: balance,
        selectedGenres: selectedGenres,
        selectedLanguage: selectedlanguage,
      );

  Future<UserModel> fromFireStore() async => await UserServices.getUser(uid);
}
