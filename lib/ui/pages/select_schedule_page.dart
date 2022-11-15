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
  int? selectedTime;
  TheaterModel? selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    dates = List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates![0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GotoMovieDetailPageEvent(widget.movieDetail));
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
                      margin: const EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: const EdgeInsets.all(1),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     color: Colors.black.withOpacity(0.04)),
                      child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(GotoMovieDetailPageEvent(widget.movieDetail));
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
                  margin: const EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                  child: Text(
                    "Choose Date",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates!.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: (index == 0 ? defaultMargin : 0),
                          right: (index < dates!.length - 1 ? 16 : defaultMargin),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
                  child: Text(
                    "Choose Theater",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                generateTimeTable(),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) {
                      return Column(
                        children: [
                          FloatingActionButton(
                            backgroundColor: (isValid) ? mainColor : const Color(0xffE4E4E4),
                            child: Icon(
                              Icons.arrow_forward,
                              color: (isValid) ? Colors.white : const Color.fromARGB(255, 116, 114, 114),
                            ),
                            onPressed: () {
                              if (isValid) {
                                context.read<PageBloc>().add(
                                      GoToSelectSeatPageEvent(
                                        TicketModel(
                                          movieDetail: widget.movieDetail,
                                          theater: selectedTheater,
                                          time: DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, selectedTime!),
                                          bookingCode: randomAlphaNumeric(12).toUpperCase(),
                                          seats: null,
                                          name: (userState as UserLoadedState).user.name,
                                          totalPrice: 0,
                                        ),
                                      ),
                                    );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      widgets.add(
        Container(
          margin: const EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child: Text(
            theater.name!,
            style: blackTextFont.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      );
      widgets.add(
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: schedule.length,
            itemBuilder: ((_, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: (index == 0 ? defaultMargin : 0),
                  right: (index < schedule.length - 1 ? 16 : defaultMargin),
                ),
                child: SelectableBox(
                  text: "${schedule[index]}:00",
                  height: 50,
                  width: 100,
                  isselected: selectedTheater == theater && selectedTime == schedule[index],
                  isEnabled: schedule[index] > DateTime.now().hour || selectedDate!.day != DateTime.now().day,
                  onTap: () {
                    setState(() {
                      selectedTheater = theater;
                      selectedTime = schedule[index];
                      isValid = true;
                    });
                  },
                ),
              );
            }),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
