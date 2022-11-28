part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? nameController;
  String? profilePath;
  bool isDataEdited = false;
  XFile? profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture!;
  }

  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeThemeEvent(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(const GotoProfilePageEvent());
        if (Navigator.of(context).userGestureInProgress) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Edit Your\nProfile",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 22, bottom: 10),
                        width: 90,
                        height: 104,
                        child: Stack(
                          children: <Widget>[
                            Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: (profileImageFile != null)
                                            ? FileImage(File(profileImageFile!.path))
                                            : (profilePath == "" || profilePath == null)
                                                ? const AssetImage("assets/user_pic.png")
                                                : NetworkImage(profilePath!) as ImageProvider,
                                        fit: BoxFit.cover))),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  if (profilePath == "") {
                                    // profileImageFile = await getImage();

                                    // if (profileImageFile != null) {
                                    //   profilePath = basename(profileImageFile.path);
                                    // }
                                    profileImageFile = await getImage();

                                    if (profileImageFile != null) {
                                      File selectedImg = File(profileImageFile!.path);
                                      profilePath = selectedImg.path;
                                    } else {
                                      profilePath = null;
                                    }
                                  } else {
                                    profileImageFile = null;
                                    profilePath = "";
                                  }

                                  setState(() {
                                    isDataEdited =
                                        (nameController!.text.trim() != widget.user.name || profilePath != widget.user.profilePicture) ? true : false;
                                  });
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(image: AssetImage((profilePath == "") ? "assets/btn_add_photo.png" : "assets/btn_del_photo.png"))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      AbsorbPointer(
                        child: TextField(
                          controller: TextEditingController(text: widget.user.id),
                          style: whiteNumberFont.copyWith(color: accentColor3),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "User ID",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AbsorbPointer(
                        child: TextField(
                          controller: TextEditingController(text: widget.user.email),
                          style: greyTextFont,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "Email Address",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: nameController,
                        onChanged: (text) {
                          setState(() {
                            isDataEdited = (text.trim() != widget.user.name || profilePath != widget.user.profilePicture) ? true : false;
                          });
                        },
                        style: blackTextFont,
                        decoration:
                            InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), labelText: "Full Name", hintText: "Full Name"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 250,
                        height: 45,
                        child: ElevatedButton(
                            // elevation: 0,
                            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                              disabledBackgroundColor: const Color(0xFFE4E4E4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            // disabledColor: Color(0xFFE4E4E4),
                            // color: Colors.red[400],
                            onPressed: (isUpdating)
                                ? null
                                : () async {
                                    Flushbar(
                                      duration: const Duration(milliseconds: 2000),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: const Color(0xFFFF5C83),
                                      message: "The link to change your password has been sent to your email.",
                                    ).show(context);
                                    await AuthServices.resetPassword(widget.user.email);
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(
                                  MdiIcons.alertCircle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Change Password",
                                  style: whiteTextFont.copyWith(fontSize: 16, color: (isUpdating) ? const Color(0xFFBEBEBE) : Colors.white),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  MdiIcons.alertCircle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      (isUpdating)
                          ? const SizedBox(
                              width: 50,
                              height: 50,
                              child: SpinKitFadingCircle(
                                color: Color(0xFF3E9D9D),
                              ),
                            )
                          : SizedBox(
                              width: 250,
                              height: 45,
                              child: ElevatedButton(
                                  // elevation: 0,
                                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3E9D9D),
                                    disabledBackgroundColor: const Color(0xFFE4E4E4),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text(
                                    "Update My Profile",
                                    style: whiteTextFont.copyWith(fontSize: 16, color: (isDataEdited) ? Colors.white : const Color(0xFFBEBEBE)),
                                  ),
                                  // disabledColor: const Color(0xFFE4E4E4),
                                  // color: const Color(0xFF3E9D9D),
                                  onPressed: (isDataEdited)
                                      ? () async {
                                          setState(() {
                                            isUpdating = true;
                                          });
                                          if (profileImageFile != null) {
                                            await _uploadphoto(context, profileImageFile!).then((downloadURL) {
                                              context.read<UserBloc>().add(UpdateDataEvent(name: nameController!.text, profileImage: downloadURL));
                                              context.read<PageBloc>().add(const GotoProfilePageEvent());
                                            });
                                          } else {
                                            context.read<UserBloc>().add(UpdateDataEvent(name: nameController!.text));
                                            context.read<PageBloc>().add(const GotoProfilePageEvent());
                                          }
                                        }
                                      : null),
                            )
                    ],
                  )
                ],
              ),
            ),
            SafeArea(
                child: Container(
              margin: const EdgeInsets.only(top: 20, left: defaultMargin),
              child: GestureDetector(
                onTap: () {
                  context.read<PageBloc>().add(const GotoProfilePageEvent());
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<String?> _uploadphoto(BuildContext context, XFile profileImageFile) async {
    String path = await uploadImage(File(profileImageFile.path));
    return path;
  }
}
