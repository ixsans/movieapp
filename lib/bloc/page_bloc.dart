import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GotoSplashPageEvent) {
      yield OnSplashPage();
    } else if (event is GotoLoginPageEvent) {
      yield OnSignInPage();
    } else if (event is GotoMainPageEvent) {
      yield OnMainPage(
          bottomNavBarIndex: event.bottomNavBarIndex,
          isExpired: event.isExpired);
    } else if (event is GotoRegistrationPageEvent) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GotoPreferencePageEvent) {
      yield OnPreferencePage(event.registrationData);
    } else if (event is GotoAccountConfirmationPageEvent) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GotoMovieDetailPageEvent) {
      yield OnMovieDetailPage(event.movie);
    } else if (event is GotoSelectSchedulePageEvent) {
      yield OnSelectSchedulePage(event.movieDetail);
    } else if (event is GotoChooseSeatPageEvent) {
      yield OnChooseSeatPage(event.ticket);
    } else if (event is GotoCheckoutPageEvent) {
      yield OnCheckoutPage(event.ticket);
    } else if (event is GotoSuccessCheckoutPageEvent) {
      yield OnSuccessCheckoutPage(event.ticket, event.transaction);
    } else if (event is GotoTicketDetailPageEvent) {
      yield OnTicketDetailPage(event.ticket);
    } else if (event is GotoProfilePageEvent) {
      yield OnProfilePage(event.user);
    } else if (event is GotoEditProfilePageEvent) {
      yield OnEditProfilePage(event.user);
    } else if (event is GotoTopupPageEvent) {
      yield OnTopupPage(event.pageEvent);
    } else if (event is GotoMyWalletPageEvent) {
      yield OnMyWalletPage(event.pageEvent);
    }
  }
}
