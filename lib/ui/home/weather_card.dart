import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:olly_weather/constants/weather_condition.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:olly_weather/models/weather.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.weather,
    required this.unit,
  });

  final Weather weather;
  final WeatherUnit unit;

  String _getWeatherIcon(Weather weather) {
    final fileName = switch (weather.condition) {
      WeatherCondition.thunderstorm => "thunderstorms",
      WeatherCondition.drizzle => "drizzle",
      WeatherCondition.rain => "rain",
      WeatherCondition.snow => "snow",
      WeatherCondition.mist => "mist",
      WeatherCondition.smoke => "smoke",
      WeatherCondition.haze => "haze",
      WeatherCondition.dust => "dust",
      WeatherCondition.fog => "fog",
      WeatherCondition.sand => "sand",
      WeatherCondition.tornado => "tornado",
      WeatherCondition.clouds => "cloudy",
      WeatherCondition.clear =>
        weather.date.hour >= 18 && weather.date.minute >= 30
            ? "clear-night"
            : "clear-day",
    };
    return "assets/lottie/$fileName.json";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather.formattedTime,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.end,
                ),
                const SizedBox(width: 10),
                const Text(" - "),
                const SizedBox(width: 10),
                Text(
                  weather.description,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset(
                  _getWeatherIcon(weather),
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${weather.temperature} ${unit.simbol}",
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          "${weather.minTemperature} ${unit.simbol}",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${weather.maxTemperature} ${unit.simbol}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
