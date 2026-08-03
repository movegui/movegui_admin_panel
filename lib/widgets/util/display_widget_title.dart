import 'package:flutter/widgets.dart';

class DisplayWidgetTitle extends StatelessWidget {
  const DisplayWidgetTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = 18.0,
  });
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
