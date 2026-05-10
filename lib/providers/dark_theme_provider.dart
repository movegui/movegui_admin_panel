
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart' show ChangeNotifierProvider;
import 'package:movegui_admin_panel/services/dark_them_preferences.dart';
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

 static final themeProvider =
    ChangeNotifierProvider<DarkThemeProvider>((ref) {
  final provider = DarkThemeProvider();
  provider.getDarkTheme; // load saved theme
  return provider;
});

}



