import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/data/services/auth_service.dart';
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
  return HomeModel(authService: authService);
});

class HomeModel extends ViewModel<HomeEvent> {
  HomeModel({required AuthService authService}) : _authService = authService;

  final AuthService _authService;

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
    showSnackbar("Logout successful!", HomeEvent.showSnackbarSuccess);
    emitEvent(HomeEvent.navigateToLogin);
  }
}
