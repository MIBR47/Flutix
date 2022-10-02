import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeData(primaryColor: accentColor2))) {
    on<ChangeThemeEvent>((event, emit) {
      emit(ThemeState(event.themeData));
    });
    // @override
    // Stream<ThemeState> on<ChangeThemeEvent>(event, emit) async* {
    //   emit(ThemeState(event.themeData));
    // }

    //    on<GoToSplashPageEvent>(
    //   (event, emit) => emit(OnSplashPageState()),
    // );
  }
}
