part of 'models.dart';

class Ticket extends Equatable {
  final MovieDetail movieDetail;
  final List<String> seats;
  final String bookingCode;
  final int totalPrice;
  final Theater theater;
  final DateTime dateTime;
  final String name;

  Ticket(this.movieDetail, this.seats, this.bookingCode, this.totalPrice,
      this.theater, this.dateTime, this.name);

  Ticket copyWith(
          {MovieDetail movieDetail,
          List<String> seats,
          String bookingCode,
          int totalPrice,
          Theater theater,
          DateTime dateTime,
          String name}) =>
      Ticket(
          movieDetail ?? this.movieDetail,
          seats ?? this.seats,
          bookingCode ?? this.bookingCode,
          totalPrice ?? this.totalPrice,
          theater ?? this.theater,
          dateTime ?? this.dateTime,
          name ?? this.name);

  String get seatsInString {
    String s = "";
    for (var seat in seats) {
      s += seat + (seat != seats.last ? "," : "");
    }
    return s;
  }

  @override
  List<Object> get props =>
      [movieDetail, seats, bookingCode, totalPrice, theater, dateTime, name];
}
