part of "pages.dart";

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool uploadImageLoading = false;
    return ListView(
      children: [
        profile(uploadImageLoading, context),
        // note: Now Playing
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Now Playing",
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoadedState) {
                List<MovieModel> movies = movieState.movies.sublist(0, 10);
                print(movies[1].title);
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right: (index == movies.length) ? defaultMargin : 16),
                      child: MovieCard(
                        movie: movies[index],
                        ontap: () {
                          context
                              .read<PageBloc>()
                              .add(GotoMovieDetailPageEvent(movies[index]));
                        },
                      ),
                    );
                  },
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
              // return Container();
            },
          ),
        ),
        // note: Browse movie
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Browse Movie",
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoadedState) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      userState.user.selectedGenres!.length,
                      (index) => BrowseButton(
                          genre: userState.user.selectedGenres![index])),
                ),
              );
            } else {
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            }
          },
        ),
        // note: coming soon
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Coming Soon",
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoadedState) {
                List<MovieModel> movies = movieState.movies.sublist(10);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right: (index == movies.length) ? defaultMargin : 16),
                      child: ComingSoonCard(
                        movie: movies[index],
                      ),
                    );
                  },
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
              // return Container();
            },
          ),
        ),
        // Note : Promo
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Get Luck Day",
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: dumyPromos
              .map((e) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 0, defaultMargin, 16),
                  child: PromoCard(e)))
              .toList(),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }

  Widget profile(bool loading, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: accentColor1,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) {
          if (userState is UserLoadedState) {
            loading = false;
            if (imageFileToUpload != null) {
              uploadImage(imageFileToUpload!).then(
                (downloadURL) {
                  context
                      .read<UserBloc>()
                      .add(UpdateDataEvent(profileImage: downloadURL));
                  imageFileToUpload = null;
                  loading = false;
                },
              );
            }
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff5F558B),
                    ),
                  ),
                  child: Stack(
                    children: [
                      loading == true
                          ? SpinKitCircle(
                              color: accentColor2,
                              size: 50,
                            )
                          : Container(),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (userState.user.profilePicture == "")
                                ? const AssetImage("assets/user_pic.png")
                                : NetworkImage(userState.user.profilePicture!)
                                    as ImageProvider,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          2 * defaultMargin -
                          78,
                      child: Text(
                        userState.user.name!,
                        style: whiteTextFont.copyWith(fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: "id_ID", decimalDigits: 0, symbol: "IDR ")
                          .format(userState.user.balance!),
                      style: yellowNumberFont.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return SpinKitFadingCircle(
              color: accentColor2,
              size: 50,
            );
          }
        },
      ),
    );
  }
}

// Future test(String dowloadURL) async {
//    UserModel updatedUser = copyWith(name: event.name, profilePicture: event.profileImage);
//   await UserServices.updateUserPicture(updatedUser);
// }
