part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? bottomNavBarIndex;
  PageController? pageController;
  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(
              color: const Color(0xffF6F7F9),
            ),
          ),
          pageView(),
          createCustomBottomnNavbar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 45,
              width: 46,
              margin: const EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 1,
                backgroundColor: accentColor2,
                child: Container(
                  child: Icon(
                    MdiIcons.walletPlus,
                    color: Colors.black.withOpacity(0.54),
                  ),
                ),
                onPressed: () async {
                  context.read<UserBloc>().add(SignOutEvent());
                  AuthServices.signOut();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget pageView() => PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: ((index) {
          bottomNavBarIndex = index;
        }),
        children: const [
          Center(
            child: MoviePage(),
          ),
          Center(
            child: Text("My Tickets"),
          ),
        ],
      );

  Widget createCustomBottomnNavbar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: mainColor,
              unselectedItemColor: const Color(0xffE5E5E5),
              currentIndex: bottomNavBarIndex!,
              selectedLabelStyle: GoogleFonts.raleway(
                  fontSize: 13, fontWeight: FontWeight.w600),
              unselectedLabelStyle: GoogleFonts.raleway(
                  fontSize: 13, fontWeight: FontWeight.w600),
              onTap: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                  pageController?.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: "New Movies",
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset((bottomNavBarIndex == 0)
                        ? "assets/ic_movie.png"
                        : "assets/ic_movie_grey.png"),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "My Tickets",
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset((bottomNavBarIndex == 1)
                        ? "assets/ic_tickets.png"
                        : "assets/ic_tickets_grey.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
// Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             BlocBuilder<UserBloc, UserState>(
//               builder: (context, state) {
//                 return (state is UserLoadedState)
//                     ? Text(state.user.name!)
//                     : Text("data");
//               },
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 AuthServices.signOut();
//               },
//               child: const Text('Sign out'),
//             ),
//           ],
//         ),
//       ),
