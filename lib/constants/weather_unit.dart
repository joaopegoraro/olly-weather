enum WeatherUnit {
  metric("metric"),
  imperial("imperial"),
  standard("standard");

  const WeatherUnit(this.value);
  final String value;
}
