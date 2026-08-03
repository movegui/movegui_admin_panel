import 'package:flutter/widgets.dart';

class DisplayWidget extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;


  const DisplayWidget({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
