part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;
  final Function? onTap;
  const BrowseButton({super.key, required this.genre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xffEBEFF6),
          ),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                image: DecorationImage(
              scale: 5,
              image: AssetImage(logoGenre(genre)),
            )),
          ),
        ),
        Text(genre),
      ],
    );
  }
}

String logoGenre(String genre) {
  String logo;
  switch (genre) {
    case 'Horror':
      logo = 'assets/ic_horror.png';
      break;
    case 'Music':
      logo = 'assets/ic_action.png';
      break;
    case 'Drama':
      logo = 'assets/ic_drama.png';
      break;
    case 'War':
      logo = 'assets/ic_war.png';
      break;
    case 'Crime':
      logo = 'assets/ic_crime.png';
      break;
    default:
      logo = 'assets/ic_action.png';
  }
  return logo;
}
// "Horror",
//     "Music",
//     "Action",
//     "Drama",
//     "War",
//     "Crime"