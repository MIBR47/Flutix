part of 'pages.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool ixExpiredTcikets = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //*note Content
          Container(
            height: 113,
            color: accentColor1,
          ),
          // * note : Header
          SafeArea(
            child: Container(
              height: 113,
              color: accentColor1,
            ),
          )
        ],
      ),
    );
  }
}
