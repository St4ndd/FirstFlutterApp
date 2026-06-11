import 'package:flutter/material.dart';

class CasinoColors {
  static const background = Color(0xFF0B1F17);
  static const surface = Color(0xFF132A20);
  static const gold = Color(0xFFD4AF37);
  static const green = Color(0xFF1F7A4D);
  static const red = Color(0xFFB3261E);
  static const textPrimary = Color(0xFFF5F1E6);
  static const textSecondary = Color(0xFFB7C2BC);
}

ThemeData buildCasinoTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: CasinoColors.background,
    colorScheme: const ColorScheme.dark(
      primary: CasinoColors.gold,
      secondary: CasinoColors.green,
      surface: CasinoColors.surface,
      error: CasinoColors.red,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: CasinoColors.background,
      foregroundColor: CasinoColors.textPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: CasinoColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: CasinoColors.textSecondary),
    ),
    cardTheme: CardThemeData(
      color: CasinoColors.surface,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0x33D4AF37)),
      ),
    ),
  );
}
