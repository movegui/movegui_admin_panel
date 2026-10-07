import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/responsive.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final String? hintText;
  final String? Function(String?)? validator;
  final double? fontSize;
  final String? fontFamily;
  final bool? isFullBorder;
  final String? labelText;
  final ValueChanged<String>? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final int? maxLines;
  final FontWeight? fontweight;
  final bool? obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final Color? color;

  const InputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType,
    this.hintText,
    this.validator,
    this.fontSize,
    this.fontFamily,
    this.isFullBorder = true,
    this.labelText = '',
    this.onChange,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLines = 1,
    this.fontweight = FontWeight.normal,
    this.obscureText = false,
    this.contentPadding,
    this.textStyle,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        textInputAction: TextInputAction.next,
        keyboardType: textInputType,
        obscureText: obscureText ?? false,
        style:
            textStyle ??
            (Responsive.isDesktop(context)
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    fontWeight: fontweight,
                    color: color,
                  )
                : Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    fontWeight: fontweight,
                    color: color,
                  )),
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocusNode!);
        },
        validator: validator,
        onChanged: onChange,
        decoration: isFullBorder == true
            ? InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.selectionColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: prefixIcon,
                labelText: labelText!.isEmpty ? hintText : labelText,
                labelStyle: Responsive.isDesktop(context)
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    fontWeight: fontweight,
                    color: color,
                  )
                : Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    fontWeight: fontweight,
                    color: color,
                  ),
                errorStyle: TextStyle(
                  color: AppColors.error,
                ), // change validator color
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error, width: 2),
                ),
                hintText: hintText,
                hintStyle: Responsive.isDesktop(context)
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    fontWeight: fontweight,
                    color: AppColors.disabled,
                  )
                : Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    fontWeight: fontweight,
                    color: AppColors.disabled,
                  ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: suffixIcon,
                contentPadding: contentPadding,
              )
            : InputDecoration(
                hintText: hintText,
                prefixIcon: prefixIcon,
                hintStyle: TextStyle(color: AppColors.disabled),
                border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.selectionColor,
                    width: 2,
                  ),
                ),
              ),
    );
  }
}
