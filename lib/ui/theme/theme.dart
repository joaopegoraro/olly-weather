import 'package:flutter/material.dart';

final class OllyWeatherTheme {
  const OllyWeatherTheme._();

  static final themeData = ThemeData(
    fontFamily: 'Roboto',
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      // from Olly Olly's website https://www.ollyolly.com/
      seedColor: const Color(0xFF8cd4ea),
    ),
  );
}
