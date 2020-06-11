part of 'models.dart';

class MovieTransaction extends Equatable {
  final String userId;
  final String title;
  final String subTitle;
  final int amount;
  final DateTime time;
  final String picture;

  MovieTransaction(
      {@required this.userId,
      @required this.title,
      @required this.subTitle,
      this.amount,
      @required this.time,
      this.picture});

  @override
  List<Object> get props => [userId, title, subTitle, amount, time, picture];
}
