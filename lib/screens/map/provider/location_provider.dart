import 'dart:async';

import 'package:CIVM/screens/map/models/user_location.dart';
import 'package:CIVM/screens/map/services/location_services.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;


enum LocationProviderStatus {
  Initial,
  Loading,
  Success,
  Error,
}

class LocationProvider with ChangeNotifier {
  //  UserLocation? _userLocation;
  UserLocation _userLocation = UserLocation(0.0, 0.0);
  LocationServices _locationServices = LocationServices();

  LocationProviderStatus _status = LocationProviderStatus.Initial;

  UserLocation get userLocation => _userLocation;

  LocationProviderStatus get status => _status;

  Future<void> getLocation() async {
    try {
      _updateStatus(LocationProviderStatus.Loading);

      _userLocation = await _locationServices.getCurrentLocation();
      print(_userLocation);

      _updateStatus(LocationProviderStatus.Success);
    } catch (e) {
      _updateStatus(LocationProviderStatus.Error);
    }
  }

  void _updateStatus(LocationProviderStatus status) {
    if (_status != status) {
      developer
          .log('LocationProvider: Status updated from: $_status to: $status');
      _status = status;
      notifyListeners();
    }
  }
}
