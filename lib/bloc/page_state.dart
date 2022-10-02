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
  OnRegistrationPageState(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnPreferencesPageState extends PageState {
  final RegistationDataModel registrationData;
  OnPreferencesPageState(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnAccountInformationPageState extends PageState {
  final RegistationDataModel registrationData;
  OnAccountInformationPageState(this.registrationData);
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
