part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;
  final List<String> genres = [
    "Drama",
    "War",
    "Action",
    "Music",
    "Horor",
    "Crime",
  ];
  final List<String> languages = ["English", "Arabic", "Indonesia", "Japanish"];

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = '';
        context
            .bloc<PageBloc>()
            .add(GotoRegistrationPageEvent(widget.registrationData));
        return;
      },
      child: Scaffold(
          body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 56,
                  margin: EdgeInsets.only(top: 20, bottom: 4),
                  child: GestureDetector(
                    onTap: () {
                      context.bloc<PageBloc>().add(
                          GotoRegistrationPageEvent(widget.registrationData));
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Text('Select Your Four\nFavorite Generes',
                    style: blackTextFont.copyWith(fontSize: 20)),
                SizedBox(height: 16),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: generateGenereWidgets(context),
                ),
                SizedBox(height: 24),
                Text('Movie Language\nYou Prever',
                    style: blackTextFont.copyWith(fontSize: 20)),
                SizedBox(height: 16),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: generateLangWidgets(context),
                ),
                SizedBox(height: 30),
                Center(
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: mainColor,
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (selectedGenres.length != 4) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Please select 4 genres",
                        )..show(context);
                      } else {
                        widget.registrationData.selectedGenres = selectedGenres;
                        widget.registrationData.selectedLang = selectedLang;

                        context.bloc<PageBloc>().add(
                            GotoAccountConfirmationPageEvent(
                                widget.registrationData));
                      }
                    },
                  ),
                ),
                SizedBox(height: 50),
              ],
            )
          ],
        ),
      )),
    );
  }

  List<String> selectedGenres = [];

  List<Widget> generateGenereWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;
    return widget.genres
        .map((e) => SelectableBox(
              e,
              isSelected: selectedGenres.contains(e),
              width: width,
              onTap: () {
                if (selectedGenres.contains(e)) {
                  setState(() {
                    selectedGenres.remove(e);
                  });
                } else {
                  if (selectedGenres.length < 4) {
                    setState(() {
                      selectedGenres.add(e);
                    });
                  }
                }
              },
            ))
        .toList();
  }

  String selectedLang = 'English';

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;
    return widget.languages
        .map((e) => SelectableBox(
              e,
              isSelected: selectedLang == e,
              width: width,
              onTap: () {
                if (selectedLang == e) {
                  setState(() {
                    selectedLang = null;
                  });
                } else {
                  setState(() {
                    selectedLang = e;
                  });
                }
              },
            ))
        .toList();
  }
}
