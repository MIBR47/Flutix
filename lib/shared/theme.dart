part of 'shared.dart';

const double defaulMargin = 24;

Color mainColor = const Color(0xff503E9D);
Color accentColor1 = const Color(0xff2C1F63);
Color accentColor2 = const Color(0xffFBD460);
Color accentColor3 = const Color(0xffADADAD);

// MaterialColor mainMaterialColor = Color(0xff503E9D);

TextStyle blackTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle purpleTextFont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle yellowNumberFont =
    GoogleFonts.openSans().copyWith(color: accentColor2);
