import 'package:flutter/material.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:olly_weather/ui/components/dialog.dart';

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
    return OllyWeatherDialog(
      title: "Settings",
      firstButtonText: "Save",
      onTapFirstButton: () => widget.onSave(selectedUnit),
      secondButtonText: "Cancel",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Update the temperature unit to be used"),
          const SizedBox(height: 10),
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
  }
}