part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  const WalletPage(this.pageEvent, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(pageEvent);
        if (Navigator.of(context).userGestureInProgress) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(false);
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: accentColor1,
            ),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            // *note: CONTENT
            SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
                child: ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        // *note : back
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(pageEvent);
                            },
                            child: const Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              //* note : Judul
                              Text(
                                "My Wallet",
                                style: blackTextFont.copyWith(fontSize: 20),
                              ),
                              //* note: ID CARD
                              Container(
                                height: 185,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFF382A74),
                                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0, offset: Offset(0, 5))]),
                                child: Stack(
                                  children: <Widget>[
                                    ClipPath(
                                      clipper: CardReflectionClipper(),
                                      child: Container(
                                        height: 185,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomRight,
                                              end: Alignment.topLeft,
                                              colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0)]),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: 18,
                                                height: 18,
                                                margin: const EdgeInsets.only(right: 4),
                                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFFF2CB)),
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(shape: BoxShape.circle, color: accentColor2),
                                              )
                                            ],
                                          ),
                                          Text(
                                            convertToIdr((userState as UserLoadedState).user.balance, 0),
                                            style: whiteNumberFont.copyWith(fontSize: 28, fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Card Holder",
                                                    style: whiteTextFont.copyWith(fontSize: 10, fontWeight: FontWeight.w300),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        (userState).user.name!,
                                                        style: whiteTextFont.copyWith(fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      SizedBox(
                                                        height: 14,
                                                        width: 14,
                                                        child: Image.asset('assets/ic_check.png'),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Card ID",
                                                    style: whiteTextFont.copyWith(fontSize: 10, fontWeight: FontWeight.w300),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        (userState).user.id.substring(0, 10).toUpperCase(),
                                                        style: whiteNumberFont.copyWith(fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      SizedBox(
                                                        height: 14,
                                                        width: 14,
                                                        child: Image.asset('assets/ic_check.png'),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //* note : transaksi history
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Recent Transaction",
                                    style: blackTextFont,
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              FutureBuilder(
                                  future: FlutixTransactionServices.getTransaction((userState).user.id),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return generateTransactionList(snapshot.data!, MediaQuery.of(context).size.width - 2 * defaultMargin);
                                    } else {
                                      return SpinKitFadingCircle(
                                        size: 50,
                                        color: mainColor,
                                      );
                                    }
                                  }),
                              const SizedBox(
                                height: 75,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            // *note: BUTTON
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 250,
                height: 46,
                margin: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3E9D9D),
                        disabledBackgroundColor: const Color(0xFFE4E4E4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      "Top Up My Wallet",
                      style: whiteTextFont.copyWith(fontSize: 16),
                    ),
                    onPressed: () {
                      context.read<PageBloc>().add(GoToTopupPageEvent(GoToWalletPageEvent(pageEvent)));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column generateTransactionList(List<FlutixTransactionModel> transactions, double width) {
    transactions.sort((transaction1, transaction2) => transaction2.time.compareTo(transaction1.time));

    return Column(
      children: transactions
          .map((transaction) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TransactionCard(transaction, width),
              ))
          .toList(),
    );
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
