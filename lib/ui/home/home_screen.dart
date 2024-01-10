import 'package:flutter/material.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/components/dialog.dart';
import 'package:olly_weather/ui/components/navigator.dart';
import 'package:olly_weather/ui/components/snackbar.dart';
import 'package:olly_weather/ui/home/home_model.dart';
import 'package:olly_weather/ui/home/settings_dialog.dart';
import 'package:olly_weather/ui/home/topbar.dart';
import 'package:olly_weather/ui/home/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void _onEventEmitted(
    BuildContext context,
    HomeModel model,
    HomeEvent event,
  ) {
    switch (event) {
      case HomeEvent.showSnackbarSuccess:
        OllyWeatherSnackbar.showSuccess(context, model.snackbarMessage);
      case HomeEvent.showSnackbarError:
        OllyWeatherSnackbar.showError(context, model.snackbarMessage);
      case HomeEvent.navigateToLogin:
        OllyWeatherNavigator.navigateToLogin(context);
      case HomeEvent.openLogoutDialog:
        OllyWeatherDialog.showTextDialog(
          context: context,
          title: "Warning",
          content: "Are you sure? You will go back to the login page",
          firstButtonText: "I'm sure, log me out",
          onTapFirstButton: model.logout,
          secondButtonText: "No, cancel that",
        );
      case HomeEvent.openSettingsDialog:
        showDialog(
          context: context,
          builder: (context) => SettingsDialog(
            currentUnit: model.weatherUnit,
            onSave: (newUnit) => model
                .updateWeatherUnit(newUnit)
                .then((_) => model.updateWeather())
                .then((_) => Navigator.of(context).pop()),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder(
          provider: homeModelProvider,
          onEventEmitted: _onEventEmitted,
          onCreate: (model) {
            // since HomeModel::updateWeather updates the UI, and
            // 'onCreate' is called at the first draw of the screen, this
            // addPostFrameCallback is necessary so the UI updates only
            // after the first draw
            WidgetsBinding.instance.addPostFrameCallback((_) {
              model.fetchWeatherUnit().then((_) => model.updateWeather());
            });
          },
          builder: (context, model) {
            if (model.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                NestedScrollView(
                    headerSliverBuilder: (_, __) => [
                          Topbar(
                            title: model.cityName ?? "Welcome!",
                            onGeolocate: () => model
                                .updateCoordinates()
                                .then((_) => model.updateWeather()),
                            openSettings: model.openSettingsDialog,
                            onLogout: model.openLogoutDialog,
                          ),
                        ],
                    body: Container(
                        padding: const EdgeInsets.all(32),
                        child: model.weatherListByDate.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => model
                                        .updateCoordinates()
                                        .then((_) => model.updateWeather()),
                                    icon: const Icon(Icons.gps_fixed),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "No weather data found. Try clicking on the tracking icon in the topbar to update your coordinates and fetch the weather data for your location",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : PageView.builder(
                                controller: _pageController,
                                itemCount: model.weatherListByDate.length,
                                itemBuilder: (context, index) {
                                  final weatherList = model
                                      .weatherListByDate.entries
                                      .elementAt(index)
                                      .value;
                                  return Column(
                                    children: [
                                      Text(
                                        weatherList.first.weekdayName,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Expanded(
                                        child: ListView(
                                          children: weatherList.map((weather) {
                                            return WeatherCard(
                                              weather: weather,
                                              unit: model.weatherUnit,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ))),
              ],
            );
          }),
    );
  }
}
