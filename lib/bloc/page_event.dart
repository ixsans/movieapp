part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GotoSplashPageEvent extends PageEvent {
  @override
  List<Object> get props => [];
}

class GotoLoginPageEvent extends PageEvent {
  @override
  List<Object> get props => [];
}

class GotoMainPageEvent extends PageEvent {
  final int bottomNavBarIndex;
  final bool isExpired;

  GotoMainPageEvent({this.bottomNavBarIndex = 0, this.isExpired = false});

  @override
  List<Object> get props => [bottomNavBarIndex, isExpired];
}

class GotoRegistrationPageEvent extends PageEvent {
  final RegistrationData registrationData;

  GotoRegistrationPageEvent(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class GotoPreferencePageEvent extends PageEvent {
  final RegistrationData registrationData;

  GotoPreferencePageEvent(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class GotoAccountConfirmationPageEvent extends PageEvent {
  final RegistrationData registrationData;
  GotoAccountConfirmationPageEvent(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class GotoMovieDetailPageEvent extends PageEvent {
  final Movie movie;
  GotoMovieDetailPageEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class GotoSelectSchedulePageEvent extends PageEvent {
  final MovieDetail movieDetail;

  GotoSelectSchedulePageEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class GotoChooseSeatPageEvent extends PageEvent {
  final Ticket ticket;

  GotoChooseSeatPageEvent(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GotoCheckoutPageEvent extends PageEvent {
  final Ticket ticket;

  GotoCheckoutPageEvent(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GotoSuccessCheckoutPageEvent extends PageEvent {
  final Ticket ticket;
  final MovieTransaction transaction;

  GotoSuccessCheckoutPageEvent(this.ticket, this.transaction);

  @override
  List<Object> get props => [ticket, transaction];
}

class GotoTicketDetailPageEvent extends PageEvent {
  final Ticket ticket;

  GotoTicketDetailPageEvent(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GotoProfilePageEvent extends PageEvent {
  final User user;

  GotoProfilePageEvent(this.user);

  @override
  List<Object> get props => [user];
}

class GotoEditProfilePageEvent extends PageEvent {
  final User user;

  GotoEditProfilePageEvent(this.user);

  @override
  List<Object> get props => [user];
}

class GotoTopupPageEvent extends PageEvent {
  final PageEvent pageEvent;

  GotoTopupPageEvent(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

class GotoMyWalletPageEvent extends PageEvent {
  final PageEvent pageEvent;

  GotoMyWalletPageEvent(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}
