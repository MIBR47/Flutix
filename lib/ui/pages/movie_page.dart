part of "pages.dart";

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool uploadImageLoading = false;
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.fromLTRB(defaulMargin, 20, defaulMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoadedState) {
              uploadImageLoading = false;
              if (imageFileToUpload != null) {
                uploadImage(imageFileToUpload!).then(
                  (downloadURL) {
                    print(downloadURL);

                    context
                        .read<UserBloc>()
                        .add(UpdateDataEvent(profileImage: downloadURL));
                    imageFileToUpload = null;
                    uploadImageLoading = false;
                  },
                );
              }
              return Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Color(0xff5F558B),
                      ),
                    ),
                    child: Stack(
                      children: [
                        uploadImageLoading == true
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
                                  ? AssetImage("assets/user_pic.png")
                                  : NetworkImage(userState.user.profilePicture!)
                                      as ImageProvider,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaulMargin -
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
                                locale: "id_ID",
                                decimalDigits: 0,
                                symbol: "IDR ")
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
          }),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(defaulMargin, 30, defaulMargin, 12),
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
                      margin: EdgeInsets.all(5),
                      child: Text(movies[index].title!),
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
        )
      ],
    );
  }
}

// Future test(String dowloadURL) async {
//    UserModel updatedUser = copyWith(name: event.name, profilePicture: event.profileImage);
//   await UserServices.updateUserPicture(updatedUser);
// }
