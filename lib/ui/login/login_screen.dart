import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/home/home_screen.dart';
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
        final snackBar = SnackBar(
          content: Text(model.snackbarMessage ?? ""),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      case LoginEvent.showSnackbarError:
        final snackBar = SnackBar(
          content: Text(model.snackbarMessage ?? ""),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      case LoginEvent.navigateToHome:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
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

          if (kIsWeb) {
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
