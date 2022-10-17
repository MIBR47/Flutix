part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;
  const MovieDetailPage(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    MovieDetailModel movieDetail;
    List<CreditModel> credits;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPageEvent());
        if (Navigator.of(context).userGestureInProgress) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(false);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            ListView(
              children: [
                FutureBuilder(
                  future: MovieServices.getDetails(movie),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      movieDetail = snapshot.data!;
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 270,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${imageBaseURL}w780${movie.backdropPath!}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height: 271,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: const Alignment(0, 1),
                                      end: const Alignment(0, 0.06),
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0)
                                      ]),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 20, left: defaultMargin),
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black.withOpacity(0.04)),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PageBloc>()
                                        .add(GoToMainPageEvent());
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(
                                defaultMargin, 16, defaultMargin, 6),
                            child: Text(
                              movie.title!,
                              textAlign: TextAlign.center,
                              style: blackTextFont.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          (snapshot.hasData)
                              ? Text(
                                  movieDetail.genresAndLanguage,
                                  style: greyTextFont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              : SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: SpinKitFadingCircle(
                                    color: accentColor3,
                                  ),
                                ),
                          const SizedBox(
                            height: 6,
                          ),
                          RatingStars(
                            voteAverage: movie.voteAverage!,
                            color: accentColor3,
                            alignment: MainAxisAlignment.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          // note: CREDITS
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: defaultMargin, bottom: 12),
                                child: Text(
                                  "Cast & Crew",
                                  style: blackTextFont.copyWith(fontSize: 14),
                                )),
                          ),
                          FutureBuilder(
                            future: MovieServices.getCredits(movie.id!),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                credits = snapshot.data!;
                                return SizedBox(
                                  height: 115,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder: (_, index) => Container(
                                          margin: EdgeInsets.only(
                                              left: (index == 0)
                                                  ? defaultMargin
                                                  : 0,
                                              right:
                                                  (index == credits.length - 1)
                                                      ? defaultMargin
                                                      : 16),
                                          child: CreditCard(credits[index]))),
                                );
                              } else {
                                return SizedBox(
                                    height: 50,
                                    child: SpinKitFadingCircle(
                                      color: accentColor1,
                                    ));
                              }
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(
                                defaultMargin, 24, defaultMargin, 8),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Storyline",
                                style: blackTextFont,
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 30),
                            child: Text(
                              movieDetail.overview!,
                              textAlign: TextAlign.justify,
                              style: greyTextFont.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 250,
                                height: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  onPressed: () {
                                    context.read<PageBloc>().add(
                                        GoToSelectSchedulePageEvent(
                                            movieDetail));
                                  },
                                  child: Text(
                                    "Continue to Book",
                                    style: whiteTextFont.copyWith(fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(height: defaultMargin)
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
