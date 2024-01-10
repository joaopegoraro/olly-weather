import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/home/home_screen.dart';
import 'package:olly_weather/ui/login/login_model.dart';
import 'package:olly_weather/ui/login/login_text_field.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

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
          //'onCreate' is called at the first draw of the screen, this
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

          return Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SvgPicture(
                  AssetBytesLoader('assets/vectors/logo.svg.vec'),
                ),
                const SizedBox(height: 40),
                LoginTextField(
                  controller: _usernameController,
                  label: 'Username',
                  isPassword: false,
                ),
                const SizedBox(height: 10),
                LoginTextField(
                  controller: _passwordController,
                  label: 'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: model.isButtonLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "SIGN IN",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    model.performLogin(
                      _usernameController.text,
                      _passwordController.text,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
