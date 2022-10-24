part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final TicketModel ticket;
  const CheckoutPage(this.ticket, {super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int price = widget.ticket.theater!.price![0]['priceOnWeekday'];
    int fee = widget.ticket.theater!.fee;
    int totalSeats = widget.ticket.seats!.length;
    int total = price * totalSeats + fee * totalSeats;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSelectSeatPageEvent(widget.ticket));
        if (Navigator.of(context).userGestureInProgress) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(false);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: accentColor1),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            ListView(
              children: [
                Stack(
                  children: [
                    // * note : Back Button
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: const EdgeInsets.all(1),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     color: Colors.black.withOpacity(0.04)),
                      child: GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(GoToSelectSeatPageEvent(widget.ticket));
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) {
                          UserModel user = (userState as UserLoadedState).user;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // * note : Page Title
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "Checkout\nMovie",
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // * note : Movie Description
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: defaultMargin, right: 20),
                                    width: 70,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage('${imageBaseURL}w342${widget.ticket.movieDetail!.posterPath!}'),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width - 2 * defaultMargin - 70 - 20,
                                        child: Text(
                                          widget.ticket.movieDetail!.title!,
                                          style: blackTextFont.copyWith(fontSize: 18),
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width - 2 * defaultMargin - 70 - 20,
                                        margin: const EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          widget.ticket.movieDetail!.genresAndLanguage,
                                          style: greyTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      RatingStars(
                                        voteAverage: widget.ticket.movieDetail!.voteAverage!,
                                        color: accentColor3,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
                                child: const Divider(
                                  color: Color(0xffE4E4E4),
                                  thickness: 1,
                                ),
                              ),
                              //* note: Ticket Detail
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ID Order',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          widget.ticket.bookingCode,
                                          style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Cinema',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.55,
                                          child: Text(
                                            widget.ticket.theater!.name!,
                                            style: whiteNumberFont.copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Date & Time',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          widget.ticket.time!.dateAndTime,
                                          style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Seat Number',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.55,
                                          child: Text(
                                            widget.ticket.seatsInString,
                                            textAlign: TextAlign.end,
                                            style: whiteNumberFont.copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "${convertToIdr(price, 0)} x ${widget.ticket.seats!.length}",
                                          style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Fee',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "${convertToIdr(fee, 0)} x ${widget.ticket.seats!.length}",
                                          style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          convertToIdr(total, 0),
                                          style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
                                child: const Divider(
                                  color: Color(0xffE4E4E4),
                                  thickness: 1,
                                ),
                              ),
                              // * Note : wallet
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Your Wallet',
                                      style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      convertToIdr(user.balance, 0),
                                      style: whiteNumberFont.copyWith(
                                        color: user.balance! >= total ? const Color(0xff3E9D9D) : const Color(0xffFF5c83),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 250,
                                    height: 45,
                                    margin: const EdgeInsets.only(top: 50),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: user.balance! >= total ? const Color(0xff3E9D9D) : mainColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      child: Text(
                                        user.balance! >= total ? "CheckOut Now" : "Top Up My Wallet",
                                        style: whiteTextFont.copyWith(fontSize: 16),
                                      ),
                                      onPressed: () {
                                        if (user.balance! >= total) {
                                          FlutixTransactionModel transaction = FlutixTransactionModel(
                                            title: widget.ticket.movieDetail!.title!,
                                            userID: user.id,
                                            subtitle: widget.ticket.theater!.name!,
                                            time: DateTime.now(),
                                            amount: -total,
                                            picture: widget.ticket.movieDetail!.posterPath!,
                                          );

                                          TicketModel ticket = TicketModel(
                                            movieDetail: widget.ticket.movieDetail!,
                                            bookingCode: widget.ticket.bookingCode,
                                            name: widget.ticket.name,
                                            seats: widget.ticket.seats,
                                            theater: widget.ticket.theater,
                                            time: widget.ticket.time,
                                            totalPrice: total,
                                          );
                                          context.read<PageBloc>().add(GoToSuccessPageEvent(ticket, transaction));
                                        } else {}
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: defaultMargin)
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
