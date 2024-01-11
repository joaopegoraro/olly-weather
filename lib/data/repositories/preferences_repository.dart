import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesRepository {
  Future<bool?> getDarkMode();
  Future<WeatherUnit> getWeatherUnit();
  Future<(double? latitude, double? longitude)> getCoordinates();
  Future<void> setDarkMode(bool darkMode);
  Future<void> setCoordinates(double latitude, double longitude);
  Future<void> setWeatherUnit(WeatherUnit unit);
  Future<void> clear();
}

class PreferencesRepositoryImpl extends PreferencesRepository {
  static const _darkModeKey = "dark_mode";
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
  Future<bool?> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey);
  }

  @override
  Future<(double? latitude, double? longitude)> getCoordinates() async {
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble(_latitudeKey);
    final longitude = prefs.getDouble(_longitudeKey);

    return (latitude, longitude);
  }

  @override
  Future<WeatherUnit> getWeatherUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final unitValue = prefs.getString(_weatherUnitKey);
    return WeatherUnit.fromValue(unitValue);
  }

  @override
  Future<void> setDarkMode(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, darkMode);
  }

  @override
  Future<void> setCoordinates(double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latitudeKey, latitude);
    await prefs.setDouble(_longitudeKey, longitude);
  }

  @override
  Future<void> setWeatherUnit(WeatherUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weatherUnitKey, unit.value);
  }
}

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepositoryImpl();
});
