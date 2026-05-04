import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';

class MessageWidget {
  static Future<dynamic> errorMessage(BuildContext context, String title, String message, Icon? icon,   FlushbarPosition flushbarPosition) {
    return Flushbar(
      title: title, //'Erreur d\'age',
      message: message, // 'Vous devez être âgé d\'au moins 18 ans.',
      icon:icon,
      duration: Duration(seconds: 3),
      flushbarPosition: flushbarPosition, //.TOP,
      messageColor: AppColors.textColor,
      backgroundColor: AppColors.error,
    ).show(context);
  }
}
