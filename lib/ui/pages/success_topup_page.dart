part of 'pages.dart';

class SuccessTopupPage extends StatelessWidget {
  final FlutixTransactionModel transaction;
  const SuccessTopupPage(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        body: FutureBuilder(
          future: processingTopUp(context),
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
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/top_up_done.png"))),
                      ),
                      Text(
                        "Emmy Yummy!",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "You have successfully\ntop up the wallet",
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
                            "My Wallet",
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                          onPressed: () {
                            context.read<PageBloc>().add(GoToMainPageEvent());
                          },
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

  Future<void> processingTopUp(BuildContext context) async {
    // *note: untuk update saldo user
    context.read<UserBloc>().add(TopupEvent(transaction.amount));
    // *note: untuk menyimpan transaksi top up
    // await TicketServices.saveTicket(transaction.userID, ticket);
    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
