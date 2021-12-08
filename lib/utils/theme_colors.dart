import 'package:flutter/material.dart';

class ThemeColors {

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: const Color(0xFF018786),
    primaryIconTheme: const IconThemeData(color : Color(0xFF03DAC5)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: const Color(0xFF018786))),
    primaryColorLight: const Color(0xff9ed1d1),
    primaryColorDark: const Color(0xFF666666),
    cardColor: const Color(0xFFC8FFF4),
    secondaryHeaderColor: const Color(0xFFF4F4F4),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    primaryColor: const Color(0xFF018786),
    primaryIconTheme: const IconThemeData(color : Color(0xFF03DAC5)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: const Color(0xFF4fb7b6), textStyle: const TextStyle(color: Colors.white))),
    primaryColorLight: const Color(0xFF9ed1d1),
    primaryColorDark: const Color(0xFF666666),
    cardColor: const Color(0xFFC8FFF4),
    secondaryHeaderColor: const Color(0xFFF4F4F4),
  );
}