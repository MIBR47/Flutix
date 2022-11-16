part of 'widgets.dart';

class TransactionCard extends StatelessWidget {
  final FlutixTransactionModel transaction;
  final double width;
  const TransactionCard(this.transaction, this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 90,
          width: 70,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: (transaction.picture != '')
                  ? NetworkImage('${imageBaseURL}w500${transaction.picture}') as ImageProvider
                  : const AssetImage('assets/bg_topup.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: width - 86,
              child: Text(
                transaction.title,
                style: blackTextFont.copyWith(fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: width - 86,
              child: Text(
                convertToIdr(transaction.amount < 0 ? -transaction.amount : transaction.amount, 0),
                style: whiteNumberFont.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: transaction.amount < 0 ? const Color(0xFFff5c83) : const Color(0xFF3e9d9d),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: width - 86,
              child: Text(
                transaction.subtitle,
                style: greyTextFont.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
