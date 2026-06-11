import 'package:flutter/material.dart';

class CasinoColors {
  static const background = Color(0xFF0D0E14);
  static const surface = Color(0xFF1B1C28);
  static const surfaceLight = Color(0xFF24263A);
  static const accentPurple = Color(0xFF8C6BFF);
  static const accentGold = Color(0xFFFFC857);
  static const accentGreen = Color(0xFF4ADE80);
  static const accentRed = Color(0xFFFF5A5F);
  static const textPrimary = Color(0xFFF5F5FA);
  static const textSecondary = Color(0xFF8C8DA3);

  static const balanceGradient = LinearGradient(
    colors: [Color(0xFF6A4CFF), Color(0xFF9C6BFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

ThemeData buildCasinoTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: CasinoColors.background,
    fontFamily: '.SF Pro Text',
    colorScheme: const ColorScheme.dark(
      primary: CasinoColors.accentPurple,
      secondary: CasinoColors.accentGold,
      surface: CasinoColors.surface,
      error: CasinoColors.accentRed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: CasinoColors.background,
      foregroundColor: CasinoColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: CasinoColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: CasinoColors.textPrimary,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      titleMedium: TextStyle(
        color: CasinoColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(color: CasinoColors.textSecondary, fontSize: 13),
    ),
    cardTheme: CardThemeData(
      color: CasinoColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
