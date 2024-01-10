import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olly_weather/ui/components/navigator.dart';
import 'package:olly_weather/ui/home/home_screen.dart';
import 'package:olly_weather/ui/login/login_screen.dart';
import 'package:olly_weather/ui/theme/theme.dart';

void main() async {
  // due to the 'dotenv' setup the main method is now async so this
  // is necessary, and should be the first line of the method
  WidgetsFlutterBinding.ensureInitialized();

  // necessary step of the 'dotenv' package, so the .env file containing the
  // api credentials and url can be properly read in the ApiService
  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: OllyWeatherApp(),
    ),
  );
}

class OllyWeatherApp extends StatelessWidget {
  const OllyWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olly Weather',
      initialRoute: OllyWeatherNavigator.loginRoute,
      routes: {
        OllyWeatherNavigator.loginRoute: (_) => const LoginScreen(),
        OllyWeatherNavigator.homeRoute: (_) => const HomeScreen(),
      },
      theme: OllyWeatherTheme.themeData,
    );
  }
}
