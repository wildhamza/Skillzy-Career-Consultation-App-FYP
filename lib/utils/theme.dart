import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const MaterialColor primaryColor = MaterialColor(
    0xFF003366,
    <int, Color>{
      50: Color(0xFFE3E6EC),
      100: Color(0xFFB9C0D1),
      200: Color(0xFF8C97B2),
      300: Color(0xFF5F6D93),
      400: Color(0xFF3F517A),
      500: Color(0xFF1F3661),
      600: Color(0xFF1A2F59),
      700: Color(0xFF13254F),
      800: Color(0xFF0D1B45),
      900: Color(0xFF051236),
    },
  );

  static const MaterialColor secondaryColor = MaterialColor(
    0xFFFF6F61,
    <int, Color>{
      50: Color(0xFFFFE6E3),   // Lightest shade
      100: Color(0xFFFFC0B9),
      200: Color(0xFFFF978C),
      300: Color(0xFFFF6D5F),
      400: Color(0xFFFF4F3F),
      500: Color(0xFFFF6F61),   // Base color
      600: Color(0xFFDB6055),
      700: Color(0xFFB74F47),
      800: Color(0xFF933F3A),
      900: Color(0xFF7A3230),   // Darkest shade
    },
  );

  static const MaterialColor blackPalette = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF999999), // Light gray
      100: Color(0xFF888888),
      200: Color(0xFF777777),
      300: Color(0xFF666666),
      400: Color(0xFF555555),
      500: Color(0xFF444444), // Black
      600: Color(0xFF333333),
      700: Color(0xFF222222),
      800: Color(0xFF111111),
      900: Color(0xFF000000),
    },
  );

  static const MaterialColor whitePalette = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF), // White
      100: Color(0xFFFAFAFA),
      200: Color(0xFFF5F5F5),
      300: Color(0xFFEEEEEE),
      400: Color(0xFFE8E8E8),
      500: Color(0xFFE0E0E0),
      600: Color(0xFFD6D6D6),
      700: Color(0xFFCCCCCC),
      800: Color(0xFFBFBFBF),
      900: Color(0xFFB3B3B3), // Light gray
    },
  );

  // Define the text theme for light mode
  static TextTheme textTheme(bool isDark) {
    // Get the default Poppins TextTheme
    TextTheme baseTextTheme = GoogleFonts.poppinsTextTheme();
    Color color = isDark ? Colors.white : Colors.black;

    return TextTheme(
      // Override colors for each text style
      displayLarge: baseTextTheme.displayLarge?.copyWith(color: color),
      displayMedium: baseTextTheme.displayMedium?.copyWith(color: color),
      displaySmall: baseTextTheme.displaySmall?.copyWith(color: color),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(color: color),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(color: color),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(color: color),
      titleLarge: baseTextTheme.titleLarge?.copyWith(color: color),
      titleMedium: baseTextTheme.titleMedium?.copyWith(color: color),
      titleSmall: baseTextTheme.titleSmall?.copyWith(color: color),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: color),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: color),
      bodySmall: baseTextTheme.bodySmall?.copyWith(color: color),
      labelLarge: baseTextTheme.labelLarge?.copyWith(color: color),
      labelMedium: baseTextTheme.labelMedium?.copyWith(color: color),
      labelSmall: baseTextTheme.labelSmall?.copyWith(color: color),
    );
  }

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor[900],
      foregroundColor: Colors.white,
    ),
    textTheme: textTheme(false),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor[900],
      foregroundColor: Colors.white,
    ),
    textTheme: textTheme(true),
  );
}
