import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/geojson_parser.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:geojson/geojson.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/resources/app_colors.dart';

class MapScreenLeafLat extends StatefulWidget {
  const MapScreenLeafLat({Key? key}) : super(key: key);

  @override
  _MapScreenLeafLatState createState() => _MapScreenLeafLatState();
}

class _MapScreenLeafLatState extends State<MapScreenLeafLat>
    with TickerProviderStateMixin {
  late final MapController _mapController;
  double _currentZoom = 17.0;
  LatLng? _currentLocation;
  LatLng? newLocation;
  List<Marker> _markers = [];
  List<Marker> _markers1 = [];
  List<Marker> _markerSearch = [];
  double _deviceHeading = 0.0;
  int driveMode = 0;

  // Marker move
  // int numDeltas = 50; //number of delta to devide total distance
  // int delay = 50; //milliseconds of delay to pass each delta
  int numDeltas = 100; //number of delta to devide total distance
  int delay = 10; //milliseconds of delay to pass each delta
  double? _currentSpeed;
  var i = 0;
  double? deltaLat;
  double? deltaLng;
  var position; //position variable while moving marker

  List<String> subNumbers = [];
  // List<GeoJsonFeature> features = [];

  GeoJsonParser myGeoJson = GeoJsonParser();

  GeoJsonParser myGeoJson1fdr1 = GeoJsonParser();
  GeoJsonParser myGeoJson1fdr2 = GeoJsonParser();
  GeoJsonParser myGeoJson1fdr3 = GeoJsonParser();
  GeoJsonParser myGeoJson1fdr4 = GeoJsonParser();
  GeoJsonParser myGeoJson1fdr5 = GeoJsonParser();
  GeoJsonParser myGeoJson1fdr6 = GeoJsonParser();

  GeoJsonParser myGeoJson2 = GeoJsonParser();

  GeoJsonParser myGeoJson3Fdr1 = GeoJsonParser();
  GeoJsonParser myGeoJson3Fdr2 = GeoJsonParser();
  GeoJsonParser myGeoJson3Fdr3 = GeoJsonParser();
  GeoJsonParser myGeoJson3Fdr4 = GeoJsonParser();
  GeoJsonParser myGeoJson3Fdr5 = GeoJsonParser();
  GeoJsonParser myGeoJson3Fdr6 = GeoJsonParser();

  late StreamSubscription<Position> _positionStreamSubscription;

  // ignore: prefer_typing_uninitialized_variables
  var subNumberLocalVariable;

  String? lastSubNumber;
  final TextEditingController _searchController = TextEditingController();
  bool _showedLocationpin = false;

  Map<String, dynamic>? consumerData;

  Future<void>? _launched;

  List<Polyline> myPolylines = [];
  List<Marker> myMarkers = [];
  bool _isVisibleSpeed = false;
  StreamSubscription<CompassEvent>? _compassSubscription;
  List<dynamic> _geoJsonFeatures = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initializeMap();
    _addLabelMarker();
    _startListeningToCompass();
    // fetchDataByLatLong(-92.4764153135444, 48.341346233286);
    WakelockPlus.enable();
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    _listenToLocationUpdates();
    _loadGeoJSONBoundary();
  }

  void _startListeningToCompass() {
    _compassSubscription = FlutterCompass.events?.listen((CompassEvent event) {
      if (!mounted) return; // prevents calling setState on disposed widget
      setState(() {
        _deviceHeading = event.heading ?? 0.0;
        if (driveMode == 1) {
          _mapController.rotate(-_deviceHeading);
        }
      });
    });
  }

  Future<void> _loadGeoJSONBoundary() async {
    final String geoJSONStringBoundary = await rootBundle.loadString(
      'assets/pemc/Substation_boundary_pemc.geojson',
    );
    setState(() {
      myGeoJson.parseGeoJsonAsString(geoJSONStringBoundary);
    });
  }

  // Future<void> _loadGeoJSON() async {
  //   // print("_loadGeoJSON called");
  //   try {
  //     final String geoJSONString = await rootBundle
  //         .loadString('assets/pemc/Substation_boundary_pemc.geojson');
  //     final geoJson = GeoJson();
  //     await geoJson.parse(geoJSONString); // Parse GeoJSON

  //     if (geoJson.features.isNotEmpty) {
  //       LatLng currentLocationPEMC1 =
  //           LatLng(36.021752, -79.218636); // Buckhorn pemc
  //       LatLng currentLocationPEMC2 = LatLng(36.096828, -78.976936); // Bivins
  //       LatLng currentLocationPEMC3 = LatLng(36.297418, -79.226532); // Baynes
  //       LatLng currentLocationPEMC4 = LatLng(35.885573, -79.085083); // Carrboro
  //       LatLng currentLocationPEMC5 =
  //           LatLng(36.317338, -79.429779); // Cherry Grove
  //       LatLng currentLocationPEMC6 =
  //           LatLng(36.494182, -78.84407); // Dixon's Store
  //       LatLng currentLocationPEMC7 =
  //           LatLng(36.124842, -78.849564); // E. Willardsville
  //       LatLng currentLocationPEMC8 = LatLng(35.999257, -79.038219); // Eubanks
  //       LatLng currentLocationPEMC9 = LatLng(36.490317, -79.08989); // Hyco
  //       LatLng currentLocationPEMC10 =
  //           LatLng(36.508532, -78.625031); // Jonathans Cross
  //       LatLng currentLocationPEMC11 =
  //           LatLng(36.229874, -79.013672); // Little River
  //       LatLng currentLocationPEMC12 =
  //           LatLng(36.049654, -79.261036); // Mebane Oaks
  //       LatLng currentLocationPEMC13 =
  //           LatLng(36.335594, -78.85437); // MT. Tirzah
  //       LatLng currentLocationPEMC14 =
  //           LatLng(36.453875, -78.95874); // N. Roxboro
  //       LatLng currentLocationPEMC15 =
  //           LatLng(36.010228, -79.089203); // New Hope
  //       LatLng currentLocationPEMC16 =
  //           LatLng(36.135102, -79.028091); // New Sharon
  //       LatLng currentLocationPEMC17 =
  //           LatLng(36.261162, -78.870506); // Red Mountain
  //       LatLng currentLocationPEMC18 =
  //           LatLng(36.106815, -79.148941); // W. Hillsborough
  //       LatLng currentLocationPEMC19 =
  //           LatLng(35.914913, -79.119759); // Westbrook
  //       LatLng currentLocationPEMC20 =
  //           LatLng(36.153123, -78.920631); // Willardsville
  //       // _parseSubNumbers(geoJson.features, currentLocationPEMC2);
  //       _parseSubNumbers(geoJson.features, _currentLocation!);
  //     } else {
  //       print("Failed to parse GeoJSON: No features found.");
  //     }
  //   } catch (e) {
  //     print("Error loading GeoJSON: $e");
  //   }
  // }
  Future<void> _loadGeoJSON() async {
  try {
    final String geoJSONString = await rootBundle
        .loadString('assets/pemc/Substation_boundary_pemc.geojson');

    // ✅ ADD HERE
    final data = jsonDecode(geoJSONString);
    _geoJsonFeatures = data['features'];

    if (_geoJsonFeatures.isNotEmpty) {
      _parseSubNumbers(_geoJsonFeatures, _currentLocation!);
    } else {
      print("No features found.");
    }
  } catch (e) {
    print("Error loading GeoJSON: $e");
  }
}// void _parseSubNumbers(
  //     List<GeoJsonFeature> geoJsonFeatures, LatLng currentLocation) {
  //   // print('location update called...........');
  //   // print('_currentLocation $currentLocation');
  //   if (geoJsonFeatures.isEmpty) {
  //     print("No features to parse.");
  //     return;
  //   }

  //   for (var feature in geoJsonFeatures) {
  //     if (feature.geometry != null) {
  //       List<List<LatLng>> polygons = [];

  //       if (feature.geometry is GeoJsonMultiPolygon) {
  //         var multiPolygon = feature.geometry as GeoJsonMultiPolygon;

  //         for (var polygon in multiPolygon.polygons) {
  //           if (polygon.geoSeries != null && polygon.geoSeries.isNotEmpty) {
  //             final coords = polygon.geoSeries[0].geoPoints;

  //             polygons.add(coords.map<LatLng>((point) {
  //               return LatLng(point.latitude, point.longitude);
  //             }).toList());
  //           }
  //         }
  //       } else if (feature.geometry is GeoJsonPolygon) {
  //         var polygon = feature.geometry as GeoJsonPolygon;

  //         if (polygon.geoSeries != null && polygon.geoSeries.isNotEmpty) {
  //           final coords = polygon.geoSeries[0].geoPoints;

  //           polygons.add(coords.map<LatLng>((point) {
  //             return LatLng(point.latitude, point.longitude);
  //           }).toList());
  //         }
  //       } else {
  //         print("Unsupported geometry type: ${feature.geometry.runtimeType}");
  //         continue;
  //       }

  //       // 🔁 Now check all polygons
  //       for (var polygonLatLng in polygons) {
  //         if (_isPointInPolygon(currentLocation, polygonLatLng)) {
  //           var currentSubNumber = feature.properties!['UplineSour'];

  //           if (currentSubNumber != lastSubNumber) {
  //             subNumberLocalVariable = currentSubNumber;

  //             _addPolygonToMap(polygonLatLng);
  //             lastSubNumber = currentSubNumber;

  //             String extractedName =
  //                 currentSubNumber.replaceAll(RegExp(r'^\d+-\s*'), '');

  //             print("Substation NameOnlyName: $extractedName");
  //             getMapLinesBySubstation(context, extractedName);
  //           }
  //         }
  //       }
  //     } else {
  //       print("Unsupported geometry type: ${feature.geometry.runtimeType}");
  //     }
  //   }
  // }
  void _parseSubNumbers(List features, LatLng currentLocation) {
    if (features.isEmpty) return;

    for (var feature in features) {
      final geometry = feature['geometry'];
      final properties = feature['properties'];

      if (geometry == null) continue;

      List<List<LatLng>> polygons = [];

      if (geometry['type'] == 'MultiPolygon') {
        for (var polygon in geometry['coordinates']) {
          for (var ring in polygon) {
            polygons.add(
              ring.map<LatLng>((coord) {
                return LatLng(coord[1], coord[0]); // lat, lng
              }).toList(),
            );
          }
        }
      } else if (geometry['type'] == 'Polygon') {
        for (var ring in geometry['coordinates']) {
          polygons.add(
            ring.map<LatLng>((coord) {
              return LatLng(coord[1], coord[0]);
            }).toList(),
          );
        }
      } else {
        continue;
      }

      // 🔁 Check all polygons
      for (var polygonLatLng in polygons) {
        if (_isPointInPolygon(currentLocation, polygonLatLng)) {
          var currentSubNumber = properties['UplineSour'];

          if (currentSubNumber != lastSubNumber) {
            subNumberLocalVariable = currentSubNumber;

            _addPolygonToMap(polygonLatLng);
            lastSubNumber = currentSubNumber;

            String extractedName = currentSubNumber.replaceAll(
              RegExp(r'^\d+-\s*'),
              '',
            );

            print("Substation NameOnlyName: $extractedName");
            getMapLinesBySubstation(context, extractedName);
          }
        }
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar("Location services are disabled.");
      // return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar("Location permissions are permanently denied.");
      return;
    }

    Position position1 = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      position = [position1.latitude, position1.longitude];
      _currentLocation = LatLng(position1.latitude, position1.longitude);
      _updateMarker();
      _checkIfLocationInsidePolygon();
    });
  }

  void _addLabelMarker() {
    _markers1 = [
      //////////////pemc/////////////////
      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.297418, -79.226532), // Baynes
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Baynes.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.096828, -78.976936), // Bivins
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Bivins.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.021752, -79.218636), // Buckhorn
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Buckhorn.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(35.885573, -79.085083), // Carrboro
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Carrboro.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.317338, -79.429779), // Cherry Grove
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Cherry_Grove.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.494182, -78.84407), // Dixon's Store
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Dixons_Store.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.124842, -78.849564), // E. Willardsville
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/E_Willardsville.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(35.999257, -79.038219), // Eubanks
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Eubanks.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.490317, -79.08989), // Hyco
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Hyco.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.508532, -78.625031), // Jonathans Cross
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Jonathans_Cross.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.229874, -79.013672), // Little River
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Little_River.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.049654, -79.261036), // Mebane Oaks
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Mebane_Oaks.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.335594, -78.85437), // MT. Tirzah
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/MT_Tirzah.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.453875, -78.95874), // N. Roxboro
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/N_Roxboro.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.010228, -79.089203), // New Hope
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/New_Hope.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.135102, -79.028091), // New Sharon
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/New_Sharon.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.261162, -78.870506), // Red Mountain
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Red_Mountain.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.106815, -79.148941), // W. Hillsborough
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/W_Hillsborough.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(35.914913, -79.119759), // Westbrook
        rotate: true,
        alignment: Alignment.center,
        child:  Image.asset('assets/pemc/sub_names_pemc/Westbrook.png'),
      ),

      Marker(
        // rotateOrigin: const Offset(0.5, 0.5),
        width: 120,
        height: 40,
        point: LatLng(36.153123, -78.920631), // Willardsville
        rotate: true,
        alignment: Alignment.center,
        child: Image.asset('assets/pemc/sub_names_pemc/Willardsville.png'),
      ),
    ];
  }

  void _updateMarker() {
    // print("_updateMarker called");
    if (_currentLocation != null) {
      _markers = [
        Marker(
          // rotateOrigin: const Offset(0.5, 0.5),
          point: _currentLocation!,
          child: Transform.rotate(
            angle: _deviceHeading * (pi / 180),
            alignment: Alignment.center,
            child: const Icon(Icons.navigation, color: Colors.blue, size: 40),
          ),
        ),
      ];
      setState(() {
        //UI Refresh
      });
    }
  }

  void _listenToLocationUpdates() {
    // print("_listenToLocationUpdates called");
    _positionStreamSubscription = Geolocator.getPositionStream().listen((
      Position position,
    ) {
      // print("Location updated: $newLocation");
      setState(() {
        newLocation = LatLng(position.latitude, position.longitude);
        var result = [
          position.latitude,
          position.longitude,
        ]; //latitude and longitude of new position
        transition(result); //start moving marker
        _currentLocation = newLocation;
        _currentSpeed = (position.speed * 2.23694);
        _updateMarker();
        _loadGeoJSON();
        if (driveMode == 1) {
          _mapController.move(_currentLocation!, _currentZoom);
        }
      });
    });
  }

  transition(result) {
    i = 0;
    deltaLat = (result[0] - position[0]) / numDeltas;
    deltaLng = (result[1] - position[1]) / numDeltas;
    moveMarker();
  }

  moveMarker() {
    position[0] += deltaLat;
    position[1] += deltaLng;
    var latlng = LatLng(position[0], position[1]);

    if (_currentLocation != null) {
      _markers = [
        Marker(
          // rotateOrigin: const Offset(0.5, 0.5),
          point: latlng,
          child: Transform.rotate(
            angle: _deviceHeading * (pi / 180),
            child: const Icon(Icons.navigation, color: Colors.blue, size: 40),
          ),
        ),
      ];
    }

    setState(() {
      //refresh UI
    });

    if (i != numDeltas) {
      i++;
      Future.delayed(Duration(milliseconds: delay), () {
        moveMarker();
      });
    }
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(1.0, 17.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomOut() {
    // print('zoomOut pressed');
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(1.0, 17.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _resetRotation() {
    setState(() {
      _deviceHeading = 0.0;
    });
    _mapController.rotate(0.0);
  }

  // void _checkIfLocationInsidePolygon() {
  //   if (_currentLocation != null && myGeoJson.features.isNotEmpty) {
  //     for (var feature in myGeoJson.features) {
  //       final geometry = feature.geometry;
  //       if (geometry?.type == "MultiPolygon") {
  //         // print("MultiPolygon::");
  //         List<dynamic> coordinates = geometry!.coordinates;

  //         // Iterate over the MultiPolygon coordinates
  //         for (var polygon in coordinates) {
  //           if (polygon is List) {
  //             // Convert polygon to List<LatLng>
  //             List<LatLng> latLngList = polygon
  //                 .map<LatLng>(
  //                   (point) => LatLng(point[1], point[0]),
  //                 ) // Assuming [lat, lng]
  //                 .toList();

  //             // Now, you can use latLngList which is of type List<LatLng>
  //             if (latLngList.isNotEmpty) {
  //               for (int i = 0; i < latLngList.length; i++) {
  //                 var p1 = latLngList[i];
  //                 var p2 = latLngList[(i + 1) % latLngList.length];
  //                 // print("p1: $p1, p2: $p2");

  //                 // Check if the current location is inside the polygon
  //                 if (_isPointInPolygon(_currentLocation!, latLngList)) {
  //                   final subNumber =
  //                       feature.properties!['UplineSour'] ?? 'Unknown';
  //                   // print('subNumber33333333333 $subNumber');
  //                   _showSnackBar(
  //                     "Current location is in SubNumber: $subNumber",
  //                   );
  //                   return;
  //                 }
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //     _showSnackBar("Current location is not in any SubNumber.");
  //     CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
  //       "Current location is not in any SubNumber.",
  //       context,
  //     );
  //   }
  // }
  void _checkIfLocationInsidePolygon() {
  if (_currentLocation == null || _geoJsonFeatures.isEmpty) return;

  for (var feature in _geoJsonFeatures) {
    final geometry = feature['geometry'];
    final properties = feature['properties'];

    if (geometry == null) continue;

    if (geometry['type'] == 'MultiPolygon') {
      for (var polygon in geometry['coordinates']) {
        for (var ring in polygon) {
          List<LatLng> latLngList = ring.map<LatLng>((coord) {
            return LatLng(coord[1], coord[0]); // lat, lng
          }).toList();

          if (_isPointInPolygon(_currentLocation!, latLngList)) {
            final subNumber = properties['UplineSour'] ?? 'Unknown';

            _showSnackBar(
              "Current location is in SubNumber: $subNumber",
            );
            return;
          }
        }
      }
    }

    else if (geometry['type'] == 'Polygon') {
      for (var ring in geometry['coordinates']) {
        List<LatLng> latLngList = ring.map<LatLng>((coord) {
          return LatLng(coord[1], coord[0]);
        }).toList();

        if (_isPointInPolygon(_currentLocation!, latLngList)) {
          final subNumber = properties['UplineSour'] ?? 'Unknown';

          _showSnackBar(
            "Current location is in SubNumber: $subNumber",
          );
          return;
        }
      }
    }
  }
  _showSnackBar("Current location is not in any SubNumber.");
}
  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int crossings = 0;
    int n = polygon.length;

    for (int i = 0; i < n; i++) {
      LatLng p1 = polygon[i];
      LatLng p2 = polygon[(i + 1) % n];

      if (point.latitude > p1.latitude && point.latitude <= p2.latitude ||
          point.latitude > p2.latitude && point.latitude <= p1.latitude) {
        if (point.longitude <=
            (p2.longitude - p1.longitude) *
                    (point.latitude - p1.latitude) /
                    (p2.latitude - p1.latitude) +
                p1.longitude) {
          crossings++;
        }
      }
    }

    return crossings % 2 != 0; // Odd number of crossings means inside
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));

    // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(message, context);
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    WakelockPlus.disable();
    _mapController.dispose();
    _compassSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Live IVM System Map")),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Live IVM System Map",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    // center: _currentLocation ?? LatLng(0.0, 0.0),
                    // zoom: _currentZoom,
                    // rotation: _deviceHeading * pi / 180,
                    initialCenter: _currentLocation ?? LatLng(0.0, 0.0),
                    initialZoom: _currentZoom,
                    initialRotation: _deviceHeading * pi / 180,
                    maxZoom: 18,
                    minZoom: 0.0,
                    // interactiveFlags: InteractiveFlag.all,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all,
                    ),
                  ),
                  children: [
                    TileLayer(
                      // urlTemplate:
                      //     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      // subdomains: ['a', 'b', 'c'],
                      userAgentPackageName:
                          'com.ariespro.civm', // Replace with your actual app package name
                    ),
                    PolygonLayer(polygons: myGeoJson.polygons),
                    // PolylineLayer(polylines: myGeoJson1fdr1.polylines),
                    // PolylineLayer(polylines: myGeoJson3Fdr1.polylines),
                    PolylineLayer(
                      polylines: myGeoJson1fdr1.polylines.map((polyline) {
                        return Polyline(
                          points: polyline.points,
                          color: Colors.green,
                          strokeWidth: 4.0,
                        );
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: myGeoJson1fdr2.polylines.map((polyline) {
                        return Polyline(
                          points: polyline.points,
                          color: Colors.purple,
                          strokeWidth: 4.0,
                        );
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: myGeoJson1fdr3.polylines.map((polyline) {
                        return Polyline(
                          points: polyline.points,
                          color: Colors.red,
                          strokeWidth: 4.0,
                        );
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: myGeoJson1fdr4.polylines.map((polyline) {
                        return Polyline(
                          points: polyline.points,
                          color: const Color.fromARGB(255, 61, 2, 255),
                          strokeWidth: 4.0,
                        );
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: myGeoJson1fdr5.polylines.map((polyline) {
                        return Polyline(
                          points: polyline.points,
                          color: Colors.yellow,
                          strokeWidth: 4.0,
                        );
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: myGeoJson1fdr6.polylines.map((polyline) {
                        return Polyline(
                          points: polyline.points,
                          color: Colors.brown,
                          strokeWidth: 4.0,
                        );
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: (myGeoJson3Fdr1.polylines).expand((polyline) {
                        return createDashedLine(
                          polyline.points.first,
                          polyline.points.last,
                          10.0,
                          Colors.green,
                        ); // Adjust as necessary
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: (myGeoJson3Fdr2.polylines).expand((polyline) {
                        return createDashedLine(
                          polyline.points.first,
                          polyline.points.last,
                          10.0,
                          Colors.purple,
                        ); // Adjust as necessary
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: (myGeoJson3Fdr3.polylines).expand((polyline) {
                        return createDashedLine(
                          polyline.points.first,
                          polyline.points.last,
                          10.0,
                          Colors.red,
                        ); // Adjust as necessary
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: (myGeoJson3Fdr4.polylines).expand((polyline) {
                        return createDashedLine(
                          polyline.points.first,
                          polyline.points.last,
                          10.0,
                          const Color.fromARGB(255, 61, 2, 255),
                        ); // Adjust as necessary
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: (myGeoJson3Fdr5.polylines).expand((polyline) {
                        return createDashedLine(
                          polyline.points.first,
                          polyline.points.last,
                          10.0,
                          Colors.yellow,
                        ); // Adjust as necessary
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylines: (myGeoJson3Fdr6.polylines).expand((polyline) {
                        return createDashedLine(
                          polyline.points.first,
                          polyline.points.last,
                          10.0,
                          Colors.brown,
                        ); // Adjust as necessary
                      }).toList(),
                    ),

                    ///////////layer data/////////////////////////
                    PolylineLayer(polylines: myPolylines),

                    //////////////////////////////////////////////////////
                    MarkerLayer(markers: _markers), //current position marker
                    MarkerLayer(markers: _markers1),
                    MarkerLayer(markers: _markerSearch),
                    MarkerLayer(
                      markers: myGeoJson2.markers.map((marker) {
                        return Marker(
                          point: marker.point,
                          child: GestureDetector(
                            onTap: () {
                              fetchDataAndShowDialog(
                                context,
                                marker.point.longitude,
                                marker.point.latitude,
                              );
                            },
                            child: Image.asset(
                              'assets/period1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    (MarkerLayer(markers: myMarkers)),
                  ],
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  right: 15,
                  height: 45,
                  child: TypeAheadField<Map<String, dynamic>>(
                    controller: _searchController,

                    builder: (context, controller, focusNode) {
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: 'Search locations...',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: controller.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    controller.clear();
                                    setState(() {
                                      _showedLocationpin = false;
                                    });
                                  },
                                )
                              : null,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 12.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    },

                    suggestionsCallback: _getLocationSuggestions,

                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        leading: const Icon(Icons.location_city),
                        title: Text(
                          suggestion['wmBF_Name'] ??
                              suggestion['name'] ??
                              'Unknown',
                        ),
                        subtitle: Text(
                          "Service: ${suggestion['wmBF_Servi'] ?? ''}\n"
                          "Parcel: ${suggestion['parcelNumber'] ?? ''}",
                        ),
                      );
                    },

                    /// ✅ REQUIRED in v5
                    onSelected: (suggestion) {
                      _currentZoom = 15.0;

                      _searchController.text =
                          suggestion['wmBF_Name'] ??
                          suggestion['name'] ??
                          'Unknown';

                      _updateMapLocation(
                        suggestion['name'] ?? suggestion['wmBF_Servi'] ?? '',
                        suggestion['geometry'],
                      );

                      setState(() {
                        _showedLocationpin = true;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _isVisibleSpeed,
                  child: Positioned(
                    bottom: 15,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _currentSpeed != null
                                ? _currentSpeed!.toStringAsFixed(1)
                                : "0.0",
                            style: const TextStyle(
                              color: AppColors.baseColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "mph",
                            style: TextStyle(
                              color: AppColors.baseColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 5,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _resetRotation,
                        child: Transform.rotate(
                          angle: -_deviceHeading * pi / 180,
                          child: Image.asset(
                            'assets/compass.png',
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),

                      // const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _recenterMap,
                        // mini: true,
                        // child: Icon(Icons.my_location,
                        //     color: (driveMode == 0)
                        //         ? const Color.fromARGB(233, 54, 54, 54)
                        //         : const Color.fromARGB(233, 46, 99, 168)),
                        child: (driveMode == 0)
                            ? Image.asset(
                                'assets/location black.png',
                                width: 50,
                                height: 60,
                              )
                            : Image.asset(
                                'assets/location_blue.png',
                                width: 50,
                                height: 60,
                              ),
                      ),
                      // const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _zoomIn,
                        // mini: true,
                        child:
                            // const Icon(Icons.zoom_in),
                            Image.asset(
                              'assets/zoom in v2.png',
                              width: 50,
                              height: 50,
                            ),
                      ),
                      // const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _zoomOut,
                        // mini: true,
                        child:
                            // const Icon(Icons.zoom_out),
                            Image.asset(
                              'assets/zoom out v2.png',
                              width: 50,
                              height: 50,
                            ),
                      ),
                      GestureDetector(
                        onTap: () => _handleFeederTap(context),
                        // mini: true,
                        child:
                            // const Icon(Icons.zoom_out),
                            Image.asset('assets/F.png', width: 50, height: 50),
                      ),
                      GestureDetector(
                        onTap: () => _handleWorkTap(context),
                        // mini: true,
                        child:
                            // const Icon(Icons.zoom_out),
                            Image.asset('assets/W.png', width: 50, height: 50),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 20,
                //   left: 20,
                //   child: FloatingActionButton(
                //     onPressed: _recenterMap,
                //     mini: true,
                //     child: Icon(Icons.my_location,
                //         color: (driveMode == 0)
                //             ? Color.fromARGB(233, 54, 54, 54)
                //             : Color.fromARGB(233, 46, 99, 168)),
                //   ),
                // ),
              ],
            ),
    );
  }

  Future<void> _recenterMap() async {
    if (_currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current location not available.")),
      );
      return;
    }
    setState(() {
      if (driveMode == 0) {
        driveMode = 1;
        _mapController.move(_currentLocation!, _currentZoom);
        _isVisibleSpeed = true;
      } else {
        driveMode = 0;
        _isVisibleSpeed = false;
      }
    });
  }

  Future<void> _addPolygonToMap(List<LatLng> polygonLatLng) async {
    // print("Adding polygon to map with coordinates: $polygonLatLng");
    List<List<double>> coordinates = polygonLatLng.map((latLng) {
      return [
        latLng.longitude,
        latLng.latitude,
      ]; // Correct order: [longitude, latitude]
    }).toList();
    String geoJsonString = jsonEncode({
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [coordinates], // Wrap in another list for GeoJSON
          },
          'properties': {},
        },
      ],
    });
    ///////////////////pecm data//////////////////
    // myGeoJson.parseGeoJsonAsString(geoJsonString);
    if (subNumberLocalVariable == 'Buckhorn') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });
      print('subNumberLocalVariable:: $subNumberLocalVariable');
      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Buckhorn_Buckhorn_Rd__South_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Buckhorn_I-85_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Buckhorn_Left_DC_Buckhorn_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Buckhorn_Right_DC_Buckhorn_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Buckhorn_Buckhorn_Rd__South_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Buckhorn_I-85_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Buckhorn_Left_DC_Buckhorn_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Buckhorn_Right_DC_Buckhorn_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Buckhorn.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////////////////frazerBay//////////////////////////////////////////
    else if (subNumberLocalVariable == 'Baynes') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Baynes_119_North_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Baynes_Baynes_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Baynes_Byrd_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Baynes_Corbett_s_Store_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/Baynes_Rascoe_Dameron_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Baynes_119_North_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Baynes_Byrd_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Baynes_Corbett_s_Store_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Baynes_FROGSBORO_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr5 = await rootBundle.loadString(
        'assets/pemc/underground/Baynes_Rascoe_Dameron_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
        myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Baynes.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Bivins/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Bivins') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Bivins_Bivins_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Bivins_Maple_Ridge_S_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Bivins_Russell_Rd__North_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Bivins_WILLOWHAVEN_SOUTH_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Bivins_Bivins_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Bivins_Maple_Ridge_S_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Bivins_Russell_Rd__North_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Bivins_Willowhaven_South_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Bivins.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Carrboro/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Carrboro') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Carrboro_Carrboro_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Carrboro_Heritage_Hills_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Carrboro_Left_DC_Plantation_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Carrboro_Right_DC_Carrboro_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/CARRBORO_RSDC_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Carrboro_HERITAGE_HILLS_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Carrboro_Left_DC_Plantation_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Carrboro_Right_DC_Carrboro_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/CARRBORO_RSDC_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Carrboro.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Cherry Grove/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Cherry Grove') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Cherry_Grove_Camp_Springs_W_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Cherry_Grove_Cherry_Grove_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Cherry_Grove_Nathan_Simpson_S_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Cherry_Grove_Oakview_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Cherry_Grove_Camp_Springs_W_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Cherry_Grove_Cherry_Grove_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Cherry_Grove_Nathan_Simpson_S_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Cherry_Grove_OAKVIEW_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Cherry_Grove.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Dixon Store/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Dixon Store') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Dixon_s_stole_BOWMANTWN_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Dixon_s_Store_Bowmantown-Olive_Branch_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Dixon_s_Store_HWY_49_NORTH_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Dixon_s_Store_MILLCREEK_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/Dixon_Store_Dixon_Store_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Dixon_s_stole_BOWMANTWN_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Dixon_s_Store_Bowmantown-Olive_Branch_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Dixon_s_Store_HWY_49_NORTH_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Dixon_s_Store_MILLCREEK_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Dixons_Store.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////E. Willardsville/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'E. Willardsville') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/E__Willardsville_E__Willardsville_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/E__Willardsville_FAIRINTOSH_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/E__Willardsville_Orange_Factory_Rd_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/E__Willardsville_FAIRINTOSH_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/E__Willardsville_Orange_Factory_Rd_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/E._Willardsville.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Eubanks/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Eubanks') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Eubanks_Eubanks_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Eubanks_Hwy_86_S_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Eubanks_Mt__Sinai_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Eubanks_HWY_86_S_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Eubanks_Mt__Sinai_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Eubanks.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Hyco/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Hyco') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Hyco_City_Lake_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Hyco_Hyco_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Hyco_Semora_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Hyco_CITY_LAKE_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Hyco_Hyco_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Hyco_SEMORA_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Hyco.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Jonathans Cross/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Jonathans Cross') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Jonathan_s_X_Rd_CORNWALL_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Jonathan_s_X_Rd_GRASSY_CREEK_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Jonathan_s_X_Rd_Jonathans_Cross_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Jonathan_s_X_Rd_TRIPLE_SPRINGS_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Jonathan_s_X_Rd_Cornwall_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Jonathan_s_X_Rd_Grassy_Creek_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Jonathan_s_X_Rd_Triple_Springs_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Jonathans_X_Rd.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Little River/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Little River') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Little_River_Hall_Dairy_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Little_River_Hwy_157_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Little_River_Little_River_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Little_River_McKee_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/Little_River_New_Sharon_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr6 = await rootBundle.loadString(
        'assets/pemc/overhead/Little_River_Wagner_Dairy_Rd_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
        myGeoJson1fdr6.parseGeoJsonAsString(geoJSONStringOverheadFdr6);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Little_River_Hall_Dairy_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Little_River_HWY_157_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Little_River_Little_River_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Little_River_McKee_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr5 = await rootBundle.loadString(
        'assets/pemc/underground/Little_River_New_Sharon_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr6 = await rootBundle.loadString(
        'assets/pemc/underground/Little_River_Wagner_Dairy_Rd_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
        myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
        myGeoJson3Fdr6.parseGeoJsonAsString(geoJSONStringUndergroundFdr6);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Little_River.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Mebane Oaks/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Mebane Oaks') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Mebane_Oaks_BEN_WILSON_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Mebane_Oaks_MEBANE_OAKS_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Mebane_Oaks_OLD_HILLSBOROUGH_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Mebane_Oaks_BEN_WILSON_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Mebane_Oaks_MEBANE_OAKS_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Mebane_Oaks_OLD_HILLSBOROUGH_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Mebane_Oaks.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////MT. Tirzah/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'MT. Tirzah') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Mt__Tirzah_CLAYTON_STORE_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Mt__Tirzah_MORIAH_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/MT__Tirzah_MT__Tirzah_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Mt__Tirzah_Surl_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/Mt__Tirzah_Thomas_Store_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Mt__Tirzah_CLAYTON_STORE_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Mt__Tirzah_MORIAH_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/MT__Tirzah_MT__Tirzah_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Mt__Tirzah_SURL_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr5 = await rootBundle.loadString(
        'assets/pemc/underground/Mt__Tirzah_THOMAS_STORE_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
        myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Mt._Tirzah.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////N.Roxboro/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'N.Roxboro') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/N__Roxboro_N__Roxboro_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/N_Roxboro_Allensville_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/N_Roxboro_Chub_Lake_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/N_Roxboro_Woodsdale_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/N_Roxboro_Allensville_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/N_Roxboro_Chub_Lake_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/N_Roxboro_Woodsdale_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/N.Roxboro.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////New Hope/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'New Hope') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/New_Hope_BLACKWOOD_STATION_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/New_Hope_JOPPA_OAKS_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/New_Hope_New_Hope_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/New_Hope_POWDER_MILL_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/New_Hope_UNION_GROVE_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/New_Hope_BLACKWOOD_STATION_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/New_Hope_JOPPA_OAKS_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/New_Hope_POWDER_MILL_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/New_Hope_UNION_GROVE_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/New_Hope.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////New Sharon/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'New Sharon') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/New_Sharon_Guess_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/New_Sharon_Palmer_s_Grove_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/New_Sharon_Schley_Rd__West_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/New_Sharon_Guess_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/New_Sharon_Palmer_s_Grove_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/New_Sharon_Schley_Rd__West_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/New_Sharon.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    //////////////////////////////////Red Mountain/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Red Mountain') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Red_Mountain_BEREA_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Red_Mountain_Red_Mountain_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Red_Mountain_ROUGEMONT_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Red_Mountain_TIMBERLAKE_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Red_Mountain_BEREA_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Red_Mountain_ROUGEMONT_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Red_Mountain_TIMBERLAKE_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Red_Mountain.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    /////////////////////////////////W. Hillsborough/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'W. Hillsborough') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/W__Hillsborough_Ben_Johnson_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/W__Hillsborough_Borland_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/W__Hillsborough_Fox_Hill_Farm_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/W__Hillsborough_Highland_Farm_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/W__Hillsborough_Oakdale_Dr_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr6 = await rootBundle.loadString(
        'assets/pemc/overhead/W__Hillsborough_W__Hillsborough_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
        myGeoJson1fdr6.parseGeoJsonAsString(geoJSONStringOverheadFdr6);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/W__Hillsborough_Ben_Johnson_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/W__Hillsborough_Borland_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/W__Hillsborough_FOX_HILL_FARM_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/W__Hillsborough_Highland_Farm_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr5 = await rootBundle.loadString(
        'assets/pemc/underground/W__Hillsborough_Oakdale_Dr_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
        myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/W._Hillsborough.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    /////////////////////////////////Westbrook/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Westbrook') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Westbrook_Damascus_Church_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Westbrook_HWY_54_WEST_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Westbrook_Jones_Ferry_Rd__N_E_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Westbrook_Jones_Ferry_Rd__S_W_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/Westbrook_Westbrook_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Westbrook_Damascus_Church_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Westbrook_HWY_54_WEST_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Westbrook_Jones_Ferry_Rd__N_E_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Westbrook_Jones_Ferry_Rd__S_W_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Westbrook.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }
    /////////////////////////////////Willardsville/////////////////////////////////////////////////////////////////
    else if (subNumberLocalVariable == 'Willardsville') {
      setState(() {
        myGeoJson1fdr1 = GeoJsonParser();
        myGeoJson1fdr2 = GeoJsonParser();
        myGeoJson1fdr3 = GeoJsonParser();
        myGeoJson1fdr4 = GeoJsonParser();
        myGeoJson1fdr5 = GeoJsonParser();
        myGeoJson1fdr6 = GeoJsonParser();
        myGeoJson2 = GeoJsonParser();
        myGeoJson3Fdr1 = GeoJsonParser();
        myGeoJson3Fdr2 = GeoJsonParser();
        myGeoJson3Fdr3 = GeoJsonParser();
        myGeoJson3Fdr4 = GeoJsonParser();
        myGeoJson3Fdr5 = GeoJsonParser();
        myGeoJson3Fdr6 = GeoJsonParser();
      });

      final String geoJSONStringOverheadFdr1 = await rootBundle.loadString(
        'assets/pemc/overhead/Willardsville_Fox_Run_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr2 = await rootBundle.loadString(
        'assets/pemc/overhead/Willardsville_Mason_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr3 = await rootBundle.loadString(
        'assets/pemc/overhead/Willardsville_S_Lowell_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr4 = await rootBundle.loadString(
        'assets/pemc/overhead/Willardsville_St_Mary_s_Rd_overhead.geojson',
      );
      final String geoJSONStringOverheadFdr5 = await rootBundle.loadString(
        'assets/pemc/overhead/Willardsville_Willardsville_overhead.geojson',
      );
      setState(() {
        myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
        myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
        myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
        myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
        myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
      });
      final String geoJSONStringUndergroundFdr1 = await rootBundle.loadString(
        'assets/pemc/underground/Willardsville_FOX_RUN_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr2 = await rootBundle.loadString(
        'assets/pemc/underground/Willardsville_Mason_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr3 = await rootBundle.loadString(
        'assets/pemc/underground/Willardsville_S_Lowell_Rd_underground.geojson',
      );
      final String geoJSONStringUndergroundFdr4 = await rootBundle.loadString(
        'assets/pemc/underground/Willardsville_St_Mary_s_Rd_underground.geojson',
      );

      setState(() {
        myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
        myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
        myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
        myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
      });

      final String geoJSONStringConsumer = await rootBundle.loadString(
        'assets/pemc/consumers/Willardsville.geojson',
      );

      setState(() {
        myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
      });
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
  }

  Future<List<Map<String, dynamic>>> _getLocationSuggestions(
    String query,
  ) async {
    try {
      final url =
          'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5';
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'flutter_map_app/1.0 (Flutter; Dart)'},
      );

      if (response.statusCode == 200) {
        final results = json.decode(response.body) as List;
        if (results.isEmpty) {
          // Call getDataByNameAndAccountNumber if no suggestions
          final fallbackData = await getDataByNameAndAccountNumber(query);
          if (fallbackData['getDataByNameAndAccountNumber'] != null) {
            return List<Map<String, dynamic>>.from(
              fallbackData['getDataByNameAndAccountNumber'],
            );
          }
          return [];
        }

        return results.map((result) {
          return {
            'name': result['display_name'],
            'latitude': result['lat'],
            'longitude': result['lon'],
          };
        }).toList();
      } else {
        final fallbackData = await getDataByNameAndAccountNumber(query);
        if (fallbackData['getDataByNameAndAccountNumber'] != null) {
          return List<Map<String, dynamic>>.from(
            fallbackData['getDataByNameAndAccountNumber'],
          );
        }
        return [];
      }
    } catch (e) {
      print("Error fetching location suggestions: $e");
      return [];
    }
  }

  // // Update map location based on the selected suggestion
  // Future<void> _updateMapLocation(String suggestion) async {
  //   try {
  //     final url =
  //         'https://nominatim.openstreetmap.org/search?q=$suggestion&format=json&limit=1';
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'User-Agent': 'flutter_map_app/1.0 (Flutter; Dart)',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final results = json.decode(response.body) as List;
  //       if (results.isNotEmpty) {
  //         final location = results.first;
  //         final newLocation = LatLng(
  //           double.parse(location['lat']),
  //           double.parse(location['lon']),
  //         );

  //         // setState(() {
  //         //   _currentLocation = newLocation;
  //         // });
  //         // _mapController.move(
  //         //     newLocation, _currentZoom); // Center the map on the location

  //         setState(() {
  //           _currentLocation = newLocation;
  //           _markerSearch = [
  //             Marker(
  //               point: newLocation,
  //               builder: (ctx) => const Icon(
  //                 Icons.location_on,
  //                 color: Colors.red,
  //                 size: 40.0,
  //               ),
  //             ),
  //           ];
  //         });
  //         _mapController.move(newLocation, _currentZoom);
  //       }
  //     }
  //   } catch (e) {
  //     // print("Error updating map location: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Error locating address')),
  //     );
  //   }
  // }

  Future<void> _updateMapLocation(String suggestion, String? geometry) async {
    try {
      // If geometry is provided, bypass API and use it directly
      if (geometry != null && geometry.startsWith("POINT")) {
        print("Using GEOMETRY directly...");

        // Extract coordinates from "POINT (lon lat)"
        final cleaned = geometry.replaceAll("POINT (", "").replaceAll(")", "");
        final parts = cleaned.split(" ");

        double lon = double.parse(parts[0]);
        double lat = double.parse(parts[1]);

        final newLocation = LatLng(lat, lon);

        setState(() {
          _currentLocation = newLocation;
          _markerSearch = [
            Marker(
              point: newLocation,
              child:
                  const Icon(Icons.location_on, color: Colors.red, size: 40.0),
            ),
          ];
        });
        _mapController.move(newLocation, _currentZoom);
        return;
      }
      final encodedQuery = Uri.encodeComponent(suggestion);
      final url =
          'https://nominatim.openstreetmap.org/search?q=$encodedQuery&format=json&limit=1';

      print('url222:: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'flutter_map_app/1.0 (Flutter; Dart)'},
      );

      if (response.statusCode == 200) {
        print('success in location reset................');
        final results = json.decode(response.body) as List;

        if (results.isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Address not found')));
          return;
        }

        final location = results.first;

        final newLocation = LatLng(
          double.parse(location['lat']),
          double.parse(location['lon']),
        );

        setState(() {
          _currentLocation = newLocation;
          _markerSearch = [
            Marker(
              point: newLocation,
              child:
                  const Icon(Icons.location_on, color: Colors.red, size: 40.0),
            ),
          ];
        });

        _mapController.move(newLocation, _currentZoom);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error locating address')));
    }
  }

  Future<List<dynamic>?> fetchDataByLatLong(
    double latitude,
    double longitude,
  ) async {
    const String baseUrl =
        'https://atsdev2test.ariespro.com/civmapi/supervisorLoginPanel/getDataByLatitudeLongitude';
    final Uri url = Uri.parse(
      '$baseUrl?latitude=$latitude&longitude=$longitude',
    );
    print(url);
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final http.Response response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${data.token!}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['getDataByLatitudeLongitude'] is List) {
          return jsonData['getDataByLatitudeLongitude'];
        } else {
          print('Unexpected response structure: ${response.body}');
          return null;
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<void> fetchDataAndShowDialog(
    BuildContext ctx,
    double latitude,
    double longitude,
  ) async {
    showDialog(
      context: ctx,
      barrierDismissible: false, // Prevent dismissing while loading
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          content: const SizedBox(
            height: 120,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Colors.blue, // Customize color
                    strokeWidth: 4, // Thicker stroke
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Fetching Data...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    final data = await fetchDataByLatLong(latitude, longitude);
    Navigator.pop(ctx);
    if (data != null && data.isNotEmpty) {
      showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Customer Name : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: data[0]['wmBF_Name'] ?? "NA",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Address : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: data[0]['wmBF_Ser_2'] ?? "NA",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    if (data[0]['wmBF_Phone'] != '' &&
                        data[0]['wmBF_Phone'] != null)
                      setState(() {
                        _launched = _makePhoneCall(data[0]['wmBF_Phone']);
                      });
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Phone Number : ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      children: [
                        TextSpan(
                          text: data[0]['wmBF_Phone'] ?? "NA",
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Phase : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: data[0]['wmPhasing'] ?? "NA",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Map Location No : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: data[0]['wmElementN'] ?? "NA",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Parcel : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: data[0]['parcelNumber'] ?? "NA",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Comment : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: data[0]['comment'] ?? "NA",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      _showSnackBar('No data available');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Future<dynamic> getDataByNameAndAccountNumber(String accOrName) async {
    //102114900
    print('inside getDataByNameAndAccountNumber');
    const String endpoint =
        "https://atsdev2test.ariespro.com/civmapi/supervisorLoginPanel/getDataByNameAndAccountNumber";
    final Uri url = Uri.parse("$endpoint?accOrName=$accOrName");
    print('inside getDataByNameAndAccountNumber');
    print(url);
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    final headers = {'Authorization': 'Bearer ${data.token!}'};

    try {
      final response = await http.get(url, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('data: $data');
        return data;
      } else {
        print(
          'Error: Status code ${response.statusCode}, Body: ${response.body}',
        );
        return {
          "error":
              "Failed to load data. Status code: ${response.statusCode}, Body: ${response.body}",
        };
      }
    } catch (e) {
      print("Error occurred: $e");
      return {"error": "An error occurred: $e"};
    }
  }

  double haversineDistance(LatLng start, LatLng end) {
    const R = 6371e3; // Earth's radius in meters
    final lat1 = start.latitude * pi / 180;
    final lat2 = end.latitude * pi / 180;
    final deltaLat = (end.latitude - start.latitude) * pi / 180;
    final deltaLon = (end.longitude - start.longitude) * pi / 180;

    final a =
        sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) * sin(deltaLon / 2) * sin(deltaLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in meters
  }

  List<LatLng> createSegment(LatLng start, LatLng end, double fraction) {
    return [
      LatLng(
        start.latitude + (end.latitude - start.latitude) * fraction,
        start.longitude + (end.longitude - start.longitude) * fraction,
      ),
    ];
  }

  List<Polyline> createDashedLine(
    LatLng start,
    LatLng end,
    double dashLength,
    Color passedColor,
  ) {
    List<Polyline> dashedLine = [];
    double totalDistance = haversineDistance(start, end);
    int dashCount = (totalDistance / dashLength).floor();

    for (int i = 0; i < dashCount; i++) {
      double startFraction = (i * dashLength) / totalDistance;
      double endFraction = ((i + 1) * dashLength) / totalDistance;

      if (i % 2 == 0) {
        // Create visible segments
        dashedLine.add(
          Polyline(
            points: [
              createSegment(start, end, startFraction)[0],
              createSegment(start, end, endFraction)[0],
            ],
            color: passedColor,
            strokeWidth: 4.0,
          ),
        );
      }
    }
    return dashedLine;
  }

  Future<String?> _showFeederColorDialog(BuildContext context) async {
    Map<String, Color> colorMap = {
      "FDR1": const Color.fromARGB(255, 1, 127, 5),
      "FDR2": const Color.fromARGB(255, 96, 0, 113),
      "FDR3": const Color.fromARGB(255, 247, 19, 2),
      "FDR4": const Color.fromARGB(255, 38, 1, 247),
      "FDR5": Colors.yellow,
      "FDR6": const Color.fromARGB(255, 113, 68, 1),
    };

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Color Feeder"), // Title
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: colorMap.entries.map((entry) {
              return ListTile(
                leading: Container(
                  width: 60,
                  height: 8,
                  decoration: BoxDecoration(
                    color: entry.value,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                title: Text(entry.key.toUpperCase()),
                onTap: () {
                  Navigator.pop(
                    context,
                    entry.key,
                  ); // Return the selected color
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _handleFeederTap(BuildContext context) async {
    String? selectedColor = await _showFeederColorDialog(context);
    if (selectedColor != null) {
      print("Selected color: $selectedColor");
    }
  }

  Future<String?> _showWorkColorDialog(BuildContext context) async {
    Map<String, Color> colorMap = {
      "Jaraff": const Color.fromARGB(255, 96, 0, 113),
      "Mowing": const Color.fromARGB(255, 113, 68, 1),
      "Mini Jaraff": const Color.fromARGB(255, 247, 19, 2),
      "BYL": const Color.fromARGB(255, 2, 212, 249),
      "Bucket": Colors.orange,
      "Ground": Colors.yellow,
      "Cross-country spray": const Color.fromARGB(255, 38, 1, 247),
      "Roadside spray": const Color.fromARGB(255, 1, 127, 5),
      "No spray": const Color.fromARGB(255, 252, 199, 249),
    };

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Color Work"), // Title
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: colorMap.entries.map((entry) {
              return ListTile(
                leading: Container(
                  width: 60,
                  height: 8,
                  decoration: BoxDecoration(
                    color: entry.value,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                title: Text(entry.key.toUpperCase()),
                onTap: () {
                  Navigator.pop(
                    context,
                    entry.key,
                  ); // Return the selected color
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _handleWorkTap(BuildContext context) async {
    String? selectedColor = await _showWorkColorDialog(context);
    if (selectedColor != null) {
      print("Selected color: $selectedColor");
    }
  }

  Future<void> getMapLinesBySubstation(
    BuildContext context,
    String substationName,
  ) async {
    final String url =
        'https://atsdev2test.ariespro.com/civmapi/supervisorLoginPanel/getMapLinesBySubstationAndType?substationName=$substationName';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print('Fetching map lines from URL: $url');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": 'Bearer ${data.token!}',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("API Response: $jsonData");

        if (jsonData == null ||
            !jsonData.containsKey('data') ||
            jsonData['data'] == null) {
          print("Error: 'data' key is missing or null in API response.");
          return;
        }
        // Extract all line categories (MidCycle, ChangeOrder, IVM)
        List allLines = [
          ...?jsonData['data']['MidCycleMapLines'],
          ...?jsonData['data']['ChangeOrderMapLines'],
          ...?jsonData['data']['IVMMapLines'],
        ];
        if (allLines.isEmpty) {
          print("Warning: No map lines available for this substation.");
          return;
        }
        List<Map<String, dynamic>> parsedLines = [];
        List<LatLng> memberPoints = [];

        for (var feature in allLines) {
          if (feature is Map<String, dynamic> &&
              feature.containsKey('geometry')) {
            String geometry = feature['geometry'];
            String color = feature.containsKey('color')
                ? feature['color']
                : "black"; // Default color

            if (geometry.startsWith("LINESTRING")) {
              List<LatLng> line = _parseLineString(geometry);
              if (line.isNotEmpty) {
                parsedLines.add({
                  "coordinates": line,
                  "color": _getColorFromString(
                    color,
                  ), // Convert color string to Color object
                });
              }
            }
          }
        }
        // Parse MemberData (POINT)
        if (jsonData['data'].containsKey('MemberData') &&
            jsonData['data']['MemberData'] is List) {
          for (String point in jsonData['data']['MemberData']) {
            LatLng? latLng = _parsePoint(point);
            if (latLng != null) {
              memberPoints.add(latLng);
            }
          }
        }
        if (parsedLines.isNotEmpty) {
          print("✅ Calling _plotLayersOnMap()");
          _plotLayersOnMap(parsedLines, memberPoints);
        } else {
          print("⚠️ No data to plot!");
        }
      } else {
        print(
          'Failed to load layers data from API: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error in loading layers data: $e');
    }
  }

  Color _getColorFromString(String colorName) {
    Map<String, Color> colorMap = {
      "red": const Color.fromARGB(255, 247, 19, 2),
      "blue": const Color.fromARGB(255, 38, 1, 247),
      "green": const Color.fromARGB(255, 1, 127, 5),
      "yellow": Colors.yellow,
      "purple": const Color.fromARGB(255, 96, 0, 113),
      "orange": Colors.orange,
      "skyblue": const Color.fromARGB(255, 2, 212, 249), // Custom color
      "black": Colors.black,
    };
    return colorMap[colorName.toLowerCase()] ??
        Colors.black; // Default to black if not found
  }

  List<LatLng> _parseLineString(String lineString) {
    String cleanString = lineString
        .replaceAll("LINESTRING (", "")
        .replaceAll(")", "");
    List<LatLng> coordinates = [];
    List<String> pairs = cleanString.split(", ");
    for (var pair in pairs) {
      List<String> values = pair.split(" ");
      if (values.length == 2) {
        double lon = double.parse(values[0]); // Longitude
        double lat = double.parse(values[1]); // Latitude
        coordinates.add(LatLng(lat, lon));
      }
    }
    print("Parsed LINESTRING: $coordinates");
    return coordinates;
  }

  void _plotLayersOnMap(
    List<Map<String, dynamic>> linesWithColors,
    List<LatLng> memberPoints,
  ) {
    List<Polyline> polylines = [];
    List<Marker> markers = [];

    for (var lineData in linesWithColors) {
      List<LatLng> line = lineData["coordinates"];
      Color lineColor = lineData["color"];
      polylines.add(Polyline(points: line, color: lineColor, strokeWidth: 8.0));
    }
    for (LatLng point in memberPoints) {
      markers.add(
        Marker(
          point: point,
          width: 40, // Marker size
          height: 40,
          child: InkWell(
            onTap: () {
              fetchDataAndShowDialog(context, point.longitude, point.latitude);
            },
            child: Image.asset(
              'assets/caution_icon.png', // Replace with your image path
              width: 10,
              height: 10,
            ),
          ),
        ),
      );
    }

    setState(() {
      myPolylines = polylines;
      myMarkers = markers;
    });
  }

  LatLng? _parsePoint(String pointString) {
    try {
      String cleanString = pointString
          .replaceAll("POINT (", "")
          .replaceAll(")", "");
      List<String> values = cleanString.split(" ");
      if (values.length == 2) {
        double lon = double.parse(values[0]);
        double lat = double.parse(values[1]);
        return LatLng(lat, lon);
      }
    } catch (e) {
      print("Error parsing POINT: $pointString - $e");
    }
    return null;
  }
}
