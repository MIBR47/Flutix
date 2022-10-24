part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);
    if (firebaseUser == null) {
      // return SignInPage();
      if (prevPageEvent is! GoToSplashPageEvent) {
        prevPageEvent = GoToSplashPageEvent();
        // context.watch<PageBloc>().add(prevPageEvent);
        context.read<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (prevPageEvent is! GoToMainPageEvent) {
        context.read<UserBloc>().add(LoadUserEvent(firebaseUser.uid));

        prevPageEvent = GoToMainPageEvent();
        // context.watch<PageBloc>().add(prevPageEvent);
        context.read<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(builder: (_, pageState) {
      if (pageState is OnSplashPageState) {
        return const SplashPage();
      } else if (pageState is OnLoginPageState) {
        return const SignInPage();
      } else if (pageState is OnRegistrationPageState) {
        return SignUpPage(pageState.registrationData);
      } else if (pageState is OnPreferencesPageState) {
        return PreferencesPage(registrationData: pageState.registrationData);
      } else if (pageState is OnAccountInformationPageState) {
        return AccountConfirmationPage(registrationData: pageState.registrationData);
      } else if (pageState is OnMovieDetailPageState) {
        return MovieDetailPage(pageState.movie);
      } else if (pageState is OnSelectSchedulePageState) {
        return SelectSchedulePage(pageState.movieDetail);
      } else if (pageState is OnSelectSeatPageState) {
        return SelectSeatPage(pageState.ticket);
      } else if (pageState is OnCheckOutPageState) {
        return CheckoutPage(pageState.ticket);
      } else if (pageState is OnSuccessPageState) {
        return SuccessPage(pageState.ticket, pageState.transaction);
      } else {
        return const MainPage();
      }
    });
  }
}


// => (pageState is OnSplashPageState)
//           ? const SplashPage()
//           : (pageState is OnLoginPageState)
//               ? const SignInPage()
//               : (pageState is OnRegistrationPageState)
//                   ? SignUpPage(pageState.registrationData)
//                   : (pageState is OnPreferencesPageState)
//                       ? PreferencesPage(
//                           registrationData: pageState.registrationData)
//                       : (pageState is OnAccountInformationPageState)
//                           ? AccountConfirmationPage(
//                               registrationData: pageState.registrationData)
//                           : (pageState is OnMovieDetailPageState)
//                               ? MovieDetailPage(pageState.movie)
//                               : (pageState is OnSelectSchedulePageState)
//                                   ? SelectSchedulePage(pageState.movieDetail)
//                                   : (pageState is OnSelectSeatPageState)
//                                       ? SelectSeatPage(pageState.ticket)
//                                       : (pageState is OnCheckOutPageState)
//                                           ? CheckoutPage(pageState.ticket)
//                                           : const MainPage(),