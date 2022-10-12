part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final MovieModel? movie;
  final Function? ontap;
  const MovieCard({
    super.key,
    required this.movie,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (ontap != null) {
          ontap!();
        }
      },
      child: Container(
        height: 140,
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage("${imageBaseURL}w780${movie!.backdropPath!}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 140,
          width: 210,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.61),
                  Colors.black.withOpacity(0),
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie!.title!,
                style: whiteTextFont,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              RatingStars(
                voteAverage: movie!.voteAverage!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
