import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final IconData? icon;
  final TextInputType? textInputType;
  final String? hinterText;
  final String? Function(String?)? validator;
  final double? fontSize;
  final String? fontFamily;
  final Color? textColor;

  const InputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.icon,
    this.textInputType,
    this.hinterText,
    this.validator,
    this.fontSize,
    this.fontFamily,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: WidgetConstants.sepWidgetHeight * 1.5,
        right: WidgetConstants.sepWidgetHeight * 1.5,
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hinterText,
          prefixIcon: Icon(icon),
        ),
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          color: textColor,
        ),
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocusNode!);
        },
        validator: validator,
      ),
    );
  }
}
