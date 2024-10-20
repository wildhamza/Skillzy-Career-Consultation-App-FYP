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


  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor[900],
      foregroundColor: Colors.white,
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor[900],
      foregroundColor: Colors.white,
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
  );
}
