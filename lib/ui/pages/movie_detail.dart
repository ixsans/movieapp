part of 'pages.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetailPage> {
  MovieDetail movieDetail;
  List<Credit> credits;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GotoMainPageEvent());
          return;
        },
        child: Scaffold(
          body: FutureBuilder(
            future: MovieServices.getMovieDetail(widget.movie),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                movieDetail = snapshot.data;
              }
              return Stack(
                children: <Widget>[
                  Container(
                    color: accentColor1,
                  ),
                  SafeArea(
                    child: Container(color: Colors.white),
                  ),
                  ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 270,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(imageBaseUrl +
                                                "w1280" +
                                                widget.movie.backdropPath),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    height: 271,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment(0, 1),
                                            end: Alignment(0, 0.1),
                                            colors: [
                                          Colors.white,
                                          Colors.white.withOpacity(0)
                                        ])),
                                  )
                                ],
                              ),
                              // note: BACK ICON
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20, left: defaultMargin),
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black.withOpacity(0.04)),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .bloc<PageBloc>()
                                        .add(GotoMainPageEvent());
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 16, defaultMargin, 16),
                            child: Text(widget.movie.title,
                                textAlign: TextAlign.center,
                                style: blackTextFont.copyWith(fontSize: 24)),
                          ),
                          (snapshot.hasData)
                              ? Text(
                                  movieDetail.getGenreAndLanguage,
                                  style: greyTextFont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 6,
                          ),
                          RatingStar(
                            voteAverage: widget.movie.voteAverage,
                            color: accentColor3,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 24, defaultMargin, 16),
                            child: Text('Cast & Crew',
                                textAlign: TextAlign.left,
                                style: blackTextFont.copyWith(fontSize: 14)),
                          ),
                          FutureBuilder(
                            future: MovieServices.getCredits(widget.movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                credits = snapshot.data;
                                return SizedBox(
                                  height: 115,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder: (_, index) {
                                        return Container(
                                            margin: EdgeInsets.only(
                                                left: index == 0
                                                    ? defaultMargin
                                                    : 0,
                                                right:
                                                    index == credits.length - 1
                                                        ? defaultMargin
                                                        : 12),
                                            child: CreditCard(credits[index]));
                                      }),
                                );
                              } else {
                                return SizedBox(
                                  height: 50,
                                  child:
                                      SpinKitFadingCircle(color: accentColor2),
                                );
                              }
                            },
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 24, defaultMargin, 8),
                            child: Text('Storyline',
                                textAlign: TextAlign.left,
                                style: blackTextFont.copyWith(fontSize: 14)),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 30),
                            child: Text(widget.movie.overview,
                                textAlign: TextAlign.left,
                                style: greyTextFont.copyWith(fontSize: 14)),
                          ),
                          GestureDetector(
                            child: Container(
                              width: 250,
                              height: 45,
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 16, defaultMargin, 30),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: mainColor),
                              child: Text('Continue to Book',
                                  style: whiteTextFont.copyWith(fontSize: 16)),
                            ),
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GotoSelectSchedulePageEvent(movieDetail));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ));
  }
}
