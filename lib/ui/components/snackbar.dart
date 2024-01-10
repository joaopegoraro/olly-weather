import 'package:flutter/material.dart';

class OllyWeatherSnackbar extends SnackBar {
  OllyWeatherSnackbar({
    super.key,
    required String? text,
    Color? backgroundColor,
  }) : super(
          content: Text(text ?? ""),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        );

  static showSuccess(BuildContext context, String? text) {
    final snackBar = OllyWeatherSnackbar(
      text: text,
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showError(BuildContext context, String? text) {
    final snackBar = OllyWeatherSnackbar(
      text: text,
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
