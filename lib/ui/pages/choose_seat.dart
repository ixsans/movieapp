part of 'pages.dart';

class ChooseSeatPage extends StatefulWidget {
  final Ticket ticket;

  ChooseSeatPage(this.ticket);

  @override
  _ChooseSeatPageState createState() => _ChooseSeatPageState();
}

class _ChooseSeatPageState extends State<ChooseSeatPage> {
  List<int> seatCount = [3, 5, 5, 5, 5];
  List<String> selectedSeats = [];

  Widget buildSeats(double boxSize) {
    List<Widget> rows = [];

    for (int i = 0; i < seatCount.length; i++) {
      rows.add(Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(seatCount[i], (index) {
            var seatNumber = "${String.fromCharCode(i + 65)}${index + 1}";
            return Container(
                margin:
                    EdgeInsets.only(right: index < seatCount[i] - 1 ? 16 : 0),
                child: SelectableBox(
                  seatNumber,
                  width: boxSize,
                  height: boxSize,
                  textStyle: whiteNumberFont.copyWith(color: Colors.black),
                  isEnabled: index != 0,
                  isSelected: selectedSeats.contains(seatNumber),
                  onTap: () {
                    setState(() {
                      if (selectedSeats.contains(seatNumber)) {
                        selectedSeats.remove(seatNumber);
                      } else {
                        selectedSeats.add(seatNumber);
                      }
                    });
                  },
                ));
          }),
        ),
      ));
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center, children: rows);
  }

  @override
  Widget build(BuildContext context) {
    double boxSize =
        (MediaQuery.of(context).size.width - (48 * 2) - (16 * 4)) / 5;
    double screenWidth = (MediaQuery.of(context).size.width - (40 * 2));
    double screenHeight =
        84 / 277 * (MediaQuery.of(context).size.width - (40 * 2));

    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GotoSelectSchedulePageEvent(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 0, left: defaultMargin),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GotoSelectSchedulePageEvent(
                                      widget.ticket.movieDetail));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  widget.ticket.movieDetail.title,
                                  style: blackTextFont.copyWith(
                                    fontSize: 18,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16, right: defaultMargin, top: 20),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage(imageBaseUrl +
                                          "w154" +
                                          widget
                                              .ticket.movieDetail.backdropPath),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      ],
                    ),

                    // CINEMA SCREEN
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: screenWidth,
                      height: screenHeight,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/screen.png'))),
                    ),

                    buildSeats(boxSize),

                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 30, defaultMargin, 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFE4E4E4))),
                          ),
                          Text(
                            'Available',
                            style: blackTextFont.copyWith(fontSize: 12),
                          ),
                          SizedBox(width: 20),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color(0xFFE4E4E4),
                              )),
                          Text(
                            'Booked',
                            style: blackTextFont.copyWith(fontSize: 12),
                          ),
                          SizedBox(width: 20),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: accentColor2,
                              )),
                          Text(
                            'Selected',
                            style: blackTextFont.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ),

                    FloatingActionButton(
                        backgroundColor: selectedSeats.length > 0
                            ? mainColor
                            : Color(0xFFE4E4E4),
                        elevation: 0,
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                        onPressed: selectedSeats.length > 0
                            ? () {
                                context.bloc<PageBloc>().add(
                                    GotoCheckoutPageEvent(widget.ticket
                                        .copyWith(
                                            bookingCode: randomAlphaNumeric(12),
                                            seats: selectedSeats)));
                              }
                            : null),

                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
