// ignore_for_file: null_check_always_fails

part of 'pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeBloc>().add(
          ChangeThemeEvent(
            ThemeData().copyWith(
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: accentColor2, primary: accentColor2),
            ),
          ),
        );
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPageEvent());
        if (Navigator.of(context).userGestureInProgress) {
          return null!;
        } else {
          return null!;
        }
        // return null!;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 70,
                      child: Image.asset("assets/logo.png"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                        top: 70,
                        bottom: 16,
                      ),
                      child: Text(
                        "Welcome Back\nExplorer",
                        style: blackTextFont.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email Address",
                        hintText: "Email Address",
                      ),
                      onChanged: (text) {
                        setState(
                          () {
                            isEmailValid = EmailValidator.validate(text);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password",
                        hintText: "Password",
                      ),
                      onChanged: (value) {
                        setState(() {
                          isPasswordValid = value.length >= 6;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot Password ?",
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(GoToLoginPageEvent());
                          },
                          child: Text(
                            " Get Now",
                            style: purpleTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      margin: const EdgeInsets.only(top: 40, bottom: 30),
                      child: FloatingActionButton(
                        onPressed: isEmailValid && isPasswordValid
                            ? () async {
                                setState(() {
                                  isSignIn = true;
                                });
                                SignInSignUpResult result =
                                    await AuthServices.signIn(
                                        emailController.text,
                                        passwordController.text);
                                if (result.user == null) {
                                  setState(() {
                                    isSignIn = false;
                                  });
                                  // ignore: avoid_single_cascade_in_expression_statements
                                  Flushbar(
                                    duration: const Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: const Color(0xFFff5c83),
                                    message: result.message!.message!.trim(),
                                    // ignore: use_build_context_synchronously
                                  )..show(context);
                                }
                              }
                            : null,
                        backgroundColor: isEmailValid && isPasswordValid
                            ? mainColor
                            : const Color.fromARGB(255, 175, 174, 174),
                        child: isSignIn
                            ? const SpinKitRing(
                                color: Colors.white,
                                size: 40,
                              )
                            : Icon(
                                Icons.arrow_forward,
                                color: isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : const Color.fromARGB(255, 117, 115, 115),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Start Fresh Now?",
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(GoToLoginPageEvent());
                          },
                          child: Text(
                            " Sign Up",
                            style: purpleTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     SignInSignUpResult result = await AuthServices.signIn(
                    //       "ilham@gmail.com",
                    //       "12345678",
                    //     );
                    //     if (result.user == null) {
                    //       print(result.message?.message.toString());
                    //       print("error");
                    //     } else {
                    //       print(result.user.toString());
                    //     }
                    //   },
                    //   child: const Text('Sign In'),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
