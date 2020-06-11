part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final MovieTransaction transcation;

  SuccessPage(this.ticket, this.transcation);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
          body: FutureBuilder(
              future: ticket != null
                  ? processingTicketOrder(context)
                  : processingTopUp(context),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        margin: EdgeInsets.only(bottom: 70),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ticket == null
                                  ? 'assets/top_up_done.png'
                                  : 'assets/ticket_done.png')),
                        ),
                      ),
                      Text(
                        (ticket == null) ? "Emm Yummy!" : "Happy Watching!",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 16),
                      Text(
                        (ticket == null)
                            ? "You have successfully\ntop up the wallet"
                            : "You have successfully\nbought the ticket",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                      Container(
                          height: 45,
                          width: 250,
                          margin: EdgeInsets.only(top: 70, bottom: 20),
                          child: RaisedButton(
                            elevation: 0,
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                                ticket == null ? "My Wallet" : "My Tickets",
                                style: whiteTextFont),
                            onPressed: ticket == null
                                ? () {
                                    context.bloc<PageBloc>().add(
                                        GotoMyWalletPageEvent(
                                            GotoMainPageEvent()));
                                  }
                                : () {
                                    context.bloc<PageBloc>().add(
                                        GotoMainPageEvent(
                                            bottomNavBarIndex: 1));
                                  },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Discover new movie? ',
                              style: greyTextFont.copyWith(
                                  fontWeight: FontWeight.w400)),
                          GestureDetector(
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GotoMainPageEvent(bottomNavBarIndex: 1));
                            },
                            child: Text('Back to Home', style: purpleTextFont),
                          )
                        ],
                      )
                    ],
                  );
                } else {
                  return Center(
                      child: SpinKitFadingCircle(size: 50, color: mainColor));
                }
              })),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(PurchaseTicket(transcation.userId, ticket));

    await MovieTransactionServices.saveTransaction(transcation);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(amount: transcation.amount));

    await MovieTransactionServices.saveTransaction(transcation);
  }
}
