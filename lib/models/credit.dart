part of 'models.dart';

class CreditModel extends Equatable {
  final String? name;
  final String? profilePath;

  const CreditModel({this.name, this.profilePath});

  @override
  List<Object?> get props => [name, profilePath];
}
