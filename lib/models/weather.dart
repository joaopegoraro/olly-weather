import 'package:olly_weather/constants/weather_condition.dart';

class Weather {
  Weather({
    this.city,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.condition,
    required this.date,
  });

  final String? city;
  final num temperature;
  final num minTemperature;
  final num maxTemperature;
  final String description;
  final WeatherCondition condition;
  final DateTime date;

  factory Weather.fromMap(Map<String, dynamic> map) {
    // response format from https://openweathermap.org/forecast5#parameter
    return Weather(
      temperature: map['main']['temp'],
      minTemperature: map['main']['temp_min'],
      maxTemperature: map['main']['temp_max'],
      description: map['weather'][0]['description'] as String,
      condition: WeatherCondition.fromValue(map['weather'][0]['main']),
      // 'dt' is in seconds, UTC
      date: DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000, isUtc: true)
          .toLocal(),
    );
  }

  Weather copyWith({
    String? city,
    num? temperature,
    num? minTemperature,
    num? maxTemperature,
    String? description,
    WeatherCondition? condition,
    DateTime? date,
  }) {
    return Weather(
      city: city ?? this.city,
      temperature: temperature ?? this.temperature,
      minTemperature: minTemperature ?? this.minTemperature,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      description: description ?? this.description,
      condition: condition ?? this.condition,
      date: date ?? this.date,
    );
  }
}
