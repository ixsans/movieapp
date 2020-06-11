part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GotoMovieDetailPageEvent(widget.movieDetail));
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
                    // note: BACK ICON
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20, left: defaultMargin),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GotoMovieDetailPageEvent(widget.movieDetail));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(defaultMargin, 20, 0, 20),
                      child: Text('Choose Date',
                          style: blackTextFont.copyWith(fontSize: 20)),
                    ),
                    Container(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        itemBuilder: (_, index) => Container(
                          padding: EdgeInsets.only(
                              left: index == 0 ? defaultMargin : 0,
                              right: index == dates.length - 1
                                  ? defaultMargin
                                  : 16),
                          child: DateCard(
                            date: dates[index],
                            isSelected: selectedDate == dates[index],
                            onTap: () {
                              setState(() {
                                selectedDate = dates[index];
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // THEATER
                    timeTableWidgets(),
                    SizedBox(height: 16),
                    BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                      var userName = (userState as UserLoaded).user.name;
                      return FloatingActionButton(
                        backgroundColor:
                            isValid ? mainColor : Color(0xFFE4E4E4),
                        elevation: 0,
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                        onPressed: () {
                          context.bloc<PageBloc>().add(
                                GotoChooseSeatPageEvent(
                                  Ticket(
                                      widget.movieDetail,
                                      [],
                                      null,
                                      0,
                                      selectedTheater,
                                      DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime),
                                      userName),
                                ),
                              );
                        },
                      );
                    }),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Theater selectedTheater;
  int selectedTime;

  Column timeTableWidgets() {
    List<int> schedules = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (Theater theater in availableTheaters) {
      widgets.add(Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child: Text(
            theater.name,
            style: blackTextFont.copyWith(fontSize: 20),
          )));

      widgets.add(
        Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: schedules.length,
            itemBuilder: (_, index) {
              return Container(
                padding: EdgeInsets.only(
                    left: index == 0 ? defaultMargin : 0,
                    right: index < schedules.length - 1 ? 16 : defaultMargin),
                child: SelectableBox(
                  '${schedules[index]}:00',
                  width: 90,
                  height: 50,
                  isEnabled: DateTime.now().hour < schedules[index] ||
                      DateTime.now().day != selectedDate.day,
                  isSelected: selectedTime == schedules[index] &&
                      selectedTheater == theater,
                  onTap: () {
                    setState(() {
                      selectedTime = schedules[index];
                      selectedTheater = theater;
                      isValid = true;
                    });
                  },
                ),
              );
            },
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
