import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/data/services/auth_service.dart';

enum LoginEvent {
  showSnackbar,
  navigateToHome,
}

final loginModelProvider = ViewModelProviderFactory.create((ref) {
  final authService = ref.watch(authServiceProvider);
  return LoginModel(authService: authService);
});

class LoginModel extends ViewModel {
  LoginModel({required AuthService authService}) : _authService = authService;

  final AuthService _authService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> checkForAuthentication() async {
    updateUi(() => _isLoading = true);

    final isAuthenticated = await _authService.isUserAuthenticated();
    if (isAuthenticated) {
      emitEvent(LoginEvent.navigateToHome);
    }

    updateUi(() => _isLoading = false);
  }

  Future<void> performLogin(String username, String password) async {
    updateUi(() => _isLoading = true);

    await _authService.authenticateUser(username, password);

    showSnackbar("Login successful!", LoginEvent.showSnackbar);
    emitEvent(LoginEvent.navigateToHome);
    updateUi(() => _isLoading = false);
  }
}
