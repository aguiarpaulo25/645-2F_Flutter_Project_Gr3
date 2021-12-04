import 'dart:ui';

import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFF018786);
const PrimaryColorLight = const Color(0xFF4fb7b6);
const PrimaryColorDark = const Color(0xFF005959);

const SecondaryColor = const Color(0xFF9ed1d1);
const SecondaryColorLight = const Color(0xFFd0ffff);
const SecondaryColorDark = const Color(0xFF6ea0a0);

const Background = const Color(0xFFfffdf7);
const TextColor = const Color(0xFF004d40);

class ThemeColor {
  static final ThemeData defaultTheme = _buildTheme();

  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: SecondaryColor,
      accentColorBrightness: Brightness.dark,

      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
      primaryColorLight: PrimaryColorLight,
      primaryColorBrightness: Brightness.dark,

      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: SecondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),

      scaffoldBackgroundColor: Background,
      cardColor: Background,
      textSelectionColor: PrimaryColorLight,
      backgroundColor: Background,

      //   textTheme: base.textTheme.copyWith(
      //       subtitle1: base.textTheme.title.copyWith(color: TextColor),
      //       body1: base.textTheme.body1.copyWith(color: TextColor),
      //       body2: base.textTheme.body2.copyWith(color: TextColor)
      //   ),
    );
  }
}