part of 'pages.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GotoMainPageEvent());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: accentColor1),
            SafeArea(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: 8),
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GotoMainPageEvent());
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
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: user.profilePicture != null
                                    ? NetworkImage(user.profilePicture)
                                    : AssetImage('assets/user_pic.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(user.name,
                              style: blackTextFont.copyWith(fontSize: 18)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(user.email,
                              style: greyTextFont.copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('xxx');
                        context
                            .bloc<PageBloc>()
                            .add(GotoEditProfilePageEvent(user));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 30, defaultMargin, 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/edit_profile.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Edit Profile',
                              style: blackTextFont.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: generateDashedDivider(
                          MediaQuery.of(context).size.width -
                              2 * defaultMargin),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(
                            GotoMyWalletPageEvent(GotoProfilePageEvent(user)));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, defaultMargin, 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/my_wallet.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'My Wallet',
                              style: blackTextFont.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: generateDashedDivider(
                          MediaQuery.of(context).size.width -
                              3 * defaultMargin),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, defaultMargin, 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/language.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Change Language',
                              style: blackTextFont.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: generateDashedDivider(
                          MediaQuery.of(context).size.width -
                              2 * defaultMargin),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, defaultMargin, 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/help_centre.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Help Center',
                              style: blackTextFont.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: generateDashedDivider(
                          MediaQuery.of(context).size.width -
                              2 * defaultMargin),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, defaultMargin, 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/rate.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Rate App',
                              style: blackTextFont.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: generateDashedDivider(
                          MediaQuery.of(context).size.width -
                              2 * defaultMargin),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.bloc<UserBloc>().add(SignOut());
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, defaultMargin, 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/rate.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sign Out',
                              style: blackTextFont.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: generateDashedDivider(
                          MediaQuery.of(context).size.width -
                              2 * defaultMargin),
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
