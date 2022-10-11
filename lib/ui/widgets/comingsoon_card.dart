part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final MovieModel? movie;
  final Function? onTap;
  const ComingSoonCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage("${imageBaseURL}w780${movie!.posterPath!}"),
          fit: BoxFit.cover,
        ),
      ),
      // child: Container(
      //   height: 140,
      //   width: 100,
      //   padding: EdgeInsets.all(16),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15),
      //     gradient: LinearGradient(
      //         begin: Alignment.bottomCenter,
      //         end: Alignment.topCenter,
      //         colors: [
      //           Colors.black.withOpacity(0.61),
      //           Colors.black.withOpacity(0),
      //         ]),
      //   ),
      //   // child: Column(
      //   //   mainAxisAlignment: MainAxisAlignment.end,
      //   //   crossAxisAlignment: CrossAxisAlignment.start,
      //   //   children: [
      //   //     Text(
      //   //       movie!.title!,
      //   //       style: whiteTextFont,
      //   //       maxLines: 2,
      //   //       overflow: TextOverflow.ellipsis,
      //   //     ),
      //   //     RatingStars(
      //   //       voteAverage: movie!.voteAverage!,
      //   //     ),
      //   //   ],
      //   // ),
      // ),
    );
  }
}
