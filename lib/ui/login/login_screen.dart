import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/components/navigator.dart';
import 'package:olly_weather/ui/components/snackbar.dart';
import 'package:olly_weather/ui/login/login_model.dart';
import 'package:olly_weather/ui/login/login_panel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEventEmitted(
    BuildContext context,
    LoginModel model,
    LoginEvent event,
  ) {
    switch (event) {
      case LoginEvent.showSnackbarSuccess:
        OllyWeatherSnackbar.showSuccess(context, model.snackbarMessage);
      case LoginEvent.showSnackbarError:
        OllyWeatherSnackbar.showError(context, model.snackbarMessage);
      case LoginEvent.navigateToHome:
        OllyWeatherNavigator.navigateToHome(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder(
        provider: loginModelProvider,
        onCreate: (model) {
          // since LoginModel::checkForAuthentication updates the UI, and
          // 'onCreate' is called at the first draw of the screen, this
          // addPostFrameCallback is necessary so the UI updates only
          // after the first draw
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => model.checkForAuthentication(),
          );
        },
        onEventEmitted: _onEventEmitted,
        builder: (context, model) {
          if (model.isScreenLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final isWebDesign = MediaQuery.of(context).size.width > 680;
          if (isWebDesign) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.center,
              child: LoginPanel(
                usernameController: _usernameController,
                passwordController: _passwordController,
                isLoading: model.isButtonLoading,
                width: max(MediaQuery.of(context).size.width * 0.3, 600),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onSubmit: () => model.performLogin(
                  username: _usernameController.text,
                  password: _passwordController.text,
                ),
              ),
            );
          } else {
            return LoginPanel(
              usernameController: _usernameController,
              passwordController: _passwordController,
              isLoading: model.isButtonLoading,
              onSubmit: () => model.performLogin(
                username: _usernameController.text,
                password: _passwordController.text,
              ),
            );
          }
        },
      ),
    );
  }
}
