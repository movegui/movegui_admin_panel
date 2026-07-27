import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
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
  final bool? isFullBorder;
  final String? labelText;


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
    this.isFullBorder = false,
    this.labelText = ''
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
/*
        decoration: isFullBorder == true ?  InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: AppColors.selectionColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: Icon(icon, color: textColor),
          labelText:  labelText!.isEmpty ? hinterText : labelText,
          labelStyle: TextStyle(color: textColor),
          errorStyle: TextStyle(color: AppColors.error), // change validator color
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 2),
          ),
          hintText: hinterText,
          hintStyle: TextStyle(color: AppColors.placeHolderText),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor!),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: textColor!),
            borderRadius: BorderRadius.circular(8),
          ),
          
        ):
        
        InputDecoration(
          hintText: hinterText,
          prefixIcon: Icon(icon, color: textColor),
          hintStyle: TextStyle(color: AppColors.placeHolderText),

          // Only show bottom border
          border:  UnderlineInputBorder(
            borderSide: BorderSide(color: textColor!, width: 1),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColor!, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.selectionColor , width: 2),
          ),
          // Optional: fill white background
      //    fillColor: Colors.white,
     //     filled: true,
        ),
        */
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocusNode!);
        },
        validator: validator,
      ),

      /*
      TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hinterText,
          prefixIcon: Icon(icon, color: textColor,),
          hintStyle: TextStyle(color: AppColors.placeHolderText),
          /*
          border: OutlineInputBorder(
            borderSide:  BorderSide(color: textColor!, ),
            borderRadius: BorderRadius.circular(8),
          ),
          */
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
      */
    );
  }
}


