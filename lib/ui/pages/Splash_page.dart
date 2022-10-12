// ignore_for_file: file_names

part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 136,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.png")),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 70,
                bottom: 16,
              ),
              child: Text(
                "New Experience",
                style: blackTextFont.copyWith(fontSize: 20),
              ),
            ),
            Text(
              "Watch a new movie much\neasier than any before",
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Container(
              width: 250,
              height: 46,
              margin: const EdgeInsets.only(
                top: 70,
                bottom: 19,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                ),
                onPressed: () async {
                  context
                      .read<PageBloc>()
                      .add(GoToRegistrationPageEvent(RegistationDataModel()));

                  // SignInSignUpResult result = await AuthServices.singUp(
                  //   "ilham@gmail.com",
                  //   "12345678",
                  //   "Ilham",
                  //   ["Action", "Superhero", "Drama"],
                  //   "Korean",
                  // );
                  // if (result.user == null) {
                  //   print(result.message?.message.toString());
                  //   print("error");
                  // } else {
                  //   print(result.user.toString());
                  // }
                },
                child: const Text("Get Started"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: greyTextFont.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<PageBloc>().add(GoToLoginPageEvent());
                  },
                  child: Text(
                    " Sign In",
                    style: purpleTextFont.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
