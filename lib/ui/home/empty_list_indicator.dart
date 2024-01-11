import 'package:flutter/material.dart';
import 'package:olly_weather/ui/theme/spacing.dart';

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({
    super.key,
    required this.refreshPage,
  });

  final VoidCallback refreshPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: refreshPage,
          icon: const Icon(Icons.gps_fixed),
        ),
        OllyWeatherSpacing.verticalSpaceRegular,
        const Text(
          "No weather data found. Try clicking on the tracking icon in the topbar to update your coordinates and fetch the weather data for your location",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
