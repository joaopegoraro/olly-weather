enum WeatherUnit {
  metric("metric"),
  imperial("imperial"),
  standard("standard");

  const WeatherUnit(this.value);
  final String value;

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
