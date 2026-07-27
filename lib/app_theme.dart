import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.lightbackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.card,
      error: AppColors.error,
    ),

    cardTheme: _cardTheme(),

    inputDecorationTheme: _textFieldTheme(),

    elevatedButtonTheme: _elevatedButtonTheme(),

    textTheme: _textTheme(),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.darkbackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.card,
      error: AppColors.error,
    ),

    cardTheme: _cardTheme(),

    inputDecorationTheme: _textFieldTheme(),

    elevatedButtonTheme: _elevatedButtonTheme(),

    textTheme: _textTheme(),
  );

  static CardThemeData _cardTheme() {
    return CardThemeData(
      color: AppColors.card,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  static InputDecorationTheme _textFieldTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),

      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.selectionColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
        borderRadius: BorderRadius.circular(8),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),

      labelStyle: const TextStyle(color: AppColors.primary),
      hintStyle: const TextStyle(color: AppColors.placeHolderText),
      errorStyle: const TextStyle(color: AppColors.error),
      prefixIconColor: AppColors.primary,
    );
  }


  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkbackground, // MoveGui
        foregroundColor: AppColors.primary,

        elevation: 3,

        minimumSize: const Size(0, 50),

        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        iconColor: AppColors.primary,
        iconSize: 14,
        disabledForegroundColor: AppColors.placeHolderText,
        disabledIconColor: AppColors.placeHolderText
      ),
    );
  }

 static TextTheme _textTheme() {
    return TextTheme(
      // Titres des pages
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),

      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),

      // Titres de cards
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color:AppColors.primary,
      ),

      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),

      // Texte normal
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.primary,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color:AppColors.primary,
      ),

      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.primary,
      ),

      // Boutons
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
    );
  
  }
}
