import 'package:geolocator/geolocator.dart';

/// Lib Wrapper more for helping on mocking when testing.
class LibWrapper {
  final Geolocator geolocator = Geolocator();

  Stream<Position> getCurrentLocationStream() {
    final _locationOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    return geolocator.getPositionStream(_locationOptions);
  }

  Future<Position> getCurrentLocation() => Geolocator().getCurrentPosition();

  Future<GeolocationStatus> checkPermission() =>
      Geolocator().checkGeolocationPermissionStatus();
}
