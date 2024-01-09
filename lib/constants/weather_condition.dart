enum WeatherCondition {
  thunderstorm("Thunderstorm"),
  drizzle("Drizzle"),
  rain("Rain"),
  snow("Snow"),
  atmospheric("Atmosphere"),
  clear("Clear"),
  clouds("Clouds");

  const WeatherCondition(this.value);
  final String value;

  factory WeatherCondition.fromValue(
    String? value, {
    WeatherCondition fallback = WeatherCondition.atmospheric,
  }) {
    return WeatherCondition.values.firstWhere(
      (element) => element.value == value,
      orElse: () => fallback,
    );
  }
}
