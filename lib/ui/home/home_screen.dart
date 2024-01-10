import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/components/dialog.dart';
import 'package:olly_weather/ui/components/navigator.dart';
import 'package:olly_weather/ui/components/snackbar.dart';
import 'package:olly_weather/ui/home/home_model.dart';
import 'package:olly_weather/ui/home/settings_dialog.dart';
import 'package:olly_weather/ui/home/topbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              model.updateWeather();
              model.fetchWeatherUnit();
            });
          },
          builder: (context, model) {
            if (model.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return PopScope(
              canPop: false,
              onPopInvoked: (_) => model.openLogoutDialog,
              child: Column(
                children: [
                  Topbar(
                    title: model.weatherList.firstOrNull?.city ?? "Welcome!",
                    onGeolocate: () => model
                        .updateCoordinates()
                        .then((_) => model.updateWeather()),
                    openSettings: model.openSettingsDialog,
                    onLogout: model.openLogoutDialog,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(32, 100, 32, 32),
                      child: model.weatherList.isEmpty
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
                          : Lottie.asset(
                              'assets/svg/drizzle.json',
                            ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
