import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/app_theme.dart';

class Styles {
  static ThemeData themeData(getDarkTheme, {
    required bool isDarkTheme,
    required BuildContext context,
  }) {
    return isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
  }
}