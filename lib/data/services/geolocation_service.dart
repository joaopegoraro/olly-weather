import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olly_weather/constants/geolocation_errors.dart';

abstract class GeolocationService {
  Future<(double latitude, double longitude)> getCoordinates();
}

class GeolocationServiceImpl extends GeolocationService {
  @override
  Future<(double latitude, double longitude)> getCoordinates() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(const DisabledGeolocation());
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(const DeniedGeolocation());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(const PermanentlyDeniedGeolocation());
    }

    final position = await Geolocator.getCurrentPosition();
    return (position.latitude, position.longitude);
  }
}

final geolocationServiceProvider = Provider<GeolocationService>((ref) {
  return GeolocationServiceImpl();
});
