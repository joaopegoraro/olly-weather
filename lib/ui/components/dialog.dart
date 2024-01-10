import 'package:flutter/material.dart';

class OllyWeatherDialog extends StatelessWidget {
  const OllyWeatherDialog({
    super.key,
    required this.content,
    required this.firstButtonText,
    required this.title,
    this.onTapFirstButton,
    this.secondButtonText,
    this.onTapSecondButton,
  });

  static void show({
    required BuildContext context,
    required String content,
    required String firstButtonText,
    required String title,
    VoidCallback? onTapFirstButton,
    String? secondButtonText,
    VoidCallback? onTapSecondButton,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return OllyWeatherDialog(
            content: content,
            firstButtonText: firstButtonText,
            title: title,
            onTapFirstButton: onTapFirstButton,
            secondButtonText: secondButtonText,
            onTapSecondButton: onTapSecondButton,
          );
        });
  }

  final String title;
  final String content;

  final String firstButtonText;
  final VoidCallback? onTapFirstButton;

  final String? secondButtonText;
  final VoidCallback? onTapSecondButton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onTapFirstButton ?? Navigator.of(context).pop,
          child: Text(
            firstButtonText,
            textAlign: TextAlign.end,
          ),
        ),
        if (secondButtonText != null)
          TextButton(
            onPressed: onTapSecondButton ?? Navigator.of(context).pop,
            child: Text(
              secondButtonText!,
              textAlign: TextAlign.end,
            ),
          ),
      ],
    );
  }
}
