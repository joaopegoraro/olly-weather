import 'package:flutter/material.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:olly_weather/models/weather.dart';
import 'package:olly_weather/ui/home/weather_card.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({
    super.key,
    required this.weatherListByDate,
    required this.weatherUnit,
  });

  final Map<DateTime, List<Weather>> weatherListByDate;
  final WeatherUnit weatherUnit;

  @override
  State<WeatherList> createState() => WeatherListState();
}

class WeatherListState extends State<WeatherList> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      : () => _pageController.previousPage(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.easeIn,
                          ),
                  icon: const Icon(Icons.arrow_left),
                ),
                Text(
                  list.first.weekdayName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: index == widget.weatherListByDate.length - 1
                      ? null
                      : () => _pageController.nextPage(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.easeIn,
                          ),
                  icon: const Icon(Icons.arrow_right),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
