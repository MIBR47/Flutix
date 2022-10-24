part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final TicketModel ticket;
  final FlutixTransactionModel transaction;
  const SuccessPage(this.ticket, this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        body: FutureBuilder(
          future: processingTicketOrder(context),
          builder: ((_, snapshot) => (snapshot.connectionState == ConnectionState.done)
              ? Center(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: (() {}),
                      child: Text(ticket.totalPrice.toString()),
                    ),
                  ),
                )
              : Center(
                  child: SpinKitFadingCircle(
                    color: accentColor2,
                    size: 50,
                  ),
                )),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    // // *note: untuk update saldo user
    context.read<UserBloc>().add(PurchaseEvent(ticket.totalPrice));
    // // *note: untuk menyimpan detail pembelian ticket
    context.read<TicketBloc>().add(BuyTicketEvent(ticket, transaction.userID));

    // // *note: untuk menyimpan transaksi pembelian ticket
    // await TicketServices.saveTicket(transaction.userID, ticket);
    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
