part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subTitle;
  final int percent;

  Promo(
      {@required this.title, @required this.subTitle, @required this.percent});

  @override
  List<Object> get props => [title, subTitle, percent];
}
