import 'package:flutter/material.dart';

final class OllyWeatherTheme {
  const OllyWeatherTheme._();

  static const double maxFrameWidth = 1920.0;
  static const double tabletWidth = 1000.0;
  static const double mobileWidth = 680.0;

  static const double appBarHeight = 80.0;

  // from Olly Olly's website https://www.ollyolly.com/
  static const seedColor = Color(0xFF8cd4ea);

  static final themeData = ThemeData(
    fontFamily: 'Roboto',
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
    ),
  );
}
