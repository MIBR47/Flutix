part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  final ThemeData themeData;
  const ChangeThemeEvent(this.themeData);

  @override
  List<Object> get props => [themeData];
}
