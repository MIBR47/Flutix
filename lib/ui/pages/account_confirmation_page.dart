part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistationDataModel registrationData;
  const AccountConfirmationPage({super.key, required this.registrationData});

  @override
  State<AccountConfirmationPage> createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  SignInSignUpResult? result;
  bool isSignUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context
            .read<PageBloc>()
            .add(GoToPreferencesPageEvent(widget.registrationData));
        if (Navigator.of(context).userGestureInProgress)
          return Future<bool>.value(true);
        else
          return Future<bool>.value(false);
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaulMargin),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 90),
                height: 56,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(GoToSplashPageEvent());
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Confirm New\nAccount",
                        style: blackTextFont.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                width: 150,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: (widget.registrationData.profileImage == null)
                        ? const AssetImage("assets/user_pic.png")
                        : FileImage(widget.registrationData.profileImage!)
                            as ImageProvider,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Text(
                "Welcome",
                style: blackTextFont.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.registrationData.name,
                style: blackTextFont.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 120,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3E9D9D),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: (isSignUp == true)
                            ? const SpinKitRing(
                                color: Colors.white,
                                size: 40,
                              )
                            : Text("Create New Account"),
                        onPressed: () async {
                          setState(() {
                            isSignUp = true;
                          });
                          SignInSignUpResult result = await AuthServices.singUp(
                            widget.registrationData.email,
                            widget.registrationData.password,
                            widget.registrationData.name,
                            widget.registrationData.selectedGenres,
                            widget.registrationData.selectedLang,
                          );
                          imageFileToUpload =
                              widget.registrationData.profileImage;
                          if (!mounted) return;
                          if (result.user == null) {
                            setState(() {
                              isSignUp = false;
                            });
                            Flushbar(
                              duration: const Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: const Color(0xFFff5c83),
                              message: "Please select 4 genres",
                              // ignore: use_build_context_synchronously
                            ).show(context);
                          } else {
                            print(result.user.toString());
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyCustomClass {
//   const MyCustomClass();

//   Future<void> myAsyncMethod(BuildContext context,
//       RegistationDataModel registrationData, VoidCallback onSuccess) async {
//    result = await AuthServices.singUp(
//       registrationData.email,
//       registrationData.password,
//       registrationData.name,
//       registrationData.selectedGenres,
//       registrationData.selectedLang,
//     );
//     set
//     await Future.delayed(const Duration(seconds: 2));
//     onSuccess.call();
//     // return result;
//   }
// }
