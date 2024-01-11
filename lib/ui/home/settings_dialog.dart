import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:olly_weather/ui/components/dialog.dart';
import 'package:olly_weather/ui/notifiers/dark_mode_notifier.dart';
import 'package:olly_weather/ui/theme/spacing.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({
    super.key,
    required this.currentUnit,
    required this.onSave,
  });

  final WeatherUnit currentUnit;
  final Function(WeatherUnit) onSave;

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late WeatherUnit selectedUnit = widget.currentUnit;

  void _selectUnit(WeatherUnit? newUnit) {
    setState(() {
      selectedUnit = newUnit ?? widget.currentUnit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final darkModeNotifier = ref.read(darkModeNotifierProvider);
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      return OllyWeatherDialog(
        title: "Settings",
        firstButtonText: "Save",
        onTapFirstButton: () => widget.onSave(selectedUnit),
        secondButtonText: "Cancel",
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Dark mode"),
              onTap: () => darkModeNotifier.setDarkMode(!isDarkMode),
              trailing: Switch(
                value: isDarkMode,
                onChanged: darkModeNotifier.setDarkMode,
              ),
            ),
            OllyWeatherSpacing.verticalSpaceRegular,
            const Text("Update the temperature unit to be used"),
            OllyWeatherSpacing.verticalSpaceSmall,
            ListTile(
              title: const Text("Imperial"),
              onTap: () => _selectUnit(WeatherUnit.imperial),
              leading: Radio(
                value: WeatherUnit.imperial,
                groupValue: selectedUnit,
                onChanged: _selectUnit,
              ),
            ),
            ListTile(
              title: const Text("Metric"),
              onTap: () => _selectUnit(WeatherUnit.metric),
              leading: Radio(
                value: WeatherUnit.metric,
                groupValue: selectedUnit,
                onChanged: _selectUnit,
              ),
            ),
            ListTile(
              title: const Text("Standard"),
              onTap: () => _selectUnit(WeatherUnit.standard),
              leading: Radio(
                value: WeatherUnit.standard,
                groupValue: selectedUnit,
                onChanged: _selectUnit,
              ),
            ),
          ],
        ),
      );
    });
  }
}
