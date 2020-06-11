part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats.length;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GotoChooseSeatPageEvent(widget.ticket));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                var user = (userState as UserLoaded).user;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  color: Colors.white,
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
                                          GotoChooseSeatPageEvent(
                                              widget.ticket));
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
                                    margin: EdgeInsets.only(top: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      'Checkout\nMovie',
                                      style: blackTextFont.copyWith(
                                        fontSize: 20,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                    )),
                              )
                            ],
                          )),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imageBaseUrl +
                                        "w154" +
                                        widget
                                            .ticket.movieDetail.backdropPath))),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width -
                                        (defaultMargin * 2) -
                                        (16 * 2) -
                                        70,
                                    child: Text(
                                      widget.ticket.movieDetail.title,
                                      style: blackTextFont.copyWith(
                                        fontSize: 18,
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  width: MediaQuery.of(context).size.width -
                                      (defaultMargin * 2) -
                                      (16 * 2) -
                                      70,
                                  child: Text(
                                    widget
                                        .ticket.movieDetail.getGenreAndLanguage,
                                    style: blackTextFont.copyWith(
                                      color: Color(0xFFADADAD),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: RatingStar(
                                      color: Color(0xFFADADAD),
                                      voteAverage: widget
                                          .ticket.movieDetail.voteAverage),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Divider(
                          color: Color(0xFFE4E4E4),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Order ID',
                              style: blackTextFont.copyWith(
                                  fontSize: 16, color: accentColor3),
                              textAlign: TextAlign.left,
                            ),
                            Text(widget.ticket.bookingCode,
                                style: whiteNumberFont.copyWith(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Cinema',
                              style: greyTextFont.copyWith(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(widget.ticket.movieDetail.title,
                                    style: whiteNumberFont.copyWith(
                                        fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.right)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Date & Time',
                              style: greyTextFont.copyWith(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            Text(widget.ticket.dateTime.dateAndTime,
                                style: whiteNumberFont.copyWith(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Seat Number',
                              style: greyTextFont.copyWith(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                widget.ticket.seatsInString,
                                style: whiteNumberFont.copyWith(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Price',
                              style: greyTextFont.copyWith(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                "IDR 25.000 x ${widget.ticket.seats.length}",
                                style: whiteNumberFont.copyWith(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Fee',
                              style: greyTextFont.copyWith(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                "IDR 15.000 x ${widget.ticket.seats.length}",
                                style: whiteNumberFont.copyWith(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total',
                              style: greyTextFont.copyWith(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                NumberFormat.currency(
                                        locale: "id_ID",
                                        decimalDigits: 0,
                                        symbol: 'IDR ')
                                    .format(total),
                                style: whiteNumberFont.copyWith(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Divider(
                          color: Color(0xFFE4E4E4),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Your Wallet',
                              style: greyTextFont.copyWith(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                NumberFormat.currency(
                                        locale: "id_ID",
                                        decimalDigits: 0,
                                        symbol: 'IDR ')
                                    .format(user.balance),
                                style: whiteNumberFont.copyWith(
                                    fontSize: 16,
                                    color: user.balance >= total
                                        ? Color(0xFF3E9D9D)
                                        : Color(0xFFFF5C83),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 46,
                        width: 250,
                        margin: EdgeInsets.symmetric(
                            vertical: 30, horizontal: defaultMargin),
                        child: RaisedButton(
                          elevation: 0,
                          color: user.balance >= total
                              ? Color(0xFF3E9D9D)
                              : mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                              user.balance >= total
                                  ? 'Checkout Now'
                                  : 'Topup Wallet',
                              style: whiteTextFont.copyWith(fontSize: 16)),
                          onPressed: () async {
                            if (user.balance >= total) {
                              MovieTransaction transaction = MovieTransaction(
                                  userId: user.id,
                                  title: widget.ticket.movieDetail.title,
                                  subTitle: widget.ticket.theater.name,
                                  amount: -total,
                                  time: DateTime.now(),
                                  picture:
                                      widget.ticket.movieDetail.backdropPath);

                              context.bloc<PageBloc>().add(
                                  GotoSuccessCheckoutPageEvent(
                                      widget.ticket.copyWith(totalPrice: total),
                                      transaction));
                            } else {
                              // topup

                            }
                          },
                        ),
                      )
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
