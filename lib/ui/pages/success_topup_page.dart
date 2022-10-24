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
            future: processingTopUp(),
            builder: ((context, snapshot) {
              return Container();
            })),
      ),
    );
  }

  Future<void> processingTopUp() async {}
}
