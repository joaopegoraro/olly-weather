import 'package:flutter/material.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/components/navigator.dart';
import 'package:olly_weather/ui/components/snackbar.dart';
import 'package:olly_weather/ui/home/home_model.dart';
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
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            // TODO
            return;
          },
          child: ViewModelBuilder(
              provider: homeModelProvider,
              onEventEmitted: _onEventEmitted,
              onCreate: (model) {
                // since HomeModel::updateWeather updates the UI, and
                // 'onCreate' is called at the first draw of the screen, this
                // addPostFrameCallback is necessary so the UI updates only
                // after the first draw
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => model.updateWeather(),
                );
              },
              builder: (context, model) {
                if (model.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
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
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(32),
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
                            : Text(model.weatherList.toString()),
                      ),
                    )
                  ],
                );
              })),
    );
  }
}
