import 'dart:async';

import 'package:CIVM/piedmont/screens/map/models/user_location.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  late UserLocation userLocation;
  late Position _currentLocation;

  Geolocator geolocator = Geolocator();
  late StreamSubscription<Position> positionStream;

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationController.stream;

  _LocationServices() {
    positionStream = Geolocator.getPositionStream().listen((location) {
      _locationController
          .add(UserLocation(location.latitude, location.longitude));
    });
  }

  void closeLocation() {
    if (positionStream != null) {
      positionStream.cancel();

      _locationController.close();

      positionStream;
    } else {}
  }

  // Future<UserLocation> getCurrentLocation() async {
  //   try {
  //     var isServiceEnabled = await Geolocator.isLocationServiceEnabled();

  //     if (!isServiceEnabled) {
  //       isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  //       if (!isServiceEnabled) {
  //         throw Exception("The Location service is disabled!");
  //       }
  //     }

  //     var isPermission = await Geolocator.checkPermission();
  //     if (isPermission == LocationPermission.denied ||
  //         isPermission == LocationPermission.deniedForever) {
  //       isPermission = await Geolocator.requestPermission();
  //     }
  //     if (isPermission == LocationPermission.denied ||
  //         isPermission == LocationPermission.deniedForever) {
  //       throw Exception("Location Permission requests has been denied!");
  //     }

  //     if (isServiceEnabled &&
  //         (isPermission == LocationPermission.always ||
  //             isPermission == LocationPermission.whileInUse)) {
  //       _currentLocation = await Geolocator.getCurrentPosition().timeout(
  //         Duration(seconds: 10),
  //         onTimeout: () {
  //           throw TimeoutException(
  //               "Location information could not be obtained within the requested time.");
  //         },
  //       );

  //       userLocation =
  //           UserLocation(_currentLocation.latitude, _currentLocation.longitude);
  //       return userLocation;
  //     } else {
  //       throw Exception("Location Service requests has been denied!");
  //     }
  //   } on TimeoutException catch (_) {
  //     print(_);
  //     throw _;
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }


Future<UserLocation> getCurrentLocation() async {
  try {
    // Check if location service is enabled
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      print("Location service is disabled.");
      throw Exception("The Location service is disabled!");
    }

    // Check location permission status
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      print("Requesting location permission...");
      permission = await Geolocator.requestPermission();

      // If permission is still denied or denied forever, throw an error
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        print("Location permission has been denied.");
        throw Exception("Location Permission request has been denied!");
      }
    }

    // Fetch the current position
    _currentLocation = await Geolocator.getCurrentPosition().timeout(
      Duration(seconds: 10),
      onTimeout: () => throw TimeoutException("Location request timed out."),
    );

    // Set user location and return it
    userLocation = UserLocation(_currentLocation.latitude, _currentLocation.longitude);
    return userLocation;
  } on TimeoutException catch (e) {
    print("Location request timed out: $e");
    throw e;
  } catch (e) {
    print("Error fetching location: $e");
    throw e;
  }
}

}
