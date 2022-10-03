part of 'pages.dart';

class PreferencesPage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];

  final List<String> languages = ["Bahasa", "English", "Japanese", "Korean"];
  final RegistationDataModel registrationData;
  PreferencesPage({required this.registrationData, super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.registrationData.password = "";

        context
            .read<PageBloc>()
            .add(GoToRegistrationPageEvent(widget.registrationData));
        if (Navigator.of(context).userGestureInProgress)
          return Future<bool>.value(true);
        else
          return Future<bool>.value(false);
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaulMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              Navigator.maybePop(
                                  context, widget.registrationData);
                              // context.read<PageBloc>().pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("Select Your Four\nFavorite Genres",
                      style: blackTextFont.copyWith(fontSize: 20)),
                  const SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenreWidgets(context),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text("Movie Language\nYou Prefer?",
                      style: blackTextFont.copyWith(fontSize: 20)),
                  const SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLangWidgets(context),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: FloatingActionButton(
                      backgroundColor: mainColor,
                      elevation: 2,
                      child: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (selectedGenres != 4) {
                          Flushbar(
                            duration: const Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: const Color(0xFFff5c83),
                            message: "Please select 4 genres",
                            // ignore: use_build_context_synchronously
                          ).show(context);
                        } else {
                          widget.registrationData.selectedGenres =
                              selectedGenres;
                          widget.registrationData.selectedLang =
                              selectedLanguage;
                          context.read<PageBloc>().add(
                              GoToAccountInformationPageEvent(
                                  widget.registrationData));
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaulMargin - 24) / 2;
    return widget.genres
        .map(
          (e) => SelectableBox(
            text: e,
            width: width,
            isselected: selectedGenres.contains(e),
            onTap: () {
              onSelectGenre(e);
            },
          ),
        )
        .toList();
  }

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaulMargin - 24) / 2;
    return widget.languages
        .map(
          (e) => SelectableBox(
            text: e,
            width: width,
            isselected: selectedLanguage == e,
            onTap: () {
              setState(() {
                selectedLanguage = e;
              });
            },
          ),
        )
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
