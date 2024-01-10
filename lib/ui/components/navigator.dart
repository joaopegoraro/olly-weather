import 'package:flutter/material.dart';
import 'package:olly_weather/ui/home/home_screen.dart';
import 'package:olly_weather/ui/login/login_screen.dart';

class OllyWeatherNavigator {
  const OllyWeatherNavigator._();

  static void navigateToHome(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
