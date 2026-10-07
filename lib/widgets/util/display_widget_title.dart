import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';

class DisplayWidgetTitle extends StatelessWidget {
  const DisplayWidgetTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize,
    this.flex = 1,
  });
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final int flex;

  @override
  Widget build(BuildContext context) {
        final textTheme = Theme.of(context).textTheme;
    final textStyle = Responsive.isDesktop(context)
        ? textTheme.bodyMedium
        : textTheme.bodySmall;
    return Expanded(
      flex: flex,
      child: Text(
        text ?? '',
        style: textStyle?.copyWith(fontSize: fontSize, fontWeight: FontWeight.bold,),
        textAlign: textAlign,
      ),
    );
  }
}
