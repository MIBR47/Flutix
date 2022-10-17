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
  @override
  List<Object> get props => [];
}

class GotoMovieDetailPageEvent extends PageEvent {
  final MovieModel movie;
  const GotoMovieDetailPageEvent(this.movie);
  @override
  List<Object> get props => [movie];
}

class GoToSelectSchedulePageEvent extends PageEvent {
  final MovieDetailModel movieDetail;
  const GoToSelectSchedulePageEvent(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}
