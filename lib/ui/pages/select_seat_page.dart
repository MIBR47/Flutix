part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final TicketModel ticket;
  const SelectSeatPage(this.ticket, {super.key});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToSelectSchedulePageEvent(widget.ticket.movieDetail!));
        if (Navigator.of(context).userGestureInProgress) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(false);
        }
      },
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Container(color: accentColor1),
              SafeArea(
                child: Container(
                  color: Colors.white,
                ),
              ),
              ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: defaultMargin),
                            padding: const EdgeInsets.all(1),
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(5),
                            //     color: Colors.black.withOpacity(0.04)),
                            child: GestureDetector(
                              onTap: () {
                                context.read<PageBloc>().add(
                                    GoToSelectSchedulePageEvent(
                                        widget.ticket.movieDetail!));
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, right: defaultMargin),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 16,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    widget.ticket.movieDetail!.title!,
                                    style: blackTextFont.copyWith(fontSize: 20),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${imageBaseURL}w154${widget.ticket.movieDetail!.posterPath!}'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: 277,
                        height: 84,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage("assets/screen.png"),
                          ),
                        ),
                      ),
                      generateSeats(),
                      const SizedBox(
                        height: 23,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const SelectableBox(
                                  height: 20,
                                  width: 20,
                                  text: '',
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Available",
                                  style: whiteTextFont.copyWith(
                                    fontSize: 10,
                                    color: const Color(0xffADADAD),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const SelectableBox(
                                  height: 20,
                                  width: 20,
                                  text: '',
                                  color: Color(0xffF6F6F6),
                                  isEnabled: false,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Booked",
                                  style: whiteTextFont.copyWith(
                                    color: const Color(0xffADADAD),
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SelectableBox(
                                  height: 20,
                                  width: 20,
                                  text: '',
                                  color: accentColor2,
                                  isEnabled: false,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Selected",
                                  style: whiteTextFont.copyWith(
                                      fontSize: 10,
                                      color: const Color(0xffADADAD)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: selectedSeats.isNotEmpty
                              ? mainColor
                              : const Color(0xffE4E4E4),
                          child: Icon(
                            Icons.arrow_forward,
                            color: selectedSeats.isNotEmpty
                                ? Colors.white
                                : const Color.fromARGB(255, 116, 114, 114),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberofSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (var i = 0; i < numberofSeats.length; i++) {
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            numberofSeats[i],
            (index) => Padding(
              padding: EdgeInsets.only(
                  // left: (index == 0 ? defaultMargin : 0),
                  right: (index < numberofSeats[i] - 1 ? 16 : 0),
                  bottom: 16),
              child: SelectableBox(
                text: '${String.fromCharCode(i + 65)}${index + 1}',
                width: 40,
                height: 40,
                textStyle: whiteNumberFont.copyWith(color: Colors.black),
                isEnabled: index != 0,
                isselected: selectedSeats
                    .contains('${String.fromCharCode(i + 65)}${index + 1}'),
                onTap: () {
                  String seatNumber =
                      '${String.fromCharCode(i + 65)}${index + 1}';
                  setState(() {
                    if (selectedSeats.contains(seatNumber)) {
                      selectedSeats.remove(seatNumber);
                    } else {
                      selectedSeats.add(seatNumber);
                    }
                  });
                },
              ),
            ),
          ),
        ),
      );
    }
    return Column(children: widgets);
  }
}
