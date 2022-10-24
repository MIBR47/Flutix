part of 'models.dart';

class FlutixTransactionModel extends Equatable {
  final String userID;
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String picture;

  const FlutixTransactionModel({
    required this.title,
    required this.userID,
    required this.subtitle,
    this.amount = 0,
    required this.time,
    this.picture = '',
  });
  @override
  List<Object?> get props => [userID, title, subtitle, amount, time, picture];
}
