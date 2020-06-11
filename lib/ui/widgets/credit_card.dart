part of 'widgets.dart';

class CreditCard extends StatelessWidget {
  final Credit credit;

  CreditCard(this.credit);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 70,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: credit.profilePath == null
                    ? null
                    : NetworkImage(imageBaseUrl + "w185" + credit.profilePath),
              )),
        ),
        Container(
          width: 70,
          margin: EdgeInsets.only(top: 6),
          child: Text(
            credit.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: blackTextFont.copyWith(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
