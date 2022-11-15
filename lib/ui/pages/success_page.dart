part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final TicketModel ticket;
  final FlutixTransactionModel transaction;
  const SuccessPage(this.ticket, this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToCheckoutPageEvent(ticket));
        if (Navigator.of(context).userGestureInProgress) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(false);
        }
      },
      child: Scaffold(
        body: FutureBuilder(
          future: processingTicketOrder(context),
          builder: ((_, snapshot) => (snapshot.connectionState == ConnectionState.done)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.only(bottom: 70),
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/ticket_done.png"))),
                      ),
                      Text(
                        "Happy Watching!",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "You have successfully\nbought the ticket",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                      Container(
                        width: 250,
                        height: 45,
                        margin: const EdgeInsets.only(top: 70, bottom: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "My Tickets",
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Discover new movie? ",
                            style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToMainPageEvent());
                            },
                            child: Text(
                              "Back to Hoime ",
                              style: purpleTextFont.copyWith(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: SpinKitFadingCircle(
                    color: mainColor,
                    size: 50,
                  ),
                )),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    // *note: untuk update saldo user
    context.read<UserBloc>().add(PurchaseEvent(ticket.totalPrice));
    // *note: untuk menyimpan detail pembelian ticket
    context.read<TicketBloc>().add(BuyTicketEvent(ticket, transaction.userID));

    // *note: untuk menyimpan transaksi pembelian ticket
    // await TicketServices.saveTicket(transaction.userID, ticket);
    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
