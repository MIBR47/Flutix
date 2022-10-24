part of 'models.dart';

class TicketModel extends Equatable {
  final MovieDetailModel? movieDetail;
  final TheaterModel? theater;
  final DateTime? time;
  final String bookingCode;
  final List<String>? seats;
  final String? name;
  final int totalPrice;
  const TicketModel({this.movieDetail, this.theater, this.time, this.bookingCode = "xxxx", this.seats, this.name = '', this.totalPrice = 0});

  TicketModel copyWith({
    MovieDetailModel? movieDetail,
    TheaterModel? theater,
    DateTime? time,
    String? bookingCode,
    List<String>? seats,
    String? name,
    int? totalPrice,
  }) =>
      TicketModel(
        movieDetail: movieDetail ?? this.movieDetail,
        theater: theater ?? this.theater,
        time: time ?? this.time,
        bookingCode: bookingCode ?? this.bookingCode,
        seats: seats ?? this.seats,
        name: name ?? this.name,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  String get seatsInString {
    String s = '';

    for (var seat in seats!) {
      s += seat + ((seat != seats!.last) ? ', ' : '');
    }
    return s;
  }

  @override
  List<Object?> get props => [movieDetail, theater, time, bookingCode, seats, name, totalPrice];
}
