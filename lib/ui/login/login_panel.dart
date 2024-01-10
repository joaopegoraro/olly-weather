import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olly_weather/ui/login/login_text_field.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class LoginPanel extends StatelessWidget {
  const LoginPanel({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.isLoading,
    required this.onSubmit,
    this.width,
    this.decoration,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isLoading;
  final Function onSubmit;
  final double? width;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      width: width,
      decoration: decoration,
      // annoyingly, center aligning in web negates ListView.shrinkWrap, so
      // this check is necessary
      alignment: kIsWeb ? null : Alignment.center,
      child: ListView(
        shrinkWrap: true,
        children: [
          const SvgPicture(
            AssetBytesLoader('assets/vectors/logo.svg.vec'),
          ),
          const SizedBox(height: 40),
          LoginTextField(
            controller: usernameController,
            label: 'Username',
            isPassword: false,
          ),
          const SizedBox(height: 10),
          LoginTextField(
            controller: passwordController,
            label: 'Password',
            isPassword: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      "SIGN IN",
                      style: TextStyle(fontSize: 18),
                    ),
            ),
            onPressed: () {
              if (isLoading) {
                return;
              }

              FocusScope.of(context).unfocus();
              onSubmit();
            },
          ),
        ],
      ),
    );
  }
}
