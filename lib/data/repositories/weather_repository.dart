import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:olly_weather/data/services/api_service.dart';
import 'package:olly_weather/models/weather.dart';

abstract class WeatherRepository {
  Future<List<Weather>> findWeather(
    double latitude,
    double longitude, {
    required WeatherUnit unit,
  });
}

class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<List<Weather>> findWeather(
    double latitude,
    double longitude, {
    required WeatherUnit unit,
  }) async {
    final weatherList = await _apiService.getForecast(
      latitude,
      longitude,
      unit: unit,
    );
    return weatherList ?? [];
  }
}

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return WeatherRepositoryImpl(apiService: apiService);
});
