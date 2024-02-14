import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationManager {
  /// private constructor
  LocationManager._();

  static final instance = LocationManager._();

  LatLng? latLng;

  Future<LatLng> getCurrentLocation(BuildContext context) async {
    Position position = await _determinePosition(context);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    latLng = LatLng(position.latitude, position.longitude);
    return latLng!;
  }

  ///Determine Position
  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlertDialog(context);
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlertDialog(context);
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlertDialog(context);
      return Future.error('Location permissions are permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return position;
  }

  showAlertDialog(BuildContext context) => showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Allow access to current location'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Geolocator.openLocationSettings(),
              child: const Text('Settings'),
            ),
          ],
        ),
      );
}
