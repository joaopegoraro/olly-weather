import 'package:flutter/material.dart';
import 'package:olly_weather/ui/components/dialog.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
    required this.onLogout,
  });

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return OllyWeatherDialog(
      title: "Warning",
      content: "Are you sure about that? You will go back to the login page",
      firstButtonText: "I'm sure, log me out",
      onTapFirstButton: onLogout,
      secondButtonText: "Cancel that",
    );
  }
}
