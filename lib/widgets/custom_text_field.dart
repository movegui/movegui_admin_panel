import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.hintText,
    this.inputType,
    this.onChanged,
    this.obscureText = false,
    this.validator,
    required this.hasIcon,
    this.onTap,
    required this.isNumber,
    this.controller,
    this.isEnabled,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.icon,
    this.labelText,
    this.maxLines,
  });

  Function(String)? onChanged;
  String? hintText;
  TextInputType? inputType;
  bool obscureText;
  bool? isEnabled;
  final bool hasIcon;
  final FormFieldValidator<String>? validator;
  final Function? onTap;
  final bool isNumber;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  String? labelText;
  IconData? icon;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        enabled: isEnabled ?? true,
        cursorColor: AppColors.textColor,
        controller: controller,
        focusNode: focusNode,
        validator: validator,
        obscureText: obscureText,
        onChanged: onChanged,
        keyboardType: inputType,
        maxLines: maxLines,
        textInputAction: textInputAction,
        style: TextStyle(color: AppColors.textColor),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.textColor),
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: Icon(icon, color: AppColors.backgroundColor),
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.textColor),
          errorStyle: TextStyle(color: Colors.orange), // change validator color
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),

          /*
          suffixIcon: hasIcon? GestureDetector(
            onTap: (){
              onTap!();
            },
              child:Icon(
            Icons.remove_red_eye_outlined,
            color: AppColors.textColor,
          )):const SizedBox(width: 0,height: 0,),
          */
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.placeHolderText),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColor),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
            : null,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
      ),
    );
  }
}
