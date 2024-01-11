import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:olly_weather/ui/home/home_screen.dart';
import 'package:olly_weather/ui/theme/theme.dart';

void main() async {
  // due to the setup of the 'dotenv' and 'intl' packages, the main method
  // is now async so this is necessary, and should be
  // the first line of the method
  WidgetsFlutterBinding.ensureInitialized();

  // necessary step of the 'dotenv' package, so the .env file containing the
  // api credentials and url can be properly read in the ApiService
  await dotenv.load(fileName: ".env");

  // necessary step of the 'intl' package, so the dates are properly formated
  // for the system locale
  await initializeDateFormatting(await findSystemLocale(), null);

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
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: OllyWeatherTheme.themeData,
    );
  }
}
