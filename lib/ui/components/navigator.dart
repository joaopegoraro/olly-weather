import 'package:flutter/material.dart';
import 'package:olly_weather/ui/home/home_screen.dart';
import 'package:olly_weather/ui/login/login_screen.dart';

class OllyWeatherNavigator {
  const OllyWeatherNavigator._();

  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, __, ___, child) => child,
      ),
      (route) => false,
    );
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, __, ___, child) => child,
      ),
      (route) => false,
    );
  }
}
