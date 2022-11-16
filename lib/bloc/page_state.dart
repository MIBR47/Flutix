part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPageState extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPageState extends PageState {
  @override
  List<Object> get props => [];
}

class OnRegistrationPageState extends PageState {
  final RegistationDataModel registrationData;
  const OnRegistrationPageState(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnPreferencesPageState extends PageState {
  final RegistationDataModel registrationData;
  const OnPreferencesPageState(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnAccountInformationPageState extends PageState {
  final RegistationDataModel registrationData;
  const OnAccountInformationPageState(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnSplashPageState extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPageState extends PageState {
  final int bottomNavBarIndex;
  final bool isExpired;
  OnMainPageState({this.bottomNavBarIndex = 0, this.isExpired = false});

  @override
  List<Object> get props => [bottomNavBarIndex, isExpired];
}

class OnProfilePageState extends PageState {
  const OnProfilePageState();

  @override
  List<Object> get props => [];
}

class OnMovieDetailPageState extends PageState {
  final MovieModel movie;
  const OnMovieDetailPageState(this.movie);
  @override
  List<Object> get props => [movie];
}

class OnTicketDetailPageState extends PageState {
  final TicketModel ticket;
  const OnTicketDetailPageState(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class OnSelectSchedulePageState extends PageState {
  final MovieDetailModel movieDetail;
  const OnSelectSchedulePageState(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}

class OnSelectSeatPageState extends PageState {
  final TicketModel ticket;
  const OnSelectSeatPageState(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class OnCheckOutPageState extends PageState {
  final TicketModel ticket;
  const OnCheckOutPageState(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class OnSuccessPageState extends PageState {
  final TicketModel ticket;
  final FlutixTransactionModel transaction;

  const OnSuccessPageState(this.ticket, this.transaction);
  @override
  List<Object> get props => [ticket, transaction];
}

class OnSuccessTopupPageState extends PageState {
  final FlutixTransactionModel transaction;
  final PageEvent pageEvent;

  const OnSuccessTopupPageState(this.transaction, this.pageEvent);
  @override
  List<Object> get props => [transaction, pageEvent];
}

class OnTopupPageState extends PageState {
  final PageEvent pageEvent;
  const OnTopupPageState(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class OnWalletPageState extends PageState {
  final PageEvent pageEvent;

  const OnWalletPageState(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}
