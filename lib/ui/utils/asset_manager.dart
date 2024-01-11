import 'package:olly_weather/constants/weather_condition.dart';
import 'package:olly_weather/models/weather.dart';

class AssetManager {
  const AssetManager._();

  static const assetsPath = "assets";
  static const lottieAssetsPath = "$assetsPath/lottie";

  static final conditionIconMap = <WeatherCondition, String>{
    WeatherCondition.thunderstorm: "thunderstorms.json",
    WeatherCondition.drizzle: "drizzle.json",
    WeatherCondition.rain: "rain.json",
    WeatherCondition.snow: "snow.json",
    WeatherCondition.mist: "mist.json",
    WeatherCondition.smoke: "smoke.json",
    WeatherCondition.haze: "haze.json",
    WeatherCondition.dust: "dust.json",
    WeatherCondition.fog: "fog.json",
    WeatherCondition.sand: "sand.json",
    WeatherCondition.tornado: "tornado.json",
    WeatherCondition.clouds: "cloudy.json",
    WeatherCondition.clear: "clear-day.json",
  };

  static String getIconForWeather(Weather weather) {
    if (weather.condition == WeatherCondition.clear && weather.isNight) {
      return "$lottieAssetsPath/clear-night.json";
    }

    return "$lottieAssetsPath/${conditionIconMap[weather.condition]}";
  }
}
