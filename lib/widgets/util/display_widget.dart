import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';

class DisplayWidget extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;


  const DisplayWidget({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize,
    this.fontWeight,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = Responsive.isDesktop(context)
        ? textTheme.bodyMedium
        : textTheme.bodySmall;

    return Text(
      text ?? '',
      textAlign: textAlign,
      style: textStyle?.copyWith(fontSize: fontSize, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}
