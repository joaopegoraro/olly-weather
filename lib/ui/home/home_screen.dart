import 'package:flutter/material.dart';
import 'package:mvvm_riverpod/mvvm_riverpod.dart';
import 'package:olly_weather/ui/home/home_model.dart';
import 'package:olly_weather/ui/home/topbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                      openSettings: model.openSettingsDialog,
                      onLogout: model.openLogoutDialog,
                    ),
                    const Placeholder(),
                  ],
                );
              })),
    );
  }
}
