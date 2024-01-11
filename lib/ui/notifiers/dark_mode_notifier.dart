import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olly_weather/data/repositories/preferences_repository.dart';

class DarkModeNotifier extends ChangeNotifier {
  DarkModeNotifier(this._preferencesRepository) {
    _getDarkMode().then((value) {
      _isDarkMode = value;
      notifyListeners();
    });
  }

  final PreferencesRepository _preferencesRepository;

  bool? _isDarkMode = false;
  bool? get isDarkMode => _isDarkMode;

  void setDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
    _preferencesRepository.setDarkMode(isDarkMode);
  }

  Future<bool?> _getDarkMode() async {
    return _preferencesRepository.getDarkMode();
  }
}

final darkModeNotifierProvider =
    ChangeNotifierProvider<DarkModeNotifier>((ref) {
  final preferencesRepository = ref.watch(preferencesRepositoryProvider);
  return DarkModeNotifier(preferencesRepository);
});
