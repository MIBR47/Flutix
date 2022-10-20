part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final bool isselected;
  final bool isEnabled;
  final double width;
  final double height;
  final String text;
  final Function? onTap;
  final TextStyle? textStyle;
  final Color color;
  const SelectableBox(
      {this.isselected = false,
      this.isEnabled = true,
      this.width = 144,
      this.height = 60,
      required this.text,
      this.onTap,
      this.textStyle,
      this.color = const Color(0xffE4E4E4),
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        if (onTap != null && isEnabled == true) {
          onTap!();
        }
      }),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: (!isEnabled)
              ? color
              : isselected
                  ? accentColor2
                  : Colors.transparent,
          border: Border.all(
              color: (!isEnabled)
                  ? color
                  : isselected
                      ? Colors.transparent
                      : color),
        ),
        child: Center(
          child: Text(
            text,
            style: (textStyle ?? blackTextFont).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
