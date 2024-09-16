import 'package:geolocator/geolocator.dart';
import 'dart:math';
import '../exports/main_export.dart';

class _AppLocation {
  bool _serviceEnabled = false;
  LocationPermission _permissionGranted = LocationPermission.denied;

  // Constant latitude and longitude for the desired location
  final double targetLatitude = 40.3445048;
  final double targetLongitude = 48.0584126;
  /// jog location
  // final double targetLatitude = 30.3445048;
  // final double targetLongitude = 78.0584126;
  final double radiusInMeters = 100.0;

  void init() {
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      _showPermissionPopup("Location service is disabled.");
      return;
    }

    _permissionGranted = await Geolocator.checkPermission();
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted == LocationPermission.deniedForever ||
          _permissionGranted == LocationPermission.denied) {
        _showPermissionPopup(
            "Location permission denied. Please enable it in settings.");
        return;
      }
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      print("lat: ${position.latitude} , long: ${position.longitude}");
      bool isInRange = _checkIfInRange(position.latitude, position.longitude);
      if (isInRange) {
        // User is in range, proceed with your app
        print("User is within the range. Proceeding with the app.");
      } else {
        // User is not in range, show popup
        _showNotInRangePopup();
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  bool _checkIfInRange(double userLat, double userLng) {
    double distance =
        _calculateDistance(userLat, userLng, targetLatitude, targetLongitude);
    return distance <= radiusInMeters;
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // Radius of the Earth in meters
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distance in meters
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void _showNotInRangePopup() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text('Out of Range'),
        content: Text('You are not within the specified location range.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPermissionPopup(String message) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text('Permission Required'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              // Optionally open settings if needed
              Geolocator.openLocationSettings();
            },
            child: Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}

var appLocation = _AppLocation();
