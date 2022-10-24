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
  @override
  List<Object> get props => [];
}

class OnMovieDetailPageState extends PageState {
  final MovieModel movie;
  const OnMovieDetailPageState(this.movie);
  @override
  List<Object> get props => [movie];
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
  const OnSuccessTopupPageState(this.transaction);
  @override
  List<Object> get props => [transaction];
}
