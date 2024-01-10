import 'package:flutter/material.dart';

class OllyWeatherNavigator {
  const OllyWeatherNavigator._();

  static const loginRoute = "/login";
  static const homeRoute = "/home";

  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      homeRoute,
      (route) => false,
    );
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      loginRoute,
      (route) => false,
    );
  }
}
