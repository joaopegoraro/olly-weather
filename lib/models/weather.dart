import 'package:intl/intl.dart';
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
  final int temperature;
  final int minTemperature;
  final int maxTemperature;
  final String description;
  final WeatherCondition condition;
  final DateTime date;

  String get formattedTime {
    /// e.g 8 PM
    return DateFormat('hh a').format(date);
  }

  String get weekdayName {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateWithoutTime = DateTime(date.year, date.month, date.day);
    if (dateWithoutTime == today) {
      return "Today";
    } else if (dateWithoutTime == tomorrow) {
      return "Tomorrow";
    } else {
      /// e.g Thursday
      return DateFormat('EEEE').format(date);
    }
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    // response format from https://openweathermap.org/forecast5#parameter
    return Weather(
      temperature: (map['main']['temp'] as num).round(),
      minTemperature: (map['main']['temp_min'] as num).round(),
      maxTemperature: (map['main']['temp_max'] as num).round(),
      description: map['weather'][0]['description'] as String,
      condition: WeatherCondition.fromValue(map['weather'][0]['main']),
      // 'dt' is in seconds, UTC
      date: DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000, isUtc: true)
          .toLocal(),
    );
  }

  Weather copyWith({
    String? city,
    int? temperature,
    int? minTemperature,
    int? maxTemperature,
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
