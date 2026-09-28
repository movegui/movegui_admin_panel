import 'package:flutter/material.dart';

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
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: fontSize, fontWeight: FontWeight.bold,),
        textAlign: textAlign,
      ),
    );
  }
}
