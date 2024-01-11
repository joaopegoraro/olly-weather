import 'package:olly_weather/constants/weather_condition.dart';
import 'package:olly_weather/models/weather.dart';

class AssetManager {
  const AssetManager._();

  static const assetsPath = "assets";
  static const lottieAssetsPath = "$assetsPath/lottie";

  static final conditionIconMap = <WeatherCondition, String>{
    WeatherCondition.thunderstorm: "thunderstorms",
    WeatherCondition.drizzle: "drizzle",
    WeatherCondition.rain: "rain",
    WeatherCondition.snow: "snow",
    WeatherCondition.mist: "mist",
    WeatherCondition.smoke: "smoke",
    WeatherCondition.haze: "haze",
    WeatherCondition.dust: "dust",
    WeatherCondition.fog: "fog",
    WeatherCondition.sand: "sand",
    WeatherCondition.tornado: "tornado",
    WeatherCondition.clouds: "cloudy",
    WeatherCondition.clear: "clear-day",
  };

  static String getIconForWeather(Weather weather) {
    if (weather.condition == WeatherCondition.clear && weather.isNight) {
      return "clear-night";
    }

    return "$lottieAssetsPath/${conditionIconMap[weather.condition]}";
  }
}
