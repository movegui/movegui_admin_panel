import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';

class DisplayWidgetTitle extends StatelessWidget {
  const DisplayWidgetTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = 18.0,
     this.color = AppColors.textColor,
  });
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: fontSize,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
