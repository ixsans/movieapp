part of 'pages.dart';

class TicketsPage extends StatefulWidget {
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  bool isExpiredTickets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Body
          BlocBuilder<TicketBloc, TicketState>(builder: (_, ticketState) {
            var sortedTickets = ticketState.tickets
                .where((ticket) => isExpiredTickets
                    ? ticket.dateTime.isBefore(DateTime.now())
                    : !ticket.dateTime.isBefore(DateTime.now()))
                .toList();

            sortedTickets.sort((ticket1, ticket2) =>
                ticket1.dateTime.compareTo(ticket2.dateTime));
            return Container(
              padding:
                  EdgeInsets.fromLTRB(defaultMargin, 113, defaultMargin, 0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: sortedTickets.length,
                itemBuilder: (_, index) {
                  return Container(
                    padding: EdgeInsets.only(top: 16),
                    child: TicketCard(
                      sortedTickets[index],
                      onTap: () {
                        context.bloc<PageBloc>().add(
                            GotoTicketDetailPageEvent(sortedTickets[index]));
                      },
                    ),
                  );
                },
              ),
            );
          }),

          // Header
          Container(
            height: 113,
            color: accentColor1,
          ),
          SafeArea(
            child: ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 113,
                color: accentColor1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 24, bottom: 30),
                      child: Text(
                        'My Tickets',
                        style: whiteTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpiredTickets = false;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Text('Newest',
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: !isExpiredTickets
                                          ? Colors.white
                                          : Color(0xFF6F678E))),
                              SizedBox(height: 16),
                              Container(
                                  height: 4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  color: !isExpiredTickets
                                      ? accentColor2
                                      : mainColor)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpiredTickets = true;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Text('Oldest',
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: isExpiredTickets
                                          ? Colors.white
                                          : Color(0xFF6F678E))),
                              SizedBox(height: 16),
                              Container(
                                  height: 4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  color: isExpiredTickets
                                      ? accentColor2
                                      : mainColor)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
