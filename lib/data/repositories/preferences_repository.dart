import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesRepository {
  Future<(String, String)?> findCoordinates();
  Future<WeatherUnit> findWeatherUnit();
  Future<void> saveCoordinates(String latitude, String longitude);
  Future<void> saveWeatherUnit(WeatherUnit unit);
  Future<void> clear();
}

class PreferencesRepositoryImpl extends PreferencesRepository {
  static const _latitudeKey = "latitude";
  static const _longitudeKey = "longitude";
  static const _weatherUnitKey = "weather_unit";

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_latitudeKey);
    await prefs.remove(_longitudeKey);
    await prefs.remove(_weatherUnitKey);
  }

  @override
  Future<(String, String)?> findCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getString(_latitudeKey);
    final longitude = prefs.getString(_longitudeKey);

    if (longitude == null || latitude == null) {
      return null;
    }

    return (latitude, longitude);
  }

  @override
  Future<WeatherUnit> findWeatherUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final unitValue = prefs.getString(_weatherUnitKey);
    return WeatherUnit.fromValue(unitValue);
  }

  @override
  Future<void> saveCoordinates(String latitude, String longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_latitudeKey, latitude);
    await prefs.setString(_longitudeKey, longitude);
  }

  @override
  Future<void> saveWeatherUnit(WeatherUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weatherUnitKey, unit.value);
  }
}

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepositoryImpl();
});
