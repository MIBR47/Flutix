// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnSplashPageState()) {
    // on<PageEvent>((event, emit) async* {
    //   if (event is GoToSplashPageEvent) {
    //     emit(OnSplashPageState());
    //   } else if (event is GoToLoginPageEvent) {
    //     emit(OnLoginPageState());
    //   } else if (event is GoToMainPageEvent) {
    //     emit(OnMainPageState());
    //   }
    // });
    on<GoToSplashPageEvent>(
      (event, emit) => emit(OnSplashPageState()),
    );
    on<GoToLoginPageEvent>(
      (event, emit) => emit(OnLoginPageState()),
    );
    on<GoToRegistrationPageEvent>(
      (event, emit) => emit(OnRegistrationPageState(event.registrationData)),
    );
    on<GoToPreferencesPageEvent>(
      (event, emit) => emit(OnPreferencesPageState(event.registrationData)),
    );
    on<GoToAccountInformationPageEvent>(
      (event, emit) =>
          emit(OnAccountInformationPageState(event.registrationData)),
    );
    on<GoToMainPageEvent>(
      (event, emit) => emit(OnMainPageState()),
    );
    on<GotoMovieDetailPageEvent>(
      (event, emit) => emit(OnMovieDetailPageState(event.movie)),
    );
  }
}
