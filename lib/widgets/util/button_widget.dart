import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/button_item.dart';


class ButtonWidget extends StatelessWidget {
  final ButtonItem buttonItem;
  final IconData? icon;
  final Color? backgroundColor;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final double? fontSize;
  final Future<void> Function( ButtonItem item) onPressed;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonItem,
    required this.icon,
    this.backgroundColor,
    this.fontStyle,
    this.textDecoration,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(3.0)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.selectionColor; // hover color
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.selectionColor;
          }
          return backgroundColor != null ? backgroundColor! : AppColors.backgroundColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.textColor;
          }
          return AppColors.textColor;
        }),
      ),
      icon:
          icon != null
              ? Icon(icon!, color: AppColors.textColor)
              : const SizedBox(),
      label: Text(buttonItem.title!, style: TextStyle(fontSize: fontSize, color: AppColors.textColor)),
      onPressed: () async {
        await onPressed(buttonItem);
      },
    );
  }
}
