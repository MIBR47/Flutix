part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopUpPage(this.pageEvent);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeBloc>().add(
          ChangeThemeEvent(
            ThemeData().copyWith(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: accentColor2,
                primary: accentColor1,
              ),
            ),
          ),
        );

    double cardWidth = (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(widget.pageEvent);
        if (Navigator.of(context).userGestureInProgress) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(false);
        }
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                // *note: BACK ARROW
                SafeArea(
                    child: Container(
                  margin: const EdgeInsets.only(top: 20, left: defaultMargin),
                  child: GestureDetector(
                      onTap: () {
                        context.read<PageBloc>().add(widget.pageEvent);
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.black)),
                )),
                // *note: CONTENT
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Top Up",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (text) {
                          String temp = '';

                          for (int i = 0; i < text.length; i++) {
                            temp += text.isDigit(i) ? text[i] : '';
                          }

                          setState(() {
                            selectedAmount = int.tryParse(temp) ?? 0;
                          });
                          selectedAmount = int.tryParse(temp) ?? 0;

                          amountController.text = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0).format(selectedAmount);

                          amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                          labelStyle: greyTextFont,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Amount",
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 14),
                          child: Text("Choose by Template", style: blackTextFont),
                        ),
                      ),
                      Wrap(
                        spacing: 20,
                        runSpacing: 14,
                        children: <Widget>[
                          makeMoneyCard(
                            amount: 50000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 100000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 150000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 200000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 250000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 500000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 1000000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 2500000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 5000000,
                            width: cardWidth,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        width: 250,
                        height: 46,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff3E9D9D),
                                  disabledBackgroundColor: const Color(0xFFE4E4E4),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              onPressed: (selectedAmount > 0)
                                  ? () {
                                      context.read<PageBloc>().add(
                                            GoToSuccessTopupPageEvent(
                                              FlutixTransactionModel(
                                                  userID: (userState as UserLoadedState).user.id,
                                                  title: "Top Up Wallet",
                                                  amount: selectedAmount,
                                                  subtitle:
                                                      "${DateTime.now().shortDayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}",
                                                  time: DateTime.now()),
                                              widget.pageEvent,
                                            ),
                                          );
                                    }
                                  : null,
                              child: Text(
                                "Top Up My Wallet",
                                style: whiteTextFont.copyWith(fontSize: 16, color: (selectedAmount > 0) ? Colors.white : const Color(0xFFBEBEBE)),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  MoneyCard makeMoneyCard({int? amount, double? width}) {
    return MoneyCard(
      amount: amount!,
      width: width!,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount != amount) {
            selectedAmount = amount;
          } else {
            selectedAmount = 0;
          }

          amountController.text = NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ').format(selectedAmount);

          amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
        });
      },
    );
  }
}
