import 'package:flutter/material.dart';

class AppTheme {
    static MaterialColor primaryColor = Colors.purple;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor[900],
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor[900],
        foregroundColor: Colors.white
    ),
  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor[900],
        foregroundColor: Colors.white
    )
  );
}