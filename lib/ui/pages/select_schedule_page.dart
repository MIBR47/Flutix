part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetailModel movieDetail;
  const SelectSchedulePage(this.movieDetail, {super.key});

  @override
  State<SelectSchedulePage> createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime>? dates;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates![0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context
              .read<PageBloc>()
              .add(GotoMovieDetailPageEvent(widget.movieDetail));
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
                ),
              ),
              ListView(
                children: [
                  Row(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: defaultMargin),
                        padding: const EdgeInsets.all(1),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     color: Colors.black.withOpacity(0.04)),
                        child: GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(
                                GotoMovieDetailPageEvent(widget.movieDetail));
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        defaultMargin, 20, defaultMargin, 16),
                    child: Text(
                      "Choose Date",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates!.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: (index == 0 ? defaultMargin : 0),
                            right: (index < dates!.length - 1
                                ? 16
                                : defaultMargin),
                          ),
                          child: DateCard(
                            dates![index],
                            isselected: selectedDate == dates![index],
                            onTap: () {
                              setState(() {
                                selectedDate = dates![index];
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
