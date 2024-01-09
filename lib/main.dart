import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:olly_weather/ui/login/login_screen.dart';

void main() async {
  // due to the next lines the main method is now async so this is necessary,
  // and should be the first line of the method
  WidgetsFlutterBinding.ensureInitialized();

  // necessary step of the 'dotenv' package, so the .env file containing the
  // api credentials and url can be properly read in the ApiService
  await dotenv.load(fileName: ".env");

  // necessary step of the 'intl' package, used so the date returned by the
  // API can be properly converted to the device's timezone
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
