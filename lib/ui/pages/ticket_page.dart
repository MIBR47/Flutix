part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTicket;

  const TicketPage({this.isExpiredTicket = false, super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> with AutomaticKeepAliveClientMixin {
  bool ixExpiredTickets = false;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    ixExpiredTickets = widget.isExpiredTicket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //*note Content
          BlocBuilder<TicketBloc, TicketState>(
            builder: (_, ticketstate) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: TicketViewer(
                  ixExpiredTickets
                      ? ticketstate.tickets.where((ticket) => ticket.time!.isBefore(DateTime.now())).toList()
                      : ticketstate.tickets.where((ticket) => !ticket.time!.isBefore(DateTime.now())).toList(),
                ),
              );
            },
          ),
          // * note : Header
          Container(
            height: 113,
            color: accentColor1,
          ),
          SafeArea(
            child: ClipPath(
              clipper: Headerclipper(),
              child: Container(
                height: 113,
                color: accentColor1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 24, bottom: 32),
                      child: Text(
                        'My Tickets',
                        style: whiteTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ixExpiredTickets = false;
                            });
                          },
                          child: Container(
                            color: accentColor1,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Text(
                                  "Newest",
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: !ixExpiredTickets ? Colors.white : Color(0xFF6F78E),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 4,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  color: !ixExpiredTickets ? accentColor2 : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ixExpiredTickets = true;
                            });
                          },
                          child: Container(
                            color: accentColor1,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Text(
                                  "Oldest",
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: ixExpiredTickets ? Colors.white : Color(0xFF6F78E),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 4,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  color: ixExpiredTickets ? accentColor2 : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Headerclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketViewer extends StatelessWidget {
  final List<TicketModel> tickets;
  const TicketViewer(this.tickets, {super.key});

  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets.sort((ticket2, ticket1) => ticket1.time!.compareTo(ticket2.time!));
    return ListView.builder(
      itemCount: sortedTickets.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            context.read<PageBloc>().add(GotoTicketDetailPageEvent(sortedTickets[index]));
          },
          child: Container(
            margin: EdgeInsets.only(top: index == 0 ? 133 : 20),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage('${imageBaseURL}w500${sortedTickets[index].movieDetail!.posterPath!}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - (2 * defaultMargin) - 70 - 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sortedTickets[index].movieDetail!.title!,
                        style: blackTextFont.copyWith(fontSize: 18),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        sortedTickets[index].theater!.name!,
                        style: greyTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        sortedTickets[index].time!.time,
                        style: greyTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          sortedTickets[index].time!.date,
                          style: greyTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
