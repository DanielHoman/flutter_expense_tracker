import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final ColorScheme kLightColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 63, 235, 123),
  );

  final ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 9, 123, 122),
  );

  final ThemeData lightTheme = ThemeData.light().copyWith();
  final ThemeData darkTheme = ThemeData.dark().copyWith();

  ThemeData getTheme(Brightness brightness) {
    final theme = brightness == Brightness.light ? lightTheme : darkTheme;
    final kColorScheme = brightness == Brightness.light
        ? kLightColorScheme
        : kDarkColorScheme;
    return theme.copyWith(
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: const CardThemeData().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        ),
      ),

      textTheme: GoogleFonts.fredokaTextTheme(theme.textTheme).copyWith(
        titleMedium: GoogleFonts.fredoka(
          textStyle: theme.textTheme.titleMedium,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
