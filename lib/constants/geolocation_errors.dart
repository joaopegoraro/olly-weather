class GeolocationError implements Exception {
  const GeolocationError([this.message]);

  final String? message;

  @override
  String toString() {
    return "GeolocationError: $message";
  }
}

class DisabledGeolocation extends GeolocationError {
  const DisabledGeolocation()
      : super(
            "Your location services are disabled. The app needs your location to fetch the correct weather data");
}

class DeniedGeolocation extends GeolocationError {
  const DeniedGeolocation()
      : super(
            "The app needs permission to access you device location and fetch the correct weather data");
}

class PermanentlyDeniedGeolocation extends GeolocationError {
  const PermanentlyDeniedGeolocation()
      : super(
            "You have permanently denied the app the permission to access your device location. Without it, the app can't fetch the correct weather data");
}
