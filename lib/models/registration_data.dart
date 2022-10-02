part of 'models.dart';

class RegistationDataModel {
  String name;
  String email;
  String password;
  List<String> selectedGenres;
  String selectedLang;
  File? profileImage;

  RegistationDataModel({
    this.name = "",
    this.email = "",
    this.password = "",
    this.selectedGenres = const [],
    this.selectedLang = "",
    this.profileImage,
  });
}
