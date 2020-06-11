part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    if (user == null) {
      if (!(prevPageEvent is GotoSplashPageEvent)) {
        prevPageEvent = GotoSplashPageEvent();
        context.bloc<PageBloc>().add(GotoSplashPageEvent());
      }
    } else {
      if (!(prevPageEvent is GotoMainPageEvent)) {
        String userId = user.uid;
        context.bloc<UserBloc>().add(LoadUser(userId));
        context.bloc<TicketBloc>().add(GetTickets(userId));

        prevPageEvent = GotoMainPageEvent();
        context.bloc<PageBloc>().add(GotoMainPageEvent());
      }
    }
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage
            ? SplashPage()
            : pageState is OnSignInPage
                ? SignInPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage(pageState.registrationData)
                    : (pageState is OnPreferencePage)
                        ? PreferencePage(pageState.registrationData)
                        : (pageState is OnAccountConfirmationPage)
                            ? AccountConfirmationPage(
                                pageState.registrationData)
                            : (pageState is OnMovieDetailPage)
                                ? MovieDetailPage(pageState.movie)
                                : (pageState is OnSelectSchedulePage
                                    ? SelectSchedulePage(pageState.movieDetail)
                                    : (pageState is OnChooseSeatPage)
                                        ? ChooseSeatPage(pageState.ticket)
                                        : (pageState is OnCheckoutPage)
                                            ? CheckoutPage(pageState.ticket)
                                            : (pageState is OnSuccessCheckoutPage)
                                                ? SuccessPage(pageState.ticket,
                                                    pageState.transaction)
                                                : (pageState is OnTicketDetailPage)
                                                    ? TicketDetailPage(
                                                        pageState.ticket)
                                                    : (pageState is OnProfilePage
                                                        ? ProfilePage(
                                                            pageState.user)
                                                        : (pageState
                                                                is OnEditProfilePage)
                                                            ? EditProfilePage(
                                                                pageState.user)
                                                            : (pageState
                                                                    is OnTopupPage)
                                                                ? TopupPage(
                                                                    pageState
                                                                        .pageEvent)
                                                                : (pageState
                                                                        is OnMyWalletPage)
                                                                    ? MyWalletPage(
                                                                        pageState.pageEvent)
                                                                    : MainPage(bottomNavBarIndex: (pageState as OnMainPage).bottomNavBarIndex, isExpired: (pageState as OnMainPage).isExpired)))));
  }
}
