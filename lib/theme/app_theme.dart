import 'package:flutter/material.dart';

class AppTheme {
  // Палитра по ТЗ:
  // • Основной фон и нижняя навигация — #0E151F
  // • Фон карточек и секций — #192434
  // • Поля поиска, второстепенные элементы — #263447
  // • Основной акцент, кнопки и активные вкладки — #5AC4B1 (бирюзовый)
  // • Лаймовый акцент для прогресса и достижений — #C7ED4C
  // • Основной текст и заголовки — #FFFFFF
  // • Текст на бирюзовых и лаймовых кнопках — #0E151F
  // • Второстепенный текст — #AAB7C4

  static const Color background = Color(0xFF0E151F);
  static const Color surface = Color(0xFF0E151F);
  static const Color surfaceCard = Color(0xFF192434);
  static const Color surfaceSecondary = Color(0xFF263447);
  static const Color surfaceBorder = Color(0xFF263447);

  static const Color primary = Color(0xFF5AC4B1); // Бирюзовый акцент
  static const Color accentLime = Color(0xFFC7ED4C); // Лаймовый акцент
  static const Color onAccent = Color(0xFF0E151F); // Текст на кнопках

  // Дополнительные семантические константы в единой палитре
  static const Color secondary = accentLime;
  static const Color accentGold = accentLime;
  static const Color accentPurple = primary;
  static const Color accentRose = Color(0xFFFF5252);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFAAB7C4);
  static const Color textMuted = Color(0xFF758595);

  static const double cardRadius = 16.0;
  static const double buttonRadius = 12.0;
  static const double screenPadding = 16.0;
  static const double buttonHeight = 48.0;

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withAlpha(50),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get tealGlow => [
        BoxShadow(
          color: primary.withAlpha(60),
          blurRadius: 16,
          spreadRadius: 1,
        ),
      ];

  static List<BoxShadow> get limeGlow => [
        BoxShadow(
          color: accentLime.withAlpha(60),
          blurRadius: 16,
          spreadRadius: 1,
        ),
      ];

  static List<BoxShadow> get neonGlow => tealGlow;

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accentLime,
        surface: surfaceCard,
        error: Color(0xFFFF5252),
        onPrimary: onAccent,
        onSecondary: onAccent,
        onSurface: textPrimary,
      ),
      fontFamily: null, // Системный шрифт по ТЗ
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: onAccent,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onAccent,
          minimumSize: const Size(0, buttonHeight),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          elevation: 0,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: primary),
      ),
    );
  }
}
