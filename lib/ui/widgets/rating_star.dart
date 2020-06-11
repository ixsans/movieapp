part of 'widgets.dart';

class RatingStar extends StatelessWidget {
  final double voteAverage; // va = numOfVotes / totalVotes (x/10)
  final double startSize;
  final double fontSize;
  final Color color;
  final MainAxisAlignment mainAxisAlignment;

  RatingStar(
      {this.voteAverage = 0,
      this.startSize = 20,
      this.fontSize = 12,
      this.color,
      this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    var n = (voteAverage / 2)
        .round(); // because start is only 5 but voteAverage is x/10

    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(index < n ? MdiIcons.star : MdiIcons.starOutline,
            color: accentColor2, size: startSize));

    widgets.add(SizedBox(
      width: 3,
    ));
    widgets.add(Text("$voteAverage/10",
        style: whiteNumberFont.copyWith(
            color: color ?? Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: fontSize)));

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: widgets,
    );
  }
}
