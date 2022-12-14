part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final bool isselected;
  final double width;
  final double height;
  final DateTime date;
  final Function? onTap;
  const DateCard(this.date, {this.isselected = false, this.width = 70, this.height = 90, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isselected ? accentColor2 : Colors.transparent,
          border: Border.all(
            color: isselected ? Colors.transparent : const Color(0xffE4E4E4),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.shortDayName,
              style: blackTextFont.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              date.day.toString(),
              style: whiteNumberFont.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
