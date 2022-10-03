part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistationDataModel registrationData;

  SignUpPage(this.registrationData, {super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeBloc>().add(
          ChangeThemeEvent(
            ThemeData().copyWith(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: accentColor2,
                primary: accentColor1,
              ),
            ),
          ),
        );
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPageEvent());
        if (Navigator.of(context).userGestureInProgress)
          return Future<bool>.value(true);
        else
          return Future<bool>.value(false);
      },
      child: Scaffold(
          body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: defaulMargin),
        child: ListView(children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 22),
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
                        "Create New\nAccount",
                        style: blackTextFont.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              profileImage(),
              const SizedBox(
                height: 36,
              ),
              textField(),
              const SizedBox(
                height: 30,
              ),
              button(),
            ],
          )
        ]),
      )),
    );
  }

  Widget profileImage() => Container(
        width: 90,
        height: 104,
        child: Stack(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: (widget.registrationData.profileImage == null)
                      ? const AssetImage("assets/user_pic.png")
                      : FileImage(widget.registrationData.profileImage!)
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  if (widget.registrationData.profileImage == null) {
                    XFile? img = await getImage();

                    if (img != null) {
                      File selectedImg = File(img.path);
                      widget.registrationData.profileImage = selectedImg;
                    } else {
                      widget.registrationData.profileImage = null;
                    }
                  } else {
                    widget.registrationData.profileImage = null;
                  }
                  setState(() {});
                },
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: (widget.registrationData.profileImage == null)
                          ? const AssetImage("assets/btn_add_photo.png")
                          : const AssetImage("assets/btn_del_photo.png"),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget textField() {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: "Full Name",
            hintText: "Full Name",
          ),
        ),
        const SizedBox(
          height: 16,
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
            // setState(
            //   () {
            //     isEmailValid = EmailValidator.validate(text);
            //   },
            // );
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
            // setState(() {
            //   isPasswordValid = value.length >= 6;
            // });
          },
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: retypePasswordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: "Confirm Password",
            hintText: "Confirm Password",
          ),
          onChanged: (value) {
            // setState(() {
            //   isPasswordValid = value.length >= 6;
            // });
          },
        ),
      ],
    );
  }

  Widget button() {
    return FloatingActionButton(
      backgroundColor: mainColor,
      elevation: 2,
      child: const Icon(Icons.arrow_forward),
      onPressed: () {
        if (!(nameController.text.trim() != "" &&
            emailController.text.trim() != "" &&
            passwordController.text.trim() != "" &&
            retypePasswordController.text.trim() != "")) {
          Flushbar(
            duration: const Duration(milliseconds: 1500),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: const Color(0xFFff5c83),
            message: "Please fill all the fields",
            // ignore: use_build_context_synchronously
          ).show(context);
        } else {
          widget.registrationData.name = nameController.text.trim();
          widget.registrationData.email = emailController.text.trim();
          widget.registrationData.password = passwordController.text.trim();

          context
              .read<PageBloc>()
              .add(GoToPreferencesPageEvent(widget.registrationData));
        }
      },
    );
  }
}
