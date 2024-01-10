enum WeatherUnit {
  metric("metric", "°C"),
  imperial("imperial", "°F"),
  standard("standard", "K");

  const WeatherUnit(this.value, this.simbol);
  final String value;
  final String simbol;

  factory WeatherUnit.fromValue(
    String? value, {
    WeatherUnit fallback = WeatherUnit.imperial,
  }) {
    return WeatherUnit.values.firstWhere(
      (element) => element.value == value,
      orElse: () => fallback,
    );
  }
}
