import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService {
  Future<bool> isUserAuthenticated();
  Future<void> authenticateUser(String username, String password);
  Future<void> logoutUser();
}

class AuthServiceImpl extends AuthService {
  static const _tokenKey = "token";

  @override
  Future<bool> isUserAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey)?.isNotEmpty == true;
  }

  @override
  Future<void> authenticateUser(String username, String password) async {
    // simulate api call
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, "some_token_from_api");
  }

  @override
  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthServiceImpl();
});
