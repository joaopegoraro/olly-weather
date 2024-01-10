import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/data/services/auth_service.dart';

enum LoginEvent {
  showSnackbarSuccess,
  showSnackbarError,
  navigateToHome,
}

final loginModelProvider = ViewModelProviderFactory.create((ref) {
  final authService = ref.watch(authServiceProvider);
  return LoginModel(authService: authService);
});

class LoginModel extends ViewModel<LoginEvent> {
  LoginModel({required AuthService authService}) : _authService = authService;

  final AuthService _authService;

  bool _isScreenLoading = false;
  bool get isScreenLoading => _isScreenLoading;

  bool _isButtonLoading = false;
  bool get isButtonLoading => _isButtonLoading;

  Future<void> checkForAuthentication() async {
    updateUi(() => _isScreenLoading = true);

    final isAuthenticated = await _authService.isUserAuthenticated();
    if (isAuthenticated) {
      emitEvent(LoginEvent.navigateToHome);
    }

    updateUi(() => _isScreenLoading = false);
  }

  Future<void> performLogin(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return showSnackbar(
        "The username and password can't be empty!",
        LoginEvent.showSnackbarError,
      );
    }

    updateUi(() => _isButtonLoading = true);

    await _authService.authenticateUser(username, password);

    showSnackbar("Login successful!", LoginEvent.showSnackbarSuccess);
    emitEvent(LoginEvent.navigateToHome);
    updateUi(() => _isButtonLoading = false);
  }
}
