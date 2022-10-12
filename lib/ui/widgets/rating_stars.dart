part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final Color color;
  final MainAxisAlignment alignment;
  const RatingStars(
      {this.voteAverage = 0,
      super.key,
      this.fontSize = 12.0,
      this.starSize = 20.0,
      this.color = Colors.white,
      this.alignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();
    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              index < n ? MdiIcons.star : MdiIcons.starOutline,
              color: accentColor2,
              size: starSize,
            ));
    widgets.add(const SizedBox(width: 3));
    widgets.add(Text(
      "$voteAverage/10",
      style: whiteNumberFont.copyWith(
        color: color,
        fontWeight: FontWeight.w300,
        fontSize: fontSize,
      ),
    ));
    return Row(mainAxisAlignment: alignment, children: widgets);
  }
}
