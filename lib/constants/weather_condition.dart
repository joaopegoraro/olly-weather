enum WeatherCondition {
  thunderstorm("Thunderstorm"),
  drizzle("Drizzle"),
  rain("Rain"),
  snow("Snow"),
  mist("Mist"),
  smoke("Smoke"),
  haze("Haze"),
  dust("Dust"),
  fog("Fog"),
  sand("Sand"),
  tornado("Tornado"),
  clear("Clear"),
  clouds("Clouds");

  const WeatherCondition(this.value);
  final String value;

  factory WeatherCondition.fromValue(
    String? value, {
    WeatherCondition fallback = WeatherCondition.haze,
  }) {
    return WeatherCondition.values.firstWhere(
      (element) => element.value == value,
      orElse: () => fallback,
    );
  }
}
