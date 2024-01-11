import 'package:flutter/material.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:olly_weather/models/weather.dart';
import 'package:olly_weather/ui/home/weather_card.dart';
import 'package:olly_weather/ui/theme/spacing.dart';
import 'package:olly_weather/ui/theme/text.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({
    super.key,
    required this.weatherListByDate,
    required this.weatherUnit,
    required this.isWebDesign,
  });

  final Map<DateTime, List<Weather>> weatherListByDate;
  final WeatherUnit weatherUnit;
  final bool isWebDesign;

  @override
  State<WeatherList> createState() => WeatherListState();
}

class WeatherListState extends State<WeatherList> {
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    if (!widget.isWebDesign) {
      _pageController = PageController(initialPage: 0);
    }
  }

  @override
  void dispose() {
    if (!widget.isWebDesign) {
      _pageController?.dispose();
      _pageController = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isWebDesign) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.weatherListByDate.length,
        itemBuilder: (context, index) {
          final list = widget.weatherListByDate.entries.elementAt(index).value;
          final isLastElement = index == widget.weatherListByDate.length - 1;
          return Column(
            children: [
              OllyWeatherSpacing.verticalSpaceLarge,
              Text(
                list.first.weekdayName,
                style: OllyWeatherText.largeStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              OllyWeatherSpacing.verticalSpaceRegular,
              Wrap(
                alignment: WrapAlignment.center,
                children: list.map((weather) {
                  return SizedBox(
                    width: 300,
                    child: WeatherCard(
                      weather: weather,
                      unit: widget.weatherUnit,
                    ),
                  );
                }).toList(),
              ),
              OllyWeatherSpacing.verticalSpaceLarge,
              if (!isLastElement) const Divider(),
            ],
          );
        },
      );
    } else {
      return PageView.builder(
        controller: _pageController,
        itemCount: widget.weatherListByDate.length,
        itemBuilder: (context, index) {
          final list = widget.weatherListByDate.entries.elementAt(index).value;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: index == 0
                        ? null
                        : () => _pageController?.previousPage(
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              curve: Curves.easeIn,
                            ),
                    icon: const Icon(Icons.arrow_left),
                  ),
                  Text(
                    list.first.weekdayName,
                    style: OllyWeatherText.largeStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: index == widget.weatherListByDate.length - 1
                        ? null
                        : () => _pageController?.nextPage(
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              curve: Curves.easeIn,
                            ),
                    icon: const Icon(Icons.arrow_right),
                  ),
                ],
              ),
              OllyWeatherSpacing.verticalSpaceRegular,
              Expanded(
                child: ListView(
                  children: list.map((weather) {
                    return WeatherCard(
                      weather: weather,
                      unit: widget.weatherUnit,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
