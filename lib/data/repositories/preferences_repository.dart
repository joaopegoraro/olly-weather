import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesRepository {
  Future<(double latitude, double longitude)?> findCoordinates();
  Future<WeatherUnit> findWeatherUnit();
  Future<void> saveCoordinates(double latitude, double longitude);
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
  Future<(double latitude, double longitude)?> findCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble(_latitudeKey);
    final longitude = prefs.getDouble(_longitudeKey);

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
  Future<void> saveCoordinates(double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latitudeKey, latitude);
    await prefs.setDouble(_longitudeKey, longitude);
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
