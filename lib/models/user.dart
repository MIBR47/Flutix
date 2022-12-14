part of 'models.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? profilePicture;
  final List<String>? selectedGenres;
  final String? selectedLanguage;
  final int? balance;

  const UserModel(
    this.id,
    this.email, {
    this.name,
    this.profilePicture,
    this.selectedGenres,
    this.selectedLanguage,
    this.balance,
  });

  UserModel copyWith({String? name, String? profilePicture, int? balance}) =>
      UserModel(
        id,
        email,
        name: name ?? this.name,
        profilePicture: profilePicture ?? this.profilePicture,
        balance: balance ?? this.balance,
        selectedGenres: selectedGenres,
        selectedLanguage: selectedLanguage,
      );
  @override
  String toString() {
    return "[$id]-$name, $email";
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenres,
        selectedLanguage,
        balance,
      ];
}
