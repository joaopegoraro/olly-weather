import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:olly_weather/models/weather.dart';
import 'package:olly_weather/ui/theme/spacing.dart';
import 'package:olly_weather/ui/theme/text.dart';
import 'package:olly_weather/ui/theme/theme.dart';
import 'package:olly_weather/ui/utils/asset_manager.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.weather,
    required this.unit,
  });

  final Weather weather;
  final WeatherUnit unit;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final isWebDesign = deviceWidth > OllyWeatherTheme.mobileWidth;

    return Card(
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: OllyWeatherSpacing.tinyPadding,
          horizontal: OllyWeatherSpacing.mediumPadding,
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: isWebDesign ? MainAxisSize.min : MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather.formattedTime,
                  style: OllyWeatherText.titleStyle,
                  textAlign: TextAlign.end,
                ),
                OllyWeatherSpacing.horizontalSpaceSmall,
                const Text(" - "),
                OllyWeatherSpacing.horizontalSpaceSmall,
                Text(
                  weather.description,
                  style: OllyWeatherText.titleStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset(
                  AssetManager.getIconForWeather(weather),
                  height: 100,
                  width: 100,
                ),
                OllyWeatherSpacing.horizontalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${weather.temperature} ${unit.simbol}",
                      style: OllyWeatherText.largeStyle,
                    ),
                    OllyWeatherSpacing.horizontalSpaceRegular,
                    Column(
                      children: [
                        Text(
                          "${weather.minTemperature} ${unit.simbol}",
                          style: OllyWeatherText.titleStyle.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          "${weather.maxTemperature} ${unit.simbol}",
                          style: OllyWeatherText.titleStyle.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
