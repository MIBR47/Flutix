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
  GoToRegistrationPageEvent(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToPreferencesPageEvent extends PageEvent {
  final RegistationDataModel registrationData;
  GoToPreferencesPageEvent(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToAccountInformationPageEvent extends PageEvent {
  final RegistationDataModel registrationData;
  GoToAccountInformationPageEvent(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToMainPageEvent extends PageEvent {
  @override
  List<Object> get props => [];
}
