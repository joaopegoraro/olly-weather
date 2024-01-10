import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/constants/geolocation_errors.dart';
import 'package:olly_weather/data/repositories/preferences_repository.dart';
import 'package:olly_weather/data/repositories/weather_repository.dart';
import 'package:olly_weather/data/services/auth_service.dart';
import 'package:olly_weather/data/services/geolocation_service.dart';
import 'package:olly_weather/models/weather.dart';

enum HomeEvent {
  showSnackbarSuccess,
  showSnackbarError,
  openSettingsDialog,
  openLogoutDialog,
  navigateToLogin,
}

final homeModelProvider = ViewModelProviderFactory.create((ref) {
  final authService = ref.watch(authServiceProvider);
  final geoService = ref.watch(geolocationServiceProvider);
  final preferencesRepository = ref.watch(preferencesRepositoryProvider);
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return HomeModel(
    authService: authService,
    geolocationService: geoService,
    preferencesRepository: preferencesRepository,
    weatherRepository: weatherRepository,
  );
});

class HomeModel extends ViewModel<HomeEvent> {
  HomeModel({
    required AuthService authService,
    required GeolocationService geolocationService,
    required PreferencesRepository preferencesRepository,
    required WeatherRepository weatherRepository,
  })  : _authService = authService,
        _geoService = geolocationService,
        _prefsRepository = preferencesRepository,
        _weatherRepository = weatherRepository;

  final AuthService _authService;
  final GeolocationService _geoService;
  final PreferencesRepository _prefsRepository;
  final WeatherRepository _weatherRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Weather> _weatherList = [];
  List<Weather> get weatherList => _weatherList;

  void openSettingsDialog() {
    emitEvent(HomeEvent.openSettingsDialog);
  }

  void openLogoutDialog() {
    emitEvent(HomeEvent.openLogoutDialog);
  }

  Future<void> logout() async {
    await _authService.logoutUser();
    await _prefsRepository.clear();
    showSnackbar("Logout successful!", HomeEvent.showSnackbarSuccess);
    emitEvent(HomeEvent.navigateToLogin);
  }

  Future<void> updateCoordinates() async {
    try {
      updateUi(() => _isLoading = true);

      final (latitude, longitude) = await _geoService.getCoordinates();
      await _prefsRepository.saveCoordinates(latitude, longitude);

      showSnackbar(
        "Coordinates updated successfully!",
        HomeEvent.showSnackbarSuccess,
      );
    } on GeolocationError catch (e) {
      showSnackbar(e.message, HomeEvent.showSnackbarError);
    } finally {
      updateUi(() => _isLoading = false);
    }
  }

  Future<void> updateWeather() async {
    updateUi(() => _isLoading = true);

    final (latitude, longitude) = await _prefsRepository.findCoordinates();
    if (latitude == null || longitude == null) {
      updateUi(() => _isLoading = false);
      return showSnackbar(
        "No coordinates found. Click on the tracking button at the topbar to update your coordinates",
        HomeEvent.showSnackbarError,
      );
    }

    final apiResponse = await _weatherRepository.findWeather(
      latitude,
      longitude,
    );
    updateUi(() => _weatherList = apiResponse);

    if (_weatherList.isEmpty) {
      showSnackbar(
        "There was a problem retrieving the weather data",
        HomeEvent.showSnackbarError,
      );
    }

    updateUi(() => _isLoading = false);
  }
}
