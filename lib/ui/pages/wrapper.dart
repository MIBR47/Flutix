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

    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) => (pageState is OnSplashPageState)
          ? const SplashPage()
          : (pageState is OnLoginPageState)
              ? const SignInPage()
              : (pageState is OnRegistrationPageState)
                  ? SignUpPage(pageState.registrationData)
                  : (pageState is OnPreferencesPageState)
                      ? PreferencesPage(
                          registrationData: pageState.registrationData)
                      : (pageState is OnAccountInformationPageState)
                          ? AccountConfirmationPage(
                              registrationData: pageState.registrationData)
                          : (pageState is OnMovieDetailPageState)
                              ? MovieDetailPage(pageState.movie)
                              : const MainPage(),
    );
  }
}
