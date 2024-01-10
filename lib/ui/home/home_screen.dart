import 'package:flutter/material.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/home/home_model.dart';
import 'package:olly_weather/ui/home/topbar.dart';
import 'package:olly_weather/ui/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onEventEmitted(
    BuildContext context,
    HomeModel model,
    HomeEvent event,
  ) {
    switch (event) {
      case HomeEvent.showSnackbarSuccess:
        final snackBar = SnackBar(
          content: Text(model.snackbarMessage ?? ""),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      case HomeEvent.showSnackbarError:
        final snackBar = SnackBar(
          content: Text(model.snackbarMessage ?? ""),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      case HomeEvent.navigateToLogin:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
                    if (model.weatherList.isEmpty)
                      const Placeholder()
                    else
                      Text(model.weatherList.toString()),
                  ],
                );
              })),
    );
  }
}
