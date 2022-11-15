part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPageEvent extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPageEvent extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRegistrationPageEvent extends PageEvent {
  final RegistationDataModel registrationData;
  const GoToRegistrationPageEvent(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToPreferencesPageEvent extends PageEvent {
  final RegistationDataModel registrationData;
  const GoToPreferencesPageEvent(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToAccountInformationPageEvent extends PageEvent {
  final RegistationDataModel registrationData;
  const GoToAccountInformationPageEvent(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToMainPageEvent extends PageEvent {
  final int bottomNavBarIndex;
  final bool isExpired;
  GoToMainPageEvent({this.bottomNavBarIndex = 0, this.isExpired = false});

  @override
  List<Object> get props => [bottomNavBarIndex, isExpired];
}

class GotoProfilePageEvent extends PageEvent {
  const GotoProfilePageEvent();
  @override
  List<Object> get props => [];
}

class GotoMovieDetailPageEvent extends PageEvent {
  final MovieModel movie;
  const GotoMovieDetailPageEvent(this.movie);
  @override
  List<Object> get props => [movie];
}

class GotoTicketDetailPageEvent extends PageEvent {
  final TicketModel ticket;
  const GotoTicketDetailPageEvent(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToSelectSchedulePageEvent extends PageEvent {
  final MovieDetailModel movieDetail;
  const GoToSelectSchedulePageEvent(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}

class GoToSelectSeatPageEvent extends PageEvent {
  final TicketModel ticket;
  const GoToSelectSeatPageEvent(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToCheckoutPageEvent extends PageEvent {
  final TicketModel ticket;
  const GoToCheckoutPageEvent(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToSuccessPageEvent extends PageEvent {
  final TicketModel ticket;
  final FlutixTransactionModel transaction;
  const GoToSuccessPageEvent(this.ticket, this.transaction);
  @override
  List<Object> get props => [ticket, transaction];
}

class GoToSuccessTopupPageEvent extends PageEvent {
  final FlutixTransactionModel transaction;
  const GoToSuccessTopupPageEvent(this.transaction);
  @override
  List<Object> get props => [transaction];
}
