import 'package:flutter/material.dart';
import 'package:olly_weather/ui/theme/spacing.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.isPassword,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        labelText: widget.label,
        filled: true,
        suffixIcon: !widget.isPassword
            ? null
            : IconButton(
                onPressed: () => setState(() {
                  isPasswordVisible = !isPasswordVisible;
                }),
                icon: isPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OllyWeatherSpacing.mediumRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
