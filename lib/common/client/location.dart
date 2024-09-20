import 'package:geolocator/geolocator.dart';
import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/permissson/permission.dart';
import 'dart:math';
import '../exports/main_export.dart';

class _AppLocation {
  bool _serviceEnabled = false;
  LocationPermission _permissionGranted = LocationPermission.denied;

  /// jog location
  // final double targetLatitude = 30.3445048;
  // final double targetLongitude = 78.0584126;
  final double radiusInMeters = 500.0;

  Future<void> init({Function()? onDone}) async {
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   // Use current location
    // });
    await _userInRange(onDone: onDone);
  }

  /// with user range and permission provided by the user
  Future<void> _userInRange({Function()? onDone}) async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      _showPermissionPopup(
        "Location service is disabled.",
        init,
      );
      return;
    }

    _permissionGranted = await Geolocator.checkPermission();
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted == LocationPermission.deniedForever ||
          _permissionGranted == LocationPermission.denied) {
        _showPermissionPopup(
          "Location permission denied. Please enable it in settings.",
          init,
        );
        return;
      }
    }

    await _getCurrentLocation(onDone: onDone);
  }

  /// check that the user is in range or not
  Future<void> _getCurrentLocation({Function()? onDone}) async {
    try {
      /// user current positions
      Position position = await Geolocator.getCurrentPosition();

      /// range o locations
      var locations = await LocationModel.getLocations();

      print("lat: ${position.latitude} , long: ${position.longitude}");

      int i = 0;
      bool isInRange = false;
      do {
        var data = locations[i];
        isInRange = _checkIfInRange(
          currentLat: position.latitude,
          currentLong:  position.longitude,
          posLat: data.poLat!,
          posLong: data.poLong!,
        );
        i++;
        print("Value of i is =========> ${i}");
      } while (i < locations.length && !isInRange);

      if (isInRange) {
        // User is in range, proceed with your app
        print("User is within the range. Proceeding with the app.");
        if (onDone != null) onDone();
      } else {
        // User is not in range, show popup
        await _showNotInRangePopup();
      }
    } catch (e) {
      throw e;
    }
  }

  bool _checkIfInRange({
    required double currentLat,
    required double currentLong,
    required double posLat,
    required double posLong,
    double? radius,
  }) {
    double distance =
        _calculateDistance(currentLat, currentLong, posLat, posLong);
    print(("="*50)+ " Distance : ${distance} meter " + ("="*50));
    return distance <= (radius??radiusInMeters);
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

  Future<void> _showNotInRangePopup() async {
    await showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Customize the radius here
        ),
        titlePadding: EdgeInsets.zero,
        contentPadding:
            EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            gap(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Out of Range !',
                    textAlign: TextAlign.center,
                    style: appTextTheme.titleMedium,
                  ),
                ),
              ],
            ),
            gap(space: 15),
            Divider(height: 1, color: Colours.secondary),
          ],
        ),
        content: Text(
          'You are not within the specified location range.',
          textAlign: TextAlign.center,
          style: appTextTheme.labelSmall,
        ),
      ),
    );
  }

  Future<void> _showPermissionPopup(
      String message, Function() onComplete) async {
    permission.showPermissionPopup(message, ()async{
      onComplete();
      await Geolocator.openLocationSettings();
    });
  }
}

var appLocation = _AppLocation();

class LocationModel extends BaseModel {
  @override
  String get endPoint => "/api/location";

  int? id;
  double? poLat;
  double? poLong;
  int? status;
  double? range;

  @override
  DateTime? updatedAt;
  @override
  Duration get expiry => Duration(minutes: 5);

  LocationModel(
      {this.id, this.poLat, this.poLong, this.status, this.updatedAt, this.range});

  factory LocationModel.fromJson(Map<dynamic, dynamic> json) {
    return LocationModel(
      id: ParseData.toInt(json['id']),
      poLat: ParseData.toDouble(json['po_lat']),
      poLong: ParseData.toDouble(json['po_long']),
      status: ParseData.toInt(json['status']),
      range: ParseData.toDouble(json['pos_rang']),
      updatedAt:
          ParseData.toDateTime(json['updated_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'po_lat': poLat,
      'po_long': poLong,
      'status': status,
      'pos_rang': range,
      'updated_at': DateTime.now().toString(),
    };
  }

  /// gets te location where the user can access the app
  static Future<List<LocationModel>> getLocations() async {
    List<LocationModel> locations = [];

    /// cached data
    // var locationMap =
    //     storage.configBox.get(appKeys.locations, defaultValue: []);
    // if ((locationMap as List).length > 0) {
    //   locations = (locationMap as List)
    //       .map((json) => LocationModel.fromJson(json))
    //       .toList();
    //   if (locations.firstOrNull?.updatedAt != null &&
    //       !isExpired(locations.first.updatedAt!,
    //           duration: LocationModel().expiry)) {
    //     return locations;
    //   }
    // }

    // making request
    var resp = await LocationModel().create(data: {});
    locations = (resp.data['data'] as List)
        .map((json) => LocationModel.fromJson(json))
        .toList();
    List<Map> data = locations.map((item) => item.toJson()).toList();
    storage.configBox.put(appKeys.locations, data);
    return locations;
  }
}
