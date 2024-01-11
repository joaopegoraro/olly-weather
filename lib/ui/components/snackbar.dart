import 'package:flutter/material.dart';
import 'package:olly_weather/ui/theme/spacing.dart';

class OllyWeatherSnackbar extends SnackBar {
  OllyWeatherSnackbar({
    super.key,
    required String? text,
    Color? backgroundColor,
  }) : super(
          content: Text(text ?? ""),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(
            OllyWeatherSpacing.regularPadding,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                OllyWeatherSpacing.tinyRadius,
              ),
            ),
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
