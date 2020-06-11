part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton(this.genre);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 4),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFEEF1F8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
              child: SizedBox(
            height: 36,
            child: Image(image: AssetImage(getAssetImage(genre))),
          )),
        ),
        Text(genre, style: blackTextFont.copyWith(fontSize: 12)),
      ],
    );
  }

  String getAssetImage(String genre) {
    if (genre == 'Drama') {
      return "assets/ic_drama.png";
    } else if (genre == 'Music') {
      return "assets/ic_music.png";
    } else if (genre == 'Horror') {
      return "assets/ic_horror.png";
    } else if (genre == "Crime") {
      return "assets/ic_crime.png";
    } else if (genre == "Action") {
      return "assets/ic_action.png";
    } else if (genre == "War") {
      return "assets/ic_myst.png";
    } else {
      return "";
    }
  }
}
