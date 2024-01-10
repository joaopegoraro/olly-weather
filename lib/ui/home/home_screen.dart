import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/components/dialog.dart';
import 'package:olly_weather/ui/components/navigator.dart';
import 'package:olly_weather/ui/components/snackbar.dart';
import 'package:olly_weather/ui/home/empty_list_indicator.dart';
import 'package:olly_weather/ui/home/home_model.dart';
import 'package:olly_weather/ui/home/settings_dialog.dart';
import 'package:olly_weather/ui/home/topbar.dart';
import 'package:olly_weather/ui/home/weather_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

          if (kIsWeb) {
            return Column(
              children: [
                Topbar(
                  title: model.cityName ?? "Welcome!",
                  onGeolocate: () => model
                      .updateCoordinates()
                      .then((_) => model.updateWeather()),
                  openSettings: model.openSettingsDialog,
                  onLogout: model.openLogoutDialog,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      child: model.weatherListByDate.isEmpty
                          ? EmptyListIndicator(
                              refreshPage: () => model
                                  .updateCoordinates()
                                  .then((_) => model.updateWeather()),
                            )
                          : WeatherList(
                              weatherListByDate: model.weatherListByDate,
                              weatherUnit: model.weatherUnit,
                            ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Stack(
              children: [
                NestedScrollView(
                  headerSliverBuilder: (_, __) {
                    return [
                      Topbar(
                        title: model.cityName ?? "Welcome!",
                        onGeolocate: () => model
                            .updateCoordinates()
                            .then((_) => model.updateWeather()),
                        openSettings: model.openSettingsDialog,
                        onLogout: model.openLogoutDialog,
                      ),
                    ];
                  },
                  body: Container(
                    padding: const EdgeInsets.all(32),
                    child: model.weatherListByDate.isEmpty
                        ? EmptyListIndicator(
                            refreshPage: () => model
                                .updateCoordinates()
                                .then((_) => model.updateWeather()),
                          )
                        : WeatherList(
                            weatherListByDate: model.weatherListByDate,
                            weatherUnit: model.weatherUnit,
                          ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
