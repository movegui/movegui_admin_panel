import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';

class DisplayWidget extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;

  const DisplayWidget({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.textColor = AppColors.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
