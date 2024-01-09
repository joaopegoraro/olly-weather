import 'package:olly_weather/constants/weather_condition.dart';

class Weather {
  Weather({
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.condition,
    required this.date,
  });

  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final String description;
  final WeatherCondition condition;
  final DateTime date;

  factory Weather.fromMap(Map<String, dynamic> map) {
    // response format from https://openweathermap.org/forecast5#parameter
    return Weather(
      temperature: map['main']['temp'] as double,
      minTemperature: map['main']['temp_min'] as double,
      maxTemperature: map['main']['temp_max'] as double,
      description: map['weather'][0]['description'] as String,
      condition: WeatherCondition.fromValue(map['weather'][0]['main']),
      // 'dt' is in seconds, UTC
      date: DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000, isUtc: true),
    );
  }
}
