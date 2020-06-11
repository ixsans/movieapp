part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData().copyWith(primaryColor: accentColor2);
    context.bloc<ThemeBloc>().add(ChangeTheme(themeData));
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GotoSplashPageEvent());
        return;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        child: Image.asset("assets/logo.png"),
                        height: 70,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 70, bottom: 40),
                        child: Text(
                          'Welcome Back,\nExplorer',
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                      ),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            isEmailValid = EmailValidator.validate(text);
                          });
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Email Address',
                            hintText: 'Email Address'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: passwordController,
                        onChanged: (text) {
                          setState(() {
                            isPasswordValid = text.length >= 6;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Password',
                            hintText: 'Password'),
                      ),
                      Row(
                        children: <Widget>[
                          Text('Forgot Password? ',
                              style: greyTextFont.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                          Text('Get Now',
                              style: purpleTextFont.copyWith(fontSize: 12)),
                        ],
                      ),
                      Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 40, bottom: 30),
                          child: isSigningIn
                              ? SpinKitCircle(
                                  color: mainColor,
                                )
                              : FloatingActionButton(
                                  elevation: 0,
                                  child: Icon(Icons.arrow_forward),
                                  backgroundColor:
                                      (isEmailValid && isPasswordValid)
                                          ? mainColor
                                          : Color(0xFFE4E4E4),
                                  onPressed: (isEmailValid && isPasswordValid)
                                      ? () async {
                                          setState(() {
                                            isSigningIn = true;
                                          });

                                          SignInSignUpResult result =
                                              await AuthServices.signIn(
                                                  emailController.text,
                                                  passwordController.text);
                                          if (result.user == null) {
                                            setState(() {
                                              isSigningIn = false;
                                            });

                                            Flushbar(
                                              duration: Duration(seconds: 4),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              backgroundColor:
                                                  Color(0xFFFF5C83),
                                              message: result.message,
                                            )..show(context);
                                          }
                                        }
                                      : null,
                                ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text('Start Fresh Now? ',
                              style: greyTextFont.copyWith(
                                  fontWeight: FontWeight.w400)),
                          Text('Sign Up? ', style: purpleTextFont),
                        ],
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}

// Center(
//         child: RaisedButton(
//           child: Text('Sign In'),
//           onPressed: () {
//             AuthServices.signIn('ikhsan@mail.com', '123456');
//           },
//         ),
//       ),
