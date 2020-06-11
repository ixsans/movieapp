part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GotoMainPageEvent(
            bottomNavBarIndex: 1,
            isExpired: ticket.dateTime.isBefore(DateTime.now())));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: accentColor1),
            SafeArea(
              child: Container(
                color: Color(0xFFE5E5E5),
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 30),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.all(1),
                              child: GestureDetector(
                                onTap: () {
                                  context.bloc<PageBloc>().add(
                                      GotoMainPageEvent(
                                          bottomNavBarIndex: 1,
                                          isExpired: ticket.dateTime
                                              .isBefore(DateTime.now())));
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                margin: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  'Ticket Details',
                                  style: blackTextFont.copyWith(
                                    fontSize: 20,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                )),
                          )
                        ],
                      ),
                    ),
                    ClipPath(
                      clipper: TopClipper(),
                      child: Column(
                        children: <Widget>[
                          // BODY
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              image: DecorationImage(
                                  image: NetworkImage(imageBaseUrl +
                                      "w500" +
                                      ticket.movieDetail.posterPath),
                                  fit: BoxFit.cover),
                            ),
                          ),

                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Text(
                                    "${ticket.movieDetail.title}",
                                    style: blackTextFont.copyWith(fontSize: 18),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "${ticket.movieDetail.getGenreAndLanguage}",
                                    style: greyTextFont.copyWith(fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: RatingStar(
                                    voteAverage: ticket.movieDetail.voteAverage,
                                    color: Color(0xFFADADAD),
                                    fontSize: 12,
                                    startSize: 12,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Cinema',
                                          style: greyTextFont.copyWith(
                                              fontSize: 16)),
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    (2 * defaultMargin) -
                                                    (2 * 16)) /
                                                2,
                                        child: Text(
                                          ticket.theater.name,
                                          textAlign: TextAlign.right,
                                          style: blackTextFont.copyWith(
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Date & Time',
                                          style: greyTextFont.copyWith(
                                              fontSize: 16)),
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    (2 * defaultMargin) -
                                                    (2 * 16)) /
                                                2,
                                        child: Text(
                                          ticket.dateTime.dateAndTime,
                                          textAlign: TextAlign.right,
                                          style: blackTextFont.copyWith(
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Date & Time',
                                          style: greyTextFont.copyWith(
                                              fontSize: 16)),
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    (2 * defaultMargin) -
                                                    (2 * 16)) /
                                                2,
                                        child: Text(
                                          ticket.seatsInString,
                                          textAlign: TextAlign.right,
                                          style: blackTextFont.copyWith(
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Order ID',
                                          style: greyTextFont.copyWith(
                                              fontSize: 16)),
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    (2 * defaultMargin) -
                                                    (2 * 16)) /
                                                2,
                                        child: Text(
                                          ticket.bookingCode.toUpperCase(),
                                          textAlign: TextAlign.right,
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DashDivider(
                                    height: 4, color: Color(0xFFE4E4E4)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipPath(
                      clipper: BottomClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 40),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width -
                                  (2 * defaultMargin) -
                                  (16 * 2) -
                                  100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    textAlign: TextAlign.left,
                                    style: greyTextFont.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    ticket.name,
                                    textAlign: TextAlign.right,
                                    style: blackTextFont.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Paid',
                                    textAlign: TextAlign.left,
                                    style: greyTextFont.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    NumberFormat.currency(
                                            locale: "id_ID",
                                            decimalDigits: 0,
                                            symbol: 'Rp ')
                                        .format(ticket.totalPrice),
                                    textAlign: TextAlign.right,
                                    style: whiteNumberFont.copyWith(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            QrImage(
                              version: 6,
                              foregroundColor: Colors.black,
                              errorCorrectionLevel: QrErrorCorrectLevel.M,
                              padding: EdgeInsets.all(0),
                              size: 100,
                              data: ticket.bookingCode,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopClipper extends CustomClipper<Path> {
  final double radius = 15.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(radius, size.height - radius, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width - radius, size.height - radius,
        size.width, size.height - radius);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> clipper) => false;
}

class BottomClipper extends CustomClipper<Path> {
  final double radius = 15.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, radius);
    path.quadraticBezierTo(radius, radius, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width - radius, radius, size.width, radius);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> clipper) => false;
}
