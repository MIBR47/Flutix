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
      (event, emit) => emit(OnAccountInformationPageState(event.registrationData)),
    );
    on<GoToMainPageEvent>(
      (event, emit) => emit(OnMainPageState(bottomNavBarIndex: event.bottomNavBarIndex, isExpired: event.isExpired)),
    );
    on<GotoProfilePageEvent>(
      (event, emit) => emit(const OnProfilePageState()),
    );

    on<GotoEditProfilePageEvent>(
      (event, emit) => emit(OnEdiProfilePageState(event.user)),
    );
    on<GotoMovieDetailPageEvent>(
      (event, emit) => emit(OnMovieDetailPageState(event.movie)),
    );
    on<GotoTicketDetailPageEvent>(
      (event, emit) => emit(OnTicketDetailPageState(event.ticket)),
    );
    on<GoToSelectSchedulePageEvent>(
      (event, emit) => emit(OnSelectSchedulePageState(event.movieDetail)),
    );
    on<GoToSelectSeatPageEvent>(
      (event, emit) => emit(OnSelectSeatPageState(event.ticket)),
    );
    on<GoToCheckoutPageEvent>(
      (event, emit) => emit(OnCheckOutPageState(event.ticket)),
    );

    on<GoToSuccessPageEvent>(
      (event, emit) => emit(OnSuccessPageState(event.ticket, event.transaction)),
    );

    on<GoToSuccessTopupPageEvent>(
      (event, emit) => emit(OnSuccessTopupPageState(event.transaction, event.pageEvent)),
    );
    on<GoToTopupPageEvent>(
      (event, emit) => emit(OnTopupPageState(event.pageEvent)),
    );
    on<GoToWalletPageEvent>(
      (event, emit) => emit(OnWalletPageState(event.pageEvent)),
    );
  }
}
