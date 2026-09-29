// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/utils/geojson_parser.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_compass/flutter_compass.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:geojson/geojson.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
// import 'package:http/http.dart' as http;

// class MapScreenLeafLat1 extends StatefulWidget {
//   const MapScreenLeafLat1({Key? key}) : super(key: key);

//   @override
//   _MapScreenLeafLat1State createState() => _MapScreenLeafLat1State();
// }

// class _MapScreenLeafLat1State extends State<MapScreenLeafLat1>
//     with TickerProviderStateMixin {
//   late final MapController _mapController;
//   double _currentZoom = 17.0;
//   LatLng? _currentLocation;
//   LatLng? newLocation;
//   List<Marker> _markers = [];
//   List<Marker> _markers1 = [];
//   List<Marker> _markerSearch = [];
//   double _deviceHeading = 0.0;
//   int driveMode = 0;

//   // Marker move
//   int numDeltas = 100; //number of delta to devide total distance
//   int delay = 10; //milliseconds of delay to pass each delta
//   var i = 0;
//   double? deltaLat;
//   double? deltaLng;
//   var position; //position variable while moving marker

//   List<String> subNumbers = [];
//   List<GeoJsonFeature> features = [];

//   GeoJsonParser myGeoJson = GeoJsonParser();

//   GeoJsonParser myGeoJson1fdr1 = GeoJsonParser();
//   GeoJsonParser myGeoJson1fdr2 = GeoJsonParser();
//   GeoJsonParser myGeoJson1fdr3 = GeoJsonParser();
//   GeoJsonParser myGeoJson1fdr4 = GeoJsonParser();
//   GeoJsonParser myGeoJson1fdr5 = GeoJsonParser();
//   GeoJsonParser myGeoJson1fdr6 = GeoJsonParser();

//   GeoJsonParser myGeoJson2 = GeoJsonParser();

//   GeoJsonParser myGeoJson3Fdr1 = GeoJsonParser();
//   GeoJsonParser myGeoJson3Fdr2 = GeoJsonParser();
//   GeoJsonParser myGeoJson3Fdr3 = GeoJsonParser();
//   GeoJsonParser myGeoJson3Fdr4 = GeoJsonParser();
//   GeoJsonParser myGeoJson3Fdr5 = GeoJsonParser();
//   GeoJsonParser myGeoJson3Fdr6 = GeoJsonParser();

//   late StreamSubscription<Position> _positionStreamSubscription;

//   // ignore: prefer_typing_uninitialized_variables
//   var subNumberLocalVariable;

//   String? lastSubNumber;
//   final TextEditingController _searchController = TextEditingController();
//   bool _showedLocationpin = false;

//   Map<String, dynamic>? consumerData;

//   Future<void>? _launched;

//   List<Polyline> myPolylines = [];
//   List<Marker>myMarkers = [];
//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();
//     _initializeMap();
//     _addLabelMarker();
//     _startListeningToCompass();
//     // fetchDataByLatLong(-92.4764153135444, 48.341346233286);
//     WakelockPlus.enable();
//   }

//   Future<void> _initializeMap() async {
//     await _getCurrentLocation();
//     _listenToLocationUpdates();
//     _loadGeoJSONBoundary();
//     //earlier it was called from here
//     /////////////////////////////////////////
//     // _loadGeoJSON1();
//     // _loadGeoJSON2();
//     // _loadGeoJSON3();
//     // await _loadGeoJSON();
//   }

//   void _startListeningToCompass() {
//     // print("_startListeningToCompass called");
//     FlutterCompass.events?.listen((CompassEvent event) {
//       setState(() {
//         _deviceHeading = event.heading ?? 0.0;
//         if (driveMode == 1) {
//           _mapController.rotate(-_deviceHeading);
//         }
//       });
//     });
//   }

//   Future<void> _loadGeoJSONBoundary() async {
//     final String geoJSONStringBoundary =
//         await rootBundle.loadString('assets/sub_boundary_without_chd.geojson');
//     // final String geoJSONStringBoundary =
//     //     await rootBundle.loadString('assets/sub_boundary_with_chd1.geojson');
//     setState(() {
//       myGeoJson.parseGeoJsonAsString(geoJSONStringBoundary);
//     });
//   }

//   Future<void> _loadGeoJSON() async {
//     // print("_loadGeoJSON called");
//     try {
//       final String geoJSONString = await rootBundle
//           .loadString('assets/sub_boundary_without_chd.geojson');
//       // final String geoJSONString =
//       //     await rootBundle.loadString('assets/sub_boundary_with_chd1.geojson');

//       // Create a GeoJson object and parse the string
//       final geoJson = GeoJson();
//       await geoJson.parse(geoJSONString); // Parse GeoJSON

//       if (geoJson.features.isNotEmpty) {
//         // print("GeoJSON successfully parsed.");
//         // print("Features loaded: ${geoJson.features.length}");
//         // print("GeoJSON features: ${geoJson.features}");

//         // List<LatLng> currentLocationList=[];

//         // LatLng currentLocation0 = LatLng(47.88055437960927, -92.48728531369036); //Frazer Bay
//         // LatLng currentLocation1 = LatLng(47.83444818680236, -92.34369812225371); //Vermillion
//         // LatLng currentLocation2 = LatLng(47.04895013622139, -94.15842678612894); //Longville
//         // LatLng currentLocation3 = LatLng(48.211236867475584, -92.49458100593375); //Orr
//         // LatLng currentLocation4 = LatLng(46.969032111544934, -93.64780626065327); //Hill City
//         // LatLng currentLocation5 = LatLng(47.977607951048675, -92.52900686415383); //Cook
//         // LatLng currentLocation6 = LatLng(47.79918727655814, -92.65972091716121); //Potlatch
//         // LatLng currentLocation7 = LatLng(47.40769249081645, -92.3730271124764); //Lakeland
//         // LatLng currentLocation8 = LatLng(47.492748857513604, -93.2708576030474); //Shoal Lake
//         // LatLng currentLocation9 = LatLng(46.81626410896614, -93.28371047055131); //Big Sandy
//         // LatLng currentLocation10 = LatLng(47.43972458621422, -92.71564507512474); //Iron
//         // LatLng currentLocation11 = LatLng(47.39488658263989, -93.98741836831131); //Ball Club
//         // LatLng currentLocation12 = LatLng(47.98363280627945, -91.68760141011201); //Winton B
//         // LatLng currentLocation13 = LatLng(47.91096039966965, -93.07470621389601); //Meadowbrook
//         // LatLng currentLocation14 = LatLng(47.64989335670572, -92.3966821231562); //Pike River
//         // LatLng currentLocation15 = LatLng(47.63389411798467, -92.99819923063122); //Side Lake
//         // LatLng currentLocation16 = LatLng(46.69849637697413, -93.24548480032941); //Round Lake
//         // LatLng currentLocation17 = LatLng(47.4127302161937, -92.09536306158428); //Lakeland B
//         // LatLng currentLocation18 = LatLng(46.89888854118592, -92.50231191793529); //Grand Lake
//         // LatLng currentLocation19 = LatLng(46.864062735932201,-92.291461947348395); //Solway
//         // LatLng currentLocation20 = LatLng( 46.713503158065699, -92.366048900649304); //Knife Falls
//         // LatLng currentLocation21 = LatLng(47.23455517178613, -93.71686954166097); //Cohasset
//         // LatLng currentLocation22 = LatLng(47.32706962122148, -92.93774163937496); //Keewatin
//         // LatLng currentLocation23 = LatLng(46.67817817347821, -93.12612268485078); //Wright
//         // LatLng currentLocation24 = LatLng(46.50343933751238, -92.91267414007538); //Kettle River
//         // LatLng currentLocation25 = LatLng(46.80377825632088, -92.66268869892734); //Brandon
//         // LatLng currentLocation26 = LatLng(46.97700021150396, -92.32579962868962); //Bergen Lake
//         // LatLng currentLocation27 = LatLng(47.077920977138376, -94.41341405316115); //Onigum
//         // LatLng currentLocation28 = LatLng(47.211334651716776, -93.13431933460436); //Goodland
//         // LatLng currentLocation29 = LatLng(47.31437233102813, -92.56485698362752); //Peary
//         // LatLng currentLocation30 = LatLng(47.29717511053933, -94.3315808579297); //Bena
//         // LatLng currentLocation31 = LatLng(47.802917995897076, -91.73650419058164); //WINTON A
//         LatLng currentLocation32 = LatLng(47.08005321167195, -93.00535771569302); //Cedar Valley
//         // LatLng currentLocation33 = LatLng(47.38460982760358, -93.56694948594011); //Arbo
//         // LatLng currentLocation34 = LatLng(46.636512714544899,-92.924437582926004, ); //Cromwell
//         // LatLng currentLocation35 = LatLng(47.67404076013045, -92.67090460249017); //Sand Lake
//         // LatLng currentLocation36 = LatLng(46.87071246305832, -92.90291263872044); //Gowan
//         // LatLng currentLocation37 = LatLng(47.08565240431225, -93.50683407362655); //Pokegama
//         // LatLng currentLocation38 = LatLng(47.18631923726539, -94.10334942148874); //Boy River
//         // LatLng currentLocation39 = LatLng(47.074952567038494, -93.88040845887213); //Remer
//         // LatLng currentLocation40 = LatLng(47.16578808127717, -93.33253422767572); //Blackberry
//         // LatLng currentLocation41 = LatLng(47.21834115867768, -93.44958363295417); //Gunn
//         // LatLng currentLocation42 = LatLng(46.41012814573855, -92.640567427713); //Sturgeon Lake B
//         // LatLng currentLocation43 = LatLng(46.36308718663967, -92.7272002780472); //Sturgeon Lake
//         // LatLng currentLocation44 = LatLng(47.71093495958199, -92.06803765316182); //Babbitt
//         // LatLng currentLocation45 = LatLng(47.85575630331953, -92.09752489509043); //Clear Lake
//         // LatLng currentLocation46 = LatLng(47.119817653350204, -92.45542845134987); //Cotton

//         // currentLocationList.add(currentLocation0);
//         // currentLocationList.add(currentLocation1);
//         // currentLocationList.add(currentLocation2);
//         // currentLocationList.add(currentLocation3);
//         // currentLocationList.add(currentLocation4);
//         // currentLocationList.add(currentLocation5);
//         // currentLocationList.add(currentLocation6);
//         // currentLocationList.add(currentLocation7);
//         // currentLocationList.add(currentLocation8);
//         // currentLocationList.add(currentLocation9);
//         // currentLocationList.add(currentLocation10);
//         // currentLocationList.add(currentLocation11);
//         // currentLocationList.add(currentLocation12);
//         // currentLocationList.add(currentLocation13);
//         // currentLocationList.add(currentLocation14);
//         // currentLocationList.add(currentLocation15);
//         // currentLocationList.add(currentLocation16);
//         // currentLocationList.add(currentLocation17);
//         // currentLocationList.add(currentLocation18);
//         // currentLocationList.add(currentLocation19);
//         // currentLocationList.add(currentLocation20);
//         // currentLocationList.add(currentLocation21);
//         // currentLocationList.add(currentLocation22);
//         // currentLocationList.add(currentLocation23);
//         // currentLocationList.add(currentLocation24);
//         // currentLocationList.add(currentLocation25);
//         // currentLocationList.add(currentLocation26);
//         // currentLocationList.add(currentLocation27);
//         // currentLocationList.add(currentLocation28);
//         // currentLocationList.add(currentLocation29);
//         // currentLocationList.add(currentLocation30);
//         // currentLocationList.add(currentLocation31);
//         // currentLocationList.add(currentLocation32);
//         // currentLocationList.add(currentLocation33);
//         // currentLocationList.add(currentLocation34);
//         // currentLocationList.add(currentLocation35);
//         // currentLocationList.add(currentLocation36);
//         // currentLocationList.add(currentLocation37);
//         // currentLocationList.add(currentLocation38);
//         // currentLocationList.add(currentLocation39);
//         // currentLocationList.add(currentLocation40);
//         // currentLocationList.add(currentLocation41);
//         // currentLocationList.add(currentLocation42);
//         // currentLocationList.add(currentLocation43);
//         // currentLocationList.add(currentLocation44);
//         // currentLocationList.add(currentLocation45);
//         // currentLocationList.add(currentLocation46);
//         // Random r=Random();
//         // _parseSubNumbers(geoJson.features, currentLocationList[r.nextInt(47)]); // Pass features directly
//         // var currentLocationTemp = LatLng(46.50343933751238, -92.91267414007538);
//         ///////////////////////////////////////////////////////////////////////
//         // var currentLocationTemp = LatLng( 47.289840451050097 , -93.502918922918695);//arbo
//         //  var currentLocationTemp = LatLng( 47.862693654625701 ,-92.6937729117613);//cook  
//         // var currentLocationTemp = LatLng( 47.371520919049303 ,-92.922107081795602); //keewaitin
//         // var currentLocationTemp = LatLng( 47.941145481628901 ,-92.848821994884602); //meadowBrook
//         // var currentLocationTemp = LatLng( 48.263433999999897 ,-92.487853);  //Orr
//         // var currentLocationTemp = LatLng( 47.591574595476303 ,-92.946160387670105);  //sideLake
//         // var currentLocationTemp = LatLng( 47.660320000009499 ,-92.245978999999807); //Babbit 
//         // var currentLocationTemp = LatLng( 47.843758946735697,-92.194639986990495); //ClearLake
//         //  var currentLocationTemp = LatLng(47.864818684664201, -92.461866900374503); //FrazerBay
//         //  var currentLocationTemp = LatLng(47.618507000009501, -92.523354999999896); //pikeRiver
//         //  var currentLocationTemp = LatLng( 47.660738834226301, -92.641566258311201); //pikeRiver
         
//         // _parseSubNumbers(geoJson.features, currentLocation32);
//         _parseSubNumbers(geoJson.features, _currentLocation!);
//       } else {
//         print("Failed to parse GeoJSON: No features found.");
//       }
//     } catch (e) {
//       print("Error loading GeoJSON: $e");
//     }
//   }

//   void _parseSubNumbers(
//       List<GeoJsonFeature> geoJsonFeatures, LatLng currentLocation) {
//     // print('location update called...........');
//     // print('_currentLocation $currentLocation');
//     if (geoJsonFeatures.isEmpty) {
//       print("No features to parse.");
//       return;
//     }

//     for (var feature in geoJsonFeatures) {
//       // print("Feature properties: ${feature.properties}");
//       // print("Feature geometry: ${feature.geometry}");
//       if (feature.geometry != null && feature.geometry is GeoJsonMultiPolygon) {
//         var multiPolygon = feature.geometry as GeoJsonMultiPolygon;

//         // Loop through each polygon in the multiPolygon
//         for (var polygon in multiPolygon.polygons) {
//           var coordinates;
//           if (polygon.geoSeries != null && polygon.geoSeries.isNotEmpty) {
//             // Extract the geoPoints from the first geoSeries (assuming each geoSeries has multiple points)
//             coordinates = polygon
//                 .geoSeries[0].geoPoints; // This is a list of GeoPoint objects
//           }
//           if (coordinates != null) {
//             // Convert the coordinates to LatLng using the latitude and longitude properties of GeoPoint
//             List<LatLng> polygonLatLng = coordinates.map<LatLng>((point) {
//               return LatLng(
//                   point.latitude,
//                   point
//                       .longitude); // GeoPoint has latitude and longitude directly
//             }).toList();

//             // Check if the current location is inside this polygon
//             if (_isPointInPolygon(currentLocation, polygonLatLng)) {
//               var currentSubNumber = feature.properties!['UplineSour'];
//               if (currentSubNumber != lastSubNumber) {
//                 // print("Current location is in Substation: $currentSubNumber");
//                 subNumberLocalVariable = currentSubNumber;
//                 // print('subNumberLocalVariable: $subNumberLocalVariable');
//                 _addPolygonToMap(
//                     polygonLatLng); // Add polygon only if SubNumber is new
//                 lastSubNumber =
//                     currentSubNumber; // Update last processed SubNumber

//                     String extractedName = currentSubNumber.replaceAll(RegExp(r'^\d+-\s*'), '');
//                     print("Substation NameOnlyName: $extractedName");
//                     getMapLinesBySubstation(context,extractedName);
//               } else {
//                 print("SubNumber $currentSubNumber is the same as before.");
//               }
//             } else {
//               // print(
//               //     "Your current loaction is not in any of the Substations00000");
//               const SnackBar(
//                   content: Text(
//                       "Your current loaction is not in any of the Substations"));
//             }
//           }
//         }
//       } else {
//         print("Unsupported geometry type: ${feature.geometry.runtimeType}");
//       }
//     }
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       _showSnackBar("Location services are disabled.");
//       // return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         _showSnackBar("Location permissions are denied.");
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       _showSnackBar("Location permissions are permanently denied.");
//       return;
//     }

//     Position position1 = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     setState(() {
//       position = [position1.latitude, position1.longitude];
//       _currentLocation = LatLng(position1.latitude, position1.longitude);
//       _updateMarker();
//       _checkIfLocationInsidePolygon();
//     });
//   }

//   void _addLabelMarker() {
//     _markers1 = [
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.88055437960927, -92.48728531369036),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Frazer_Bay.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.83444818680236, -92.34369812225371),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Vermillion.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.04895013622139, -94.15842678612894),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Longville.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(48.211236867475584, -92.49458100593375),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Orr.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.969032111544934, -93.64780626065327),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Hill_City.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.977607951048675, -92.52900686415383),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Cook.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.79918727655814, -92.65972091716121),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Potlatch.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.40769249081645, -92.3730271124764),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Lakeland.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.492748857513604, -93.2708576030474),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Shoal_Lake.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.81626410896614, -93.28371047055131),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Big_Sandy.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.43972458621422, -92.71564507512474),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Iron.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.39488658263989, -93.98741836831131),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Ball_Club.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.98363280627945, -91.68760141011201),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Winton_B.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.91096039966965, -93.07470621389601),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Meadowbrook.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.64989335670572, -92.3966821231562),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Pike_River.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.63389411798467, -92.99819923063122),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Side_Lake.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.69849637697413, -93.24548480032941),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Round_Lake.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.4127302161937, -92.09536306158428),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Lakeland_B.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.89888854118592, -92.50231191793529),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Grand_Lake.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.87953286681191, -92.27364068126433),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Solway.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.74991094955096, -92.41172524061628),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Knife_Falls.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.23455517178613, -93.71686954166097),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Cohasset.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.32706962122148, -92.93774163937496),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Keewatin.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.67817817347821, -93.12612268485078),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Wright.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.50343933751238, -92.91267414007538),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Kettle_River.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.80377825632088, -92.66268869892734),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Brandon.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.97700021150396, -92.32579962868962),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Bergen_Lake.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.077920977138376, -94.41341405316115),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Onigum.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.211334651716776, -93.13431933460436),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Goodland.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.31437233102813, -92.56485698362752),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Peary.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.29717511053933, -94.3315808579297),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Bena.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.802917995897076, -91.73650419058164),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Winton_A.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.08005321167195, -93.00535771569302),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Cedar_Valley.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.38460982760358, -93.56694948594011),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Arbo.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.68349032301296, -92.80646586881205),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Cromwell.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.67404076013045, -92.67090460249017),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Sand_Lake.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.87071246305832, -92.90291263872044),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Gowan.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.08565240431225, -93.50683407362655),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Pokegama.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.18631923726539, -94.10334942148874),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Boy_River.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.074952567038494, -93.88040845887213),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Remer.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.16578808127717, -93.33253422767572),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Blackberry.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.21834115867768, -93.44958363295417),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Gunn.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.41012814573855, -92.640567427713),
//         builder: (ctx) =>
//             Image.asset('assets/sub_name_icon/Sturgeon_Lake_B.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(46.36308718663967, -92.7272002780472),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Sturgeon_Lake.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.71093495958199, -92.06803765316182),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Babbitt.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.85575630331953, -92.09752489509043),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/Clear_Lake.png'),
//       ),
//       Marker(
//         rotateOrigin: const Offset(0.5, 0.5),
//         point: LatLng(47.119817653350204, -92.45542845134987),
//         builder: (ctx) => Image.asset('assets/sub_name_icon/cotton.png'),
//       ),
//     ];
//   }

//   void _updateMarker() {
//     // print("_updateMarker called");
//     if (_currentLocation != null) {
//       _markers = [
//         Marker(
//           rotateOrigin: const Offset(0.5, 0.5),
//           point: _currentLocation!,
//           builder: (ctx) => Transform.rotate(
//             angle: _deviceHeading * (pi / 180),
//             child: const Icon(
//               Icons.navigation,
//               color: Colors.blue,
//               size: 40,
//             ),
//           ),
//         ),
//       ];
//       setState(() {
//         //UI Refresh
//       });
//     }
//   }

//   void _listenToLocationUpdates() {
//     // print("_listenToLocationUpdates called");
//     _positionStreamSubscription =
//         Geolocator.getPositionStream().listen((Position position) {
//       // print("Location updated: $newLocation");
//       setState(() {
//         newLocation = LatLng(position.latitude, position.longitude);
//         var result = [
//           position.latitude,
//           position.longitude
//         ]; //latitude and longitude of new position
//         transition(result); //start moving marker
//         // _currentLocation = newLocation;

//         // _updateMarker();
//         if (_currentLocation != null) {
//             animateMarkerMove(_currentLocation!, newLocation!);
//         } else {
//         _currentLocation = newLocation;
//         _updateMarker();
//         }

//         _loadGeoJSON();
//         if (driveMode == 1) {
//           // _mapController.move(_currentLocation!, _currentZoom);
//           animatedMapMove(_currentLocation!, _currentZoom);
//         }
//       });
//     });
//   }

//   transition(result) {
//     i = 0;
//     deltaLat = (result[0] - position[0]) / numDeltas;
//     deltaLng = (result[1] - position[1]) / numDeltas;
//     moveMarker();
//   }

//   moveMarker() {
//     position[0] += deltaLat;
//     position[1] += deltaLng;
//     var latlng = LatLng(position[0], position[1]);

//     if (_currentLocation != null) {
//       _markers = [
//         Marker(
//           // rotateOrigin: const Offset(0.5, 0.5),
//           point: latlng,
//           builder: (ctx) => Transform.rotate(
//             angle: _deviceHeading * (pi / 180),
//             child: const Icon(
//               Icons.navigation,
//               color: Colors.blue,
//               size: 40,
//             ),
//           ),
//         ),
//       ];
//     }

//     setState(() {
//       //refresh UI
//     });

//     if (i != numDeltas) {
//       i++;
//       Future.delayed(Duration(milliseconds: delay), () {
//         moveMarker();
//       });
//     }
//   }

//   void _zoomIn() {
//     setState(() {
//       _currentZoom = (_currentZoom + 1).clamp(1.0, 17.0);
//       _mapController.move(_mapController.center, _currentZoom);
//     });
//   }

//   void _zoomOut() {
//     // print('zoomOut pressed');
//     setState(() {
//       _currentZoom = (_currentZoom - 1).clamp(1.0, 17.0);
//       _mapController.move(_mapController.center, _currentZoom);
//     });
//   }

//   void _resetRotation() {
//     setState(() {
//       _deviceHeading = 0.0;
//     });
//     _mapController.rotate(0.0);
//   }

//   void _checkIfLocationInsidePolygon() {
//     if (_currentLocation != null && myGeoJson.features.isNotEmpty) {
//       for (var feature in myGeoJson.features) {
//         final geometry = feature.geometry;
//         if (geometry?.type == "MultiPolygon") {
//           // print("MultiPolygon::");
//           List<dynamic> coordinates = geometry!.coordinates;

//           // Iterate over the MultiPolygon coordinates
//           for (var polygon in coordinates) {
//             if (polygon is List) {
//               // Convert polygon to List<LatLng>
//               List<LatLng> latLngList = polygon
//                   .map<LatLng>((point) =>
//                       LatLng(point[1], point[0])) // Assuming [lat, lng]
//                   .toList();

//               // Now, you can use latLngList which is of type List<LatLng>
//               if (latLngList.isNotEmpty) {
//                 for (int i = 0; i < latLngList.length; i++) {
//                   var p1 = latLngList[i];
//                   var p2 = latLngList[(i + 1) % latLngList.length];
//                   // print("p1: $p1, p2: $p2");

//                   // Check if the current location is inside the polygon
//                   if (_isPointInPolygon(_currentLocation!, latLngList)) {
//                     final subNumber =
//                         feature.properties!['UplineSour'] ?? 'Unknown';
//                     // print('subNumber33333333333 $subNumber');
//                     _showSnackBar(
//                         "Current location is in SubNumber: $subNumber");
//                     return;
//                   }
//                 }
//               }
//             }
//           }
//         }
//       }
//       _showSnackBar("Current location is not in any SubNumber.");
//       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//           "Current location is not in any SubNumber.", context);
//     }
//   }

//   bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
//     int crossings = 0;
//     int n = polygon.length;

//     for (int i = 0; i < n; i++) {
//       LatLng p1 = polygon[i];
//       LatLng p2 = polygon[(i + 1) % n];

//       if (point.latitude > p1.latitude && point.latitude <= p2.latitude ||
//           point.latitude > p2.latitude && point.latitude <= p1.latitude) {
//         if (point.longitude <=
//             (p2.longitude - p1.longitude) *
//                     (point.latitude - p1.latitude) /
//                     (p2.latitude - p1.latitude) +
//                 p1.longitude) {
//           crossings++;
//         }
//       }
//     }

//     return crossings % 2 != 0; // Odd number of crossings means inside
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));

//     // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(message, context);
//   }

//   @override
//   void dispose() {
//     _positionStreamSubscription.cancel();
//     WakelockPlus.disable();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // _loadGeoJSON();
//     // List<Map<String, dynamic>> convertToMapList(
//     //     List<GetDataByNameAndAccountNumber> list) {
//     //   return list.map((item) {
//     //     return {
//     //       "parcelNumber": item.parcelNumber,
//     //       "wmBF_Accou": item.wmBFAccou,
//     //       "wmBF_Servi": item.wmBFServi,
//     //       "geometry": item.geometry,
//     //       "wmBF_Name": item.wmBFName,
//     //     };
//     //   }).toList();
//     // }

//     // List<Map<String, dynamic>> Function(
//     //     List<GetDataByNameAndAccountNumber> list) dataList = convertToMapList;

//     // List<Map<String, dynamic>> mappedDataList =
//     //     convertToMapList(dataList as List<GetDataByNameAndAccountNumber>);
//     // print('mappedDataList $mappedDataList');

//     return Scaffold(
//       // appBar: AppBar(title: const Text("Live IVM System Map")),
//               appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             "Live IVM System Map1",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
       
//         ),
//       body: _currentLocation == null
//           ? const Center(child: CircularProgressIndicator())
//           : Stack(
//               children: [
//                 FlutterMap(
//                   mapController: _mapController,
//                   options: MapOptions(
//                     center: _currentLocation ?? LatLng(0.0, 0.0),
//                     zoom: _currentZoom,
//                     rotation: _deviceHeading * pi / 180,
//                     maxZoom: 18,
//                     minZoom: 0.0,
//                     interactiveFlags: InteractiveFlag.all,
//                   ),
//                   children: [
//                     TileLayer(
//                       urlTemplate:
//                           "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                       subdomains: ['a', 'b', 'c'],
//                       userAgentPackageName: 'com.ariespro.civm', // Replace with your actual app package name
//                     ),
//                     PolygonLayer(polygons: myGeoJson.polygons),
//                     // PolylineLayer(polylines: myGeoJson1fdr1.polylines),
//                     // PolylineLayer(polylines: myGeoJson3Fdr1.polylines),
//                     PolylineLayer(
//                       polylines: myGeoJson1fdr1.polylines.map((polyline) {
//                         return Polyline(
//                           points: polyline.points,
//                           color: Colors.green,
//                           strokeWidth: 4.0,
//                         );
//                       }).toList(),
//                     ),
//                      PolylineLayer(
//                       polylines: myGeoJson1fdr2.polylines.map((polyline) {
//                         return Polyline(
//                           points: polyline.points,
//                           color: Colors.purple,
//                           strokeWidth: 4.0,
//                         );
//                       }).toList(),
//                     ),
//                      PolylineLayer(
//                       polylines: myGeoJson1fdr3.polylines.map((polyline) {
//                         return Polyline(
//                           points: polyline.points,
//                           color: Colors.red,
//                           strokeWidth: 4.0,
//                         );
//                       }).toList(),
//                     ), PolylineLayer(
//                       polylines: myGeoJson1fdr4.polylines.map((polyline) {
//                         return Polyline(
//                           points: polyline.points,
//                           color: const Color.fromARGB(255, 61, 2, 255),
//                           strokeWidth: 4.0,
//                         );
//                       }).toList(),
//                     ), PolylineLayer(
//                       polylines: myGeoJson1fdr5.polylines.map((polyline) {
//                         return Polyline(
//                           points: polyline.points,
//                           color: Colors.yellow,
//                           strokeWidth: 4.0,
//                         );
//                       }).toList(),
//                     ), PolylineLayer(
//                       polylines: myGeoJson1fdr6.polylines.map((polyline) {
//                         return Polyline(
//                           points: polyline.points,
//                           color: Colors.brown,
//                           strokeWidth: 4.0,
//                         );
//                       }).toList(),
//                     ),
//                     // PolylineLayer(
//                     //   polylines: myGeoJson3Fdr1.polylines.map((polyline) {
//                     //     return Polyline(
//                     //       points: polyline.points,
//                     //       color: Colors.purple,
//                     //       strokeWidth: 4.0,
//                     //       isDotted: true,
//                     //     );
//                     //   }).toList(),
//                     // ),
//                       PolylineLayer(
//   polylines: (myGeoJson3Fdr1.polylines).expand((polyline) {
//     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.green,); // Adjust as necessary
//   }).toList(),
// ),
//  PolylineLayer(
//   polylines: (myGeoJson3Fdr2.polylines).expand((polyline) {
//     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.purple,); // Adjust as necessary
//   }).toList(),
// ),
//  PolylineLayer(
//   polylines: (myGeoJson3Fdr3.polylines).expand((polyline) {
//     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.red,); // Adjust as necessary
//   }).toList(),
// ),
//  PolylineLayer(
//   polylines: (myGeoJson3Fdr4.polylines).expand((polyline) {
//     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, const Color.fromARGB(255, 61, 2, 255)); // Adjust as necessary
//   }).toList(),
// ),
//  PolylineLayer(
//   polylines: (myGeoJson3Fdr5.polylines).expand((polyline) {
//     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.yellow,); // Adjust as necessary
//   }).toList(),
// ),
//  PolylineLayer(
//   polylines: (myGeoJson3Fdr6.polylines).expand((polyline) {
//     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.brown,); // Adjust as necessary
//   }).toList(),
// ),

//                       ///////////layer data/////////////////////////
//                         PolylineLayer(
//                     polylines: myPolylines,
//                     ),
//                     //////////////////////////////////////////////////////

//                     MarkerLayer(markers: _markers), //current position marker
//                     MarkerLayer(markers: _markers1),
//                     MarkerLayer(
//                       markers: _markerSearch,
//                     ),
//                     MarkerLayer(
//                       markers: myGeoJson2.markers.map((marker) {
//                         return Marker(
//                           point: marker.point,
//                           builder: (ctx) => GestureDetector(
//                             onTap: () {
//                               fetchDataAndShowDialog(
//                                 ctx,
//                                 marker.point.longitude,
//                                 marker.point.latitude,
//                               );
//                             },
//                             child: Image.asset(
//                               'assets/period1.png',
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     (MarkerLayer(markers: myMarkers))
//                   ],
//                 ),
//                 Positioned(
//                   top: 20,
//                   left: 20,
//                   right: 15,
//                   height: 45,
//                   child:TypeAheadField<Map<String, dynamic>>(
//   controller: _searchController,

//   builder: (context, controller, focusNode) {
//     return TextField(
//       controller: controller,
//       focusNode: focusNode,
//       decoration: InputDecoration(
//         hintText: 'Search locations...',
//         filled: true,
//         fillColor: Colors.white,
//         prefixIcon: const Icon(Icons.search),
//         suffixIcon: controller.text.isNotEmpty
//             ? IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: () {
//                   controller.clear();
//                   setState(() {
//                     _showedLocationpin = false;
//                   });
//                 },
//               )
//             : null,
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   },

//   suggestionsCallback: _getLocationSuggestions,

//   itemBuilder: (context, suggestion) {
//     return ListTile(
//       leading: const Icon(Icons.location_city),
//       title: Text(
//         suggestion['wmBF_Name'] ??
//             suggestion['name'] ??
//             'Unknown',
//       ),
//       subtitle: Text(
//         "Service: ${suggestion['wmBF_Servi'] ?? ''}\n"
//         "Parcel: ${suggestion['parcelNumber'] ?? ''}",
//       ),
//     );
//   },

//   /// ✅ REQUIRED in v5
//   onSelected: (suggestion) {
//     _currentZoom = 15.0;

//     _searchController.text =
//         suggestion['wmBF_Name'] ??
//         suggestion['name'] ??
//         'Unknown';

//     _updateMapLocation(
//       suggestion['name'] ?? suggestion['wmBF_Servi'] ?? '',
//       // suggestion['geometry'],
//     );

//     setState(() {
//       _showedLocationpin = true;
//     });
//   },
// )),
//                 Positioned(
//                   bottom: 10,
//                   right: 5,
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         onTap: _resetRotation,
//                         child: Transform.rotate(
//                           angle: -_deviceHeading * pi / 180,
//                           child: Image.asset(
//                             'assets/compass.png',
//                             width: 60,
//                             height: 60,
//                           ),
//                         ),
//                       ),
                      
//                       // const SizedBox(height: 10),
//                       GestureDetector(
//                         onTap: _recenterMap,
//                         // mini: true,
//                         // child: Icon(Icons.my_location,
//                         //     color: (driveMode == 0)
//                         //         ? const Color.fromARGB(233, 54, 54, 54)
//                         //         : const Color.fromARGB(233, 46, 99, 168)),
//                          child:(driveMode == 0)?Image.asset(
//                               'assets/location black.png',width: 50,
//                             height: 60,
//                            )
//                            :Image.asset(
//                            'assets/location_blue.png',width: 50,
//                             height: 60,
//                            ),
                      
//                       ),
//                       // const SizedBox(height: 10),
//                       GestureDetector(
//                         onTap: _zoomIn,
//                         // mini: true,
//                         child: 
//                         // const Icon(Icons.zoom_in),
//                         Image.asset(
//     'assets/zoom in v2.png',width: 50,
//                             height: 50,)
//                       ),
//                       // const SizedBox(height: 10),
//                       GestureDetector(
//                         onTap: _zoomOut,
//                         // mini: true,
//                         child: 
//                         // const Icon(Icons.zoom_out),
//                           Image.asset(
//     'assets/zoom out v2.png',width: 50,
//                             height: 50,)
//                       ),
//                          GestureDetector(
//                         onTap: () => _handleFeederTap(context), 
//                         // mini: true,
//                         child: 
//                         // const Icon(Icons.zoom_out),
//                           Image.asset(
//                           'assets/F.png',width: 50,
//                             height: 50,)
//                       ),
//                        GestureDetector(
//                         onTap: () => _handleWorkTap(context), 
//                         // mini: true,
//                         child: 
//                         // const Icon(Icons.zoom_out),
//                           Image.asset(
//                           'assets/W.png',width: 50,
//                             height: 50,)
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Positioned(
//                 //   bottom: 20,
//                 //   left: 20,
//                 //   child: FloatingActionButton(
//                 //     onPressed: _recenterMap,
//                 //     mini: true,
//                 //     child: Icon(Icons.my_location,
//                 //         color: (driveMode == 0)
//                 //             ? Color.fromARGB(233, 54, 54, 54)
//                 //             : Color.fromARGB(233, 46, 99, 168)),
//                 //   ),
//                 // ),
//               ],
//             ),
//     );
//   }

//   Future<void> _recenterMap() async {
//     if (_currentLocation == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Current location not available.")),
//       );
//       return;
//     }
//     setState(() {
//       if (driveMode == 0) {
//         driveMode = 1;
//         // _mapController.move(_currentLocation!, _currentZoom);
//         animatedMapMove(_currentLocation!, _currentZoom);
//       } else {
//         driveMode = 0;
//       }
//     });
//   }

//   Future<void> _addPolygonToMap(List<LatLng> polygonLatLng) async {
//     // print("Adding polygon to map with coordinates: $polygonLatLng");
//     List<List<double>> coordinates = polygonLatLng.map((latLng) {
//       return [
//         latLng.longitude,
//         latLng.latitude
//       ]; // Correct order: [longitude, latitude]
//     }).toList();
//     String geoJsonString = jsonEncode({
//       'type': 'FeatureCollection',
//       'features': [
//         {
//           'type': 'Feature',
//           'geometry': {
//             'type': 'Polygon',
//             'coordinates': [coordinates], // Wrap in another list for GeoJSON
//           },
//           'properties': {}
//         }
//       ]
//     });
//     // myGeoJson.parseGeoJsonAsString(geoJsonString);
//     if (subNumberLocalVariable == '11-COTTON') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });
//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd3_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//            myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });
//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd3_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd4_underground.geojson');

//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/COTTON_consumer.geojson');

//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     //////////////////////////////////////////////frazerBay//////////////////////////////////////////
//      else if (subNumberLocalVariable == '16-FRAZER BAY') {
//       setState(() {
//          myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/FRAZER_BAY_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     //////////////////////////////////vermilion/////////////////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '15-VERMILION') {
//       setState(() {
//           myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd1_overhead.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd2_overhead.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/VERMILION_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     /////////////////////////////Longville//////////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '65-LONGVILLE') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LONGVILLE_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LONGVILLE_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/LONGVILLE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ///////////////////////////////////////orr//////////////////////////////////////////////
//      else if (subNumberLocalVariable == '17-ORR') {
//       setState(() {
//          myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/ORR_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     /////////////////////////////Hill city////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '56-HILL CITY') {
//       setState(() {
//          myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd3_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd3_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/HILL_CITY_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     /////////////////////////////Cook///////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '13-COOK') {
//       setState(() {
//          myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd3_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COOK_frd4_overhead.geojson');
//           final String geoJSONStringOverheadFrd5 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd5_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//         myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFrd5);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd3_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COOK_frd4_underground.geojson');
//           final String geoJSONStringUndergroundFdr5 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd5_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//           myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//            myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/COOK_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ////////////////////////////////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '10-LAKELAND') {
//       setState(() {
//          myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverhead =
//           await rootBundle.loadString('assets/LAKELAND_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverhead);
//       });

//       final String geoJSONStringUnderground =
//           await rootBundle.loadString('assets/LAKELAND_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUnderground);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/LAKELAND_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ///////////////////////////////////shoal lake//////////////////////////////////////////////
//     else if (subNumberLocalVariable == '66-SHOAL LAKE') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd3_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd3_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/SHOAL_LAKE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ///////////////////////////////////Big Sandy//////////////////////////////////////////// 
//     else if (subNumberLocalVariable == '44-BIG SANDY') {
//       setState(() {
//       myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/BIG_SANDY_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     /////////////////////////////////////////////////////////iron//////////////////////////////
//     else if (subNumberLocalVariable == '08-IRON') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });
//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd3_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });
//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd3_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/IRON_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     //////////////////////////////ball club//////////////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '54-BALL CLUB') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd3_overhead.geojson');
//            final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd3_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/BALL_CLUB_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     //////////////////////////Winton-B/////////////////////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '06B-WINTON B') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr5 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd5_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//           myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr5 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd5_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/WINTON_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     /////////////////////////////////////meadowBROOK///////////////////////////////////////////
//     else if (subNumberLocalVariable == '03-MEADOWBROOK') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//         await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd1_overhead.geojson');
//         final String geoJSONStringOverheadFdr2 =
//         await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd2_overhead.geojson');
//         final String geoJSONStringOverheadFdr3 =
//         await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd3_overhead.geojson');
//         final String geoJSONStringOverheadFdr4 =
//         await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//           myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd3_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/MEADOWBROOK_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ///////////////////////////////////pike River/////////////////////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '02-PIKE RIVER') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/PIKE_RIVER_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     //////////////////////////////////side Lake////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '04-SIDE LAKE') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/SIDE_LAKE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     /////////////////////////////////////////round Lake//////////////////////////////////
//      else if (subNumberLocalVariable == '35-ROUND LAKE') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ROUND LAKE_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ROUND LAKE_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//          myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ROUND LAKE_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ROUND LAKE_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//          myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/ROUND_LAKE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ////////////////////////////leakLand B////////////////////////////////////////////
//      else if (subNumberLocalVariable == '19-LAKELAND B') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd4_overhead.geojson');
//           final String geoJSONStringOverheadFdr6 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd6_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//         myGeoJson1fdr6.parseGeoJsonAsString(geoJSONStringOverheadFdr6);
//       });
//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd4_underground.geojson');
//           final String geoJSONStringUndergroundFdr6 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd6_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//         myGeoJson3Fdr6.parseGeoJsonAsString(geoJSONStringUndergroundFdr6);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/LAKELAND B_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ///////////////////////////////Grand Lake//////////////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '34-GRAND LAKE') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });
//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd3_overhead.geojson');
//           final String geoJSONStringOverheadFdr6 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd6_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr6.parseGeoJsonAsString(geoJSONStringOverheadFdr6);
//       });
//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd3_underground.geojson');
//           final String geoJSONStringUndergroundFdr6 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd6_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr6.parseGeoJsonAsString(geoJSONStringUndergroundFdr6);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/GRAND_LAKE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ////////////////////////////solway/////////////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '38-SOLWAY') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd3_overhead.geojson');
//            final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });
//       final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd3_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/SOLWAY_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ///////////////////////////////////////////knife falls////////////////////////////////////////
//     else if (subNumberLocalVariable == '45-KNIFE FALLS') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });
//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KNIFE FALLS_frd1_overhead.geojson');
//          final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KNIFE FALLS_frd2_overhead.geojson');  
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//       });
//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KNIFE FALLS_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KNIFE FALLS_frd2_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/KNIFE_FALLS_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     //////////////////////////cohasset//////////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '55-COHASSET') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd3_overhead.geojson');
//            final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd4_overhead.geojson'); 
//           final String geoJSONStringOverheadFdr5 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd5_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//         myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
//       });

//       final String geoJSONStringUndergroundFdr1  =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2  =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3  =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd3_underground.geojson');
//            final String geoJSONStringUndergroundFdr4  =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd4_underground.geojson');
//            final String geoJSONStringUndergroundFdr5  =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd5_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//         myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/COHASSET_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     //////////////////////////////keewatin///////////////////////////////////
//     else if (subNumberLocalVariable == '05-KEEWATIN') {
//       print('keewatin case');
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/keewatin_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/keewatin_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/keewatin_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/keewatin_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/KEEWATIN_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     //////////////////////////Wright//////////////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '37-WRIGHT') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1  =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2  =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr4  =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/WRIGHT_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ///////////////////////////////////////////kettle River///////////////////////////////////
//     else if (subNumberLocalVariable == '47-KETTLE RIVER') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });
//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd3_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd4_overhead.geojson');
//           final String geoJSONStringOverheadFdr5 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd5_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//         myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
//       });

//       final String geoJSONStringUndergroundFdr1 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd3_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd4_underground.geojson');
//            final String geoJSONStringUndergroundFdr5 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd5_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//             myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/KETTLE_RIVER_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     //////////////////////////////////////////////brandon////////////////////////////////////
//     else if (subNumberLocalVariable == '31-BRANDON') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BRANDON_frd3_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BRANDON_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//          myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BRANDON_frd3_overhead.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BRANDON_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/BRANDON_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     /////////////////////////////////////////////////bergen Lake////////////////////////
//      else if (subNumberLocalVariable == '41-BERGEN LAKE') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });
//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BERGEN LAKE_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BERGEN LAKE_frd2_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//       });
//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BERGEN LAKE_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BERGEN LAKE_frd2_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/BERGEN_LAKE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     /////////////////////////////////////Onigun////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '51-ONIGUM') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/ONIGUM_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ////////////////////////goodland////////////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '61-GOODLAND') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/GOODLAND_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     //////////////////////////////////////////////peary//////////////////////////////////////////////
//     else if (subNumberLocalVariable == '01-PEARY') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/PEARY_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     //////////////////////////////Bena////////////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '60-BENA') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd2_overhead.geojson');
//             final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd3_overhead.geojson');
//             final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//          myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//           myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd3_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/BENA_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ///////////////////////////Winton-A///////////////////////////////////////////////////////////////////// 
//     else if (subNumberLocalVariable == '06A-WINTON A') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_A_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_A_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/WINTON_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ///////////////////////////////////cedar Valley////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '36-CEDAR VALLEY') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });
//       final String geoJSONStringUndergroundFdr1 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/CEDAR_VALLEY_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//      //////////////////////////////////////////Arbo////////////////////////////////////////
//      else if (subNumberLocalVariable == '53-ARBO') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           // await rootBundle.loadString('assets/ARBO_overhead.geojson');
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           // await rootBundle.loadString('assets/ARBO_overhead.geojson');
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           // await rootBundle.loadString('assets/ARBO_overhead.geojson');
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr3_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           // await rootBundle.loadString('assets/ARBO_overhead.geojson');
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr4_overhead.geojson');
          
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr3_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//           myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//             myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//               myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/ARBO_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ///////////////////////////////Cromwell////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '33-CROMWELL') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd3_overhead.geojson');
//            final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });
//       final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd3_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//          myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//           myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/CROMWELL_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     /////////////////////////////////sand lake/////////////////////////////////////////
//      else if (subNumberLocalVariable == '12-SAND LAKE') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd3_overhead.geojson');
//            final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//           myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//             myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//               myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd3_underground.geojson');
//            final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/SAND_LAKE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ///////////////////////////////////////Gowan/////////////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '32-GOWAN') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });
//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//           myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });
//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/GOWAN_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     /////////////////////////////////pokegama//////////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '67-POKEGAMA') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd1_underground.geojson');
//            final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/POKEGAMA_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     //////////////////////////////////////Boy River///////////////////////////////////////
//      else if (subNumberLocalVariable == '52-BOY RIVER') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });
//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd3_overhead.geojson');
          
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
           
//       });
//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd2_underground.geojson');
//  final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd3_underground.geojson');
           
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
       
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/BOY_RIVER_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     //////////////////////////////////////////remer///////////////////////////////////////////////
//     else if (subNumberLocalVariable == '64-REMER') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/REMER_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/REMER_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//             myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/REMER_frd2_underground.geojson');
//            final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/REMER_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/REMER_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     //////////////////////////////Blackberry///////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '58-BLACKBERRY') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/BLACKBERRY_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     /////////////////////////////////////////Gunn///////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '59-GUNN') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd2_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd3_overhead.geojson');
//            final String geoJSONStringOverheadFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd4_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd3_underground.geojson');
//           final String geoJSONStringUndergroundFdr4 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd4_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//       });
//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/GUNN_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     /////////////////////////////////STURGEON LAKE B///////////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '43-STURGEON LAKE B') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr4 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/STURGEON LAKE B_frd4_overhead.geojson');
//           final String geoJSONStringOverheadFdr5 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/STURGEON LAKE B_frd5_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
//          myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
//       });

//       final String geoJSONStringUndergroundFdr4 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/STURGEON LAKE B_frd4_underground.geojson');
//           final String geoJSONStringUndergroundFdr5 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/STURGEON LAKE B_frd5_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
//         myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
//       });

//       final String geoJSONStringConsumer = await rootBundle
//           .loadString('assets/STURGEON_LAKE_B_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ////////////////////////////sturgeon lake////////////////////////////////////////////////
//     else if (subNumberLocalVariable == '39-STURGEONLAKE') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/STURGEONLAKE_frd1_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//       });

//       final String geoJSONStringUndergroundFdr1 = await rootBundle
//           .loadString('assets/geoJson_files_accToFeeder/STURGEONLAKE_frd1_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/STURGEONLAKE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     } 
//     ///////////////////////////////babbit/////////////////////////////////////////////
//     else if (subNumberLocalVariable == '09-BABBITT') {
//       setState(() {
//        myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd1_overhead.geojson');
//           final String geoJSONStringOverheadFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd2_overhead.geojson');
//           final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
//           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr2 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd2_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
//         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/BABBITT_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ///////////////////////////////////Clear Lake/////////////////////////////////////////////////////
//      else if (subNumberLocalVariable == '07-CLEAR LAKE') {
//       setState(() {
//         myGeoJson1fdr1 = GeoJsonParser();
//         myGeoJson1fdr2 = GeoJsonParser();
//         myGeoJson1fdr3 = GeoJsonParser();
//         myGeoJson1fdr4 = GeoJsonParser();
//         myGeoJson1fdr5 = GeoJsonParser();
//         myGeoJson1fdr6 = GeoJsonParser();
//         myGeoJson2 = GeoJsonParser();
//         myGeoJson3Fdr1 = GeoJsonParser();
//         myGeoJson3Fdr2 = GeoJsonParser();
//         myGeoJson3Fdr3 = GeoJsonParser();
//         myGeoJson3Fdr4 = GeoJsonParser();
//         myGeoJson3Fdr5= GeoJsonParser();
//         myGeoJson3Fdr6= GeoJsonParser();
//       });

//       final String geoJSONStringOverheadFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/clearlake_frd1_overhead.geojson');
//            final String geoJSONStringOverheadFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/clearlake_frd3_overhead.geojson');
//       setState(() {
//         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
//          myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
//       });

//       final String geoJSONStringUndergroundFdr1 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/clearlake_frd1_underground.geojson');
//           final String geoJSONStringUndergroundFdr3 =
//           await rootBundle.loadString('assets/geoJson_files_accToFeeder/clearlake_frd3_underground.geojson');
//       setState(() {
//         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
//          myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
//       });

//       final String geoJSONStringConsumer =
//           await rootBundle.loadString('assets/CLEAR_LAKE_consumer.geojson');
//       setState(() {
//         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
//       });
//     }
//     ////////////////////////////////////////////////////////////////////////////////////////////////
//   }

//   Future<List<Map<String, dynamic>>> _getLocationSuggestions(
//       String query) async {
//     try {
//       final url =
//           'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5';
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final results = json.decode(response.body) as List;
//         if (results.isEmpty) {
//           // Call getDataByNameAndAccountNumber if no suggestions
//           final fallbackData = await getDataByNameAndAccountNumber(query);
//           if (fallbackData['getDataByNameAndAccountNumber'] != null) {
//             return List<Map<String, dynamic>>.from(
//                 fallbackData['getDataByNameAndAccountNumber']);
//           }
//           return [];
//         }

//         return results.map((result) {
//           return {
//             'name': result['display_name'],
//             'latitude': result['lat'],
//             'longitude': result['lon']
//           };
//         }).toList();
//       } else {
//         final fallbackData = await getDataByNameAndAccountNumber(query);
//         if (fallbackData['getDataByNameAndAccountNumber'] != null) {
//           return List<Map<String, dynamic>>.from(
//               fallbackData['getDataByNameAndAccountNumber']);
//         }
//         return [];
//       }
//     } catch (e) {
//       print("Error fetching location suggestions: $e");
//       return [];
//     }
//   }

//   // Update map location based on the selected suggestion
//   Future<void> _updateMapLocation(String suggestion) async {
//     try {
//       final url =
//           'https://nominatim.openstreetmap.org/search?q=$suggestion&format=json&limit=1';
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final results = json.decode(response.body) as List;
//         if (results.isNotEmpty) {
//           final location = results.first;
//           final newLocation = LatLng(
//             double.parse(location['lat']),
//             double.parse(location['lon']),
//           );

//           // setState(() {
//           //   _currentLocation = newLocation;
//           // });
//           // _mapController.move(
//           //     newLocation, _currentZoom); // Center the map on the location

//           setState(() {
//             _currentLocation = newLocation;
//             _markerSearch = [
//               Marker(
//                 point: newLocation,
//                 builder: (ctx) => const Icon(
//                   Icons.location_on,
//                   color: Colors.red,
//                   size: 40.0,
//                 ),
//               ),
//             ];
//           });
//           _mapController.move(newLocation, _currentZoom);
//         }
//       }
//     } catch (e) {
//       // print("Error updating map location: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error locating address')),
//       );
//     }
//   }

//   Future<List<dynamic>?> fetchDataByLatLong(
//       double latitude, double longitude) async {
//     const String baseUrl =
//         'https://civmapi.ariespro.com/civmapi/supervisorLoginPanel/getDataByLatitudeLongitude';
//     final Uri url =
//         Uri.parse('$baseUrl?latitude=$latitude&longitude=$longitude');
//     print(url);
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     try {
//       final http.Response response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer ${data.token!}',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData['getDataByLatitudeLongitude'] is List) {
//           return jsonData['getDataByLatitudeLongitude'];
//         } else {
//           print('Unexpected response structure: ${response.body}');
//           return null;
//         }
//       } else {
//         print('Failed to fetch data: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//       return null;
//     }
//   }

//   Future<void> fetchDataAndShowDialog(
//       BuildContext ctx, double latitude, double longitude) async {
//            showDialog(
//     context: ctx,
//     barrierDismissible: false, // Prevent dismissing while loading
//     builder: (context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16), // Rounded corners
//         ),
//         content: const SizedBox(
//           height: 120,
//           child: Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(
//                   color: Colors.blue, // Customize color
//                   strokeWidth: 4, // Thicker stroke
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   "Fetching Data...",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
//     final data = await fetchDataByLatLong(latitude, longitude);
//      Navigator.pop(ctx);
//     if (data != null && data.isNotEmpty) {
//       showDialog(
//         context: ctx,
//         builder: (context) {
//           return AlertDialog(
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Customer Name : ',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     children: [
//                       TextSpan(
//                         text: data[0]['wmBF_Name'] ?? "NA",
//                         style: const TextStyle(fontWeight: FontWeight.normal),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Address : ',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     children: [
//                       TextSpan(
//                         text: data[0]['wmBF_Ser_2'] ?? "NA",
//                         style: const TextStyle(fontWeight: FontWeight.normal),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     if (data[0]['wmBF_Phone'] != '' &&
//                         data[0]['wmBF_Phone'] != null)
//                       setState(() {
//                         _launched = _makePhoneCall(data[0]['wmBF_Phone']);
//                       });
//                   },
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'Phone Number : ',
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.blue),
//                       children: [
//                         TextSpan(
//                           text: data[0]['wmBF_Phone'] ?? "NA",
//                           style: const TextStyle(fontWeight: FontWeight.normal),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Phase : ',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     children: [
//                       TextSpan(
//                         text: data[0]['wmPhasing'] ?? "NA",
//                         style: const TextStyle(fontWeight: FontWeight.normal),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Map Location No : ',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     children: [
//                       TextSpan(
//                         text: data[0]['wmElementN'] ?? "NA",
//                         style: const TextStyle(fontWeight: FontWeight.normal),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Parcel : ',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     children: [
//                       TextSpan(
//                         text: data[0]['parcelNumber'] ?? "NA",
//                         style: const TextStyle(fontWeight: FontWeight.normal),
//                       ),
//                     ],
//                   ),
//                 ),
//                  const SizedBox(
//                   height: 8,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Comment : ',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     children: [
//                       TextSpan(
//                         text: data[0]['comment'] ?? "NA",
//                         style: const TextStyle(fontWeight: FontWeight.normal),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('Close'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       _showSnackBar('No data available');
//     }
//   }

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }

//   Future<dynamic> getDataByNameAndAccountNumber(String accOrName) async {
//     //102114900
//     print('inside getDataByNameAndAccountNumber');
//     const String endpoint =
//         "https://civmapi.ariespro.com/civmapi/supervisorLoginPanel/getDataByNameAndAccountNumber";
//     final Uri url = Uri.parse("$endpoint?accOrName=$accOrName");
//     print('inside getDataByNameAndAccountNumber');
//     print(url);
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     final headers = {'Authorization': 'Bearer ${data.token!}'};

//     try {
//       final response = await http.get(url, headers: headers);

//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print('data: $data');
//         return data;
//       } else {
//         print(
//             'Error: Status code ${response.statusCode}, Body: ${response.body}');
//         return {
//           "error":
//               "Failed to load data. Status code: ${response.statusCode}, Body: ${response.body}"
//         };
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       return {"error": "An error occurred: $e"};
//     }
//   }
//    double haversineDistance(LatLng start, LatLng end) {
//   const R = 6371e3; // Earth's radius in meters
//   final lat1 = start.latitude * pi / 180;
//   final lat2 = end.latitude * pi / 180;
//   final deltaLat = (end.latitude - start.latitude) * pi / 180;
//   final deltaLon = (end.longitude - start.longitude) * pi / 180;

//   final a = sin(deltaLat / 2) * sin(deltaLat / 2) +
//       cos(lat1) * cos(lat2) * sin(deltaLon / 2) * sin(deltaLon / 2);
//   final c = 2 * atan2(sqrt(a), sqrt(1 - a));

//   return R * c; // Distance in meters
// }


// List<LatLng> createSegment(LatLng start, LatLng end, double fraction) {
//   return [
//     LatLng(
//       start.latitude + (end.latitude - start.latitude) * fraction,
//       start.longitude + (end.longitude - start.longitude) * fraction,
//     ),
//   ];
// }

// List<Polyline> createDashedLine(LatLng start, LatLng end, double dashLength, Color passedColor, ) {
//   List<Polyline> dashedLine = [];
//   double totalDistance = haversineDistance(start, end);
//   int dashCount = (totalDistance / dashLength).floor();

//   for (int i = 0; i < dashCount; i++) {
//     double startFraction = (i * dashLength) / totalDistance;
//     double endFraction = ((i + 1) * dashLength) / totalDistance;

//     if (i % 2 == 0) {
//       // Create visible segments
//       dashedLine.add(
//         Polyline(
//           points: [
//             createSegment(start, end, startFraction)[0],
//             createSegment(start, end, endFraction)[0],
//           ],
//           color: passedColor,
//           strokeWidth: 4.0,
//         ),
//       );
//     }
//   }
//   return dashedLine;
// }






// Future<String?> _showFeederColorDialog(BuildContext context) async {
//   Map<String, Color> colorMap = {
//     "FDR1": const Color.fromARGB(255, 1, 127, 5),
//     "FDR2": const Color.fromARGB(255, 96, 0, 113),
//     "FDR3": const Color.fromARGB(255, 247, 19, 2),
//     "FDR4": const Color.fromARGB(255, 38, 1, 247),
//     "FDR5": Colors.yellow,
//     "FDR6": const Color.fromARGB(255, 113, 68, 1),
//   };

//   return showDialog<String>(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Color Feeder"), // Title
//             IconButton(
//               icon: const Icon(Icons.close, color: Colors.red),
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//             ),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: colorMap.entries.map((entry) {
//             return ListTile(
//               leading: Container(
//                 width: 60,
//                 height: 8, 
//                 decoration: BoxDecoration(
//                   color: entry.value,
//                   borderRadius: BorderRadius.circular(1),
//                 ),
//               ),
//               title: Text(entry.key.toUpperCase()),
//               onTap: () {
//                 Navigator.pop(context, entry.key); // Return the selected color
//               },
//             );
//           }).toList(),
//         ),
//       );
//     },
//   );
// }
// void _handleFeederTap(BuildContext context) async {
//   String? selectedColor = await _showFeederColorDialog(context);
//   if (selectedColor != null) {
//     print("Selected color: $selectedColor");
//   }
// }

// Future<String?> _showWorkColorDialog(BuildContext context) async {
//   Map<String, Color> colorMap = {
//     "Jaraff": const Color.fromARGB(255, 96, 0, 113),
//     "Mowing": const Color.fromARGB(255, 113, 68, 1),
//     "Mini Jaraff": const Color.fromARGB(255, 247, 19, 2),
//     "BYL": const Color.fromARGB(255, 2, 212, 249), 
//     "Bucket": Colors.orange,
//     "Ground": Colors.yellow,
//     "Cross-country spray": const Color.fromARGB(255, 38, 1, 247),
//     "Roadside spray": const Color.fromARGB(255, 1, 127, 5),
//     "No spray":const Color.fromARGB(255, 252, 199, 249),
//   };

//   return showDialog<String>(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//        title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Color Work"), // Title
//             IconButton(
//               icon: const Icon(Icons.close, color: Colors.red),
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//             ),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: colorMap.entries.map((entry) {
//             return ListTile(
//               leading: Container(
//                 width: 60,
//                 height: 8, 
//                 decoration: BoxDecoration(
//                   color: entry.value,
//                   borderRadius: BorderRadius.circular(1),
//                 ),
//               ),
//               title: Text(entry.key.toUpperCase()),
//               onTap: () {
//                 Navigator.pop(context, entry.key); // Return the selected color
//               },
//             );
//           }).toList(),
//         ),
//       );
//     },
//   );
// }
// void _handleWorkTap(BuildContext context) async {
//   String? selectedColor = await _showWorkColorDialog(context);
//   if (selectedColor != null) {
//     print("Selected color: $selectedColor");
//   }
// }



// Future<void> getMapLinesBySubstation(BuildContext context, String substationName) async {
//   final String url =
//       'https://civmapi.ariespro.com/civmapi/supervisorLoginPanel/getMapLinesBySubstationAndType?substationName=$substationName';
//   final userPreferences = Provider.of<UserPref>(context, listen: false);
//   UserModel data = await userPreferences.getUser();
//   print('Fetching map lines from URL: $url');
//   try {
//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         "Authorization": 'Bearer ${data.token!}',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       print("API Response: $jsonData");

//       if (jsonData == null || !jsonData.containsKey('data') || jsonData['data'] == null) {
//         print("Error: 'data' key is missing or null in API response.");
//         return;
//       }
//       // Extract all line categories (MidCycle, ChangeOrder, IVM)
//       List allLines = [
//         ...?jsonData['data']['MidCycleMapLines'],
//         ...?jsonData['data']['ChangeOrderMapLines'],
//         ...?jsonData['data']['IVMMapLines']
//       ];
//       if (allLines.isEmpty) {
//         print("Warning: No map lines available for this substation.");
//         return;
//       }
//       List<Map<String, dynamic>> parsedLines = [];
//       List<LatLng> memberPoints = [];

//       for (var feature in allLines) {
//         if (feature is Map<String, dynamic> && feature.containsKey('geometry')) {
//           String geometry = feature['geometry'];
//           String color = feature.containsKey('color') ? feature['color'] : "black"; // Default color

//           if (geometry.startsWith("LINESTRING")) {
//             List<LatLng> line = _parseLineString(geometry);
//             if (line.isNotEmpty) {
//               parsedLines.add({
//                 "coordinates": line,
//                 "color": _getColorFromString(color), // Convert color string to Color object
//               });
//             }
//           }
//         }
//       }
//        // Parse MemberData (POINT)
//       if (jsonData['data'].containsKey('MemberData') && jsonData['data']['MemberData'] is List) {
//         for (String point in jsonData['data']['MemberData']) {
//           LatLng? latLng = _parsePoint(point);
//           if (latLng != null) {
//             memberPoints.add(latLng);
//           }
//         }
//       }
//       if (parsedLines.isNotEmpty) {
//         print("✅ Calling _plotLayersOnMap()");
//         _plotLayersOnMap(parsedLines, memberPoints);
//       } else {
//         print("⚠️ No data to plot!");
//       }
//     } else {
//       print('Failed to load layers data from API: ${response.statusCode} - ${response.body}');
//     }
//   } catch (e) {
//     print('Error in loading layers data: $e');
//   }
// }

// Color _getColorFromString(String colorName) {
//   Map<String, Color> colorMap = {
//     "red": const Color.fromARGB(255, 247, 19, 2),
//     "blue": const Color.fromARGB(255, 38, 1, 247),
//     "green":  const Color.fromARGB(255, 1, 127, 5),
//     "yellow": Colors.yellow,
//     "purple": const Color.fromARGB(255, 96, 0, 113),
//     "orange": Colors.orange,
//     "skyblue": const Color.fromARGB(255, 2, 212, 249), // Custom color
//     "black": Colors.black,
//   };
//   return colorMap[colorName.toLowerCase()] ?? Colors.black; // Default to black if not found
// }

// List<LatLng> _parseLineString(String lineString) {
//   String cleanString = lineString.replaceAll("LINESTRING (", "").replaceAll(")", "");
//   List<LatLng> coordinates = [];
//   List<String> pairs = cleanString.split(", ");
//   for (var pair in pairs) {
//     List<String> values = pair.split(" ");
//     if (values.length == 2) {
//       double lon = double.parse(values[0]); // Longitude
//       double lat = double.parse(values[1]); // Latitude
//       coordinates.add(LatLng(lat, lon));
//     }
//   }
//   print("Parsed LINESTRING: $coordinates");
//   return coordinates;
// }

// void _plotLayersOnMap(List<Map<String, dynamic>> linesWithColors,  List<LatLng> memberPoints) {
//   List<Polyline> polylines = [];
//   List<Marker> markers = [];

//   for (var lineData in linesWithColors) {
//     List<LatLng> line = lineData["coordinates"];
//     Color lineColor = lineData["color"];
//     polylines.add(Polyline(
//       points: line,
//       color: lineColor,
//       strokeWidth: 8.0,
//     ));
//   }
//   for (LatLng point in memberPoints) {
//   markers.add(
//     Marker(
//       point: point,
//       width: 40, // Marker size
//       height: 40,
//      builder: (context) => InkWell(
//       onTap: () {
//         fetchDataAndShowDialog(
//                                 context,
//                                 point.longitude,
//                                 point.latitude,
//                               );
//       },
//        child: Image.asset(
//           'assets/caution_icon.png', // Replace with your image path
//           width: 10,
//           height: 10,
//         ),
//      ),)
//   );
// }

//   setState(() {
//     myPolylines = polylines;
//     myMarkers = markers;
//   });
// }

// LatLng? _parsePoint(String pointString) {
//   try {
//     String cleanString = pointString.replaceAll("POINT (", "").replaceAll(")", "");
//     List<String> values = cleanString.split(" ");
//     if (values.length == 2) {
//       double lon = double.parse(values[0]);
//       double lat = double.parse(values[1]);
//       return LatLng(lat, lon);
//     }
//   } catch (e) {
//     print("Error parsing POINT: $pointString - $e");
//   }
//   return null;
// }

// void animatedMapMove(LatLng destLocation, double destZoom) {
//   final latTween = Tween<double>(
//     begin: _mapController.center.latitude,
//     end: destLocation.latitude,
//   );

//   final lngTween = Tween<double>(
//     begin: _mapController.center.longitude,
//     end: destLocation.longitude,
//   );

//   final zoomTween = Tween<double>(
//     begin: _mapController.zoom,
//     end: destZoom,
//   );

//   var controller = AnimationController(
//     duration: const Duration(milliseconds: 1000), // adjust speed
//     vsync: this, // your State must with TickerProviderStateMixin
//   );

//   var animation = CurvedAnimation(
//     parent: controller,
//     curve: Curves.easeInOut,
//   );

//   controller.addListener(() {
//     _mapController.move(
//       LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
//       zoomTween.evaluate(animation),
//     );
//   });

//   controller.addStatusListener((status) {
//     if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
//       controller.dispose();
//     }
//   });

//   controller.forward();
// }

//   void animateMarkerMove(LatLng from, LatLng to) {
//   final latTween = Tween<double>(begin: from.latitude, end: to.latitude);
//   final lngTween = Tween<double>(begin: from.longitude, end: to.longitude);

//   var controller = AnimationController(
//     duration: const Duration(milliseconds: 800), // adjust for smoothness
//     vsync: this,
//   );

//   var animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

//   controller.addListener(() {
//     setState(() {
//       _currentLocation = LatLng(
//         latTween.evaluate(animation),
//         lngTween.evaluate(animation),
//       );
//       _updateMarker(); // keep marker synced
//     });
//   });

//   controller.addStatusListener((status) {
//     if (status == AnimationStatus.completed) controller.dispose();
//   });

//   controller.forward();
// }

// }
// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:math';
// // import 'package:CIVM/models/user_model.dart';
// // import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
// // import 'package:CIVM/utils/geojson_parser.dart';
// // import 'package:CIVM/utils/user_pref.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_compass/flutter_compass.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:flutter_map/plugin_api.dart';
// // import 'package:flutter_typeahead/flutter_typeahead.dart';
// // import 'package:geojson/geojson.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:latlong2/latlong.dart';
// // import 'package:flutter/services.dart' show rootBundle;
// // import 'package:provider/provider.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:wakelock_plus/wakelock_plus.dart';
// // import 'package:http/http.dart' as http;

// // class MapScreenLeafLat1 extends StatefulWidget {
// //   const MapScreenLeafLat1({Key? key}) : super(key: key);

// //   @override
// //   _MapScreenLeafLat1State createState() => _MapScreenLeafLat1State();
// // }

// // class _MapScreenLeafLat1State extends State<MapScreenLeafLat1>
// //     with TickerProviderStateMixin {
// //   late final MapController _mapController;
// //   double _currentZoom = 17.0;
// //   LatLng? _currentLocation;
// //   LatLng? newLocation;
// //   List<Marker> _markers = [];
// //   List<Marker> _markers1 = [];
// //   List<Marker> _markerSearch = [];
// //   double _deviceHeading = 0.0;
// //   int driveMode = 0;

// //   // Marker move
// //   int numDeltas = 100; //number of delta to devide total distance
// //   int delay = 10; //milliseconds of delay to pass each delta
// //   var i = 0;
// //   double? deltaLat;
// //   double? deltaLng;
// //   var position; //position variable while moving marker

// //   List<String> subNumbers = [];
// //   List<GeoJsonFeature> features = [];

// //   GeoJsonParser myGeoJson = GeoJsonParser();

// //   GeoJsonParser myGeoJson1fdr1 = GeoJsonParser();
// //   GeoJsonParser myGeoJson1fdr2 = GeoJsonParser();
// //   GeoJsonParser myGeoJson1fdr3 = GeoJsonParser();
// //   GeoJsonParser myGeoJson1fdr4 = GeoJsonParser();
// //   GeoJsonParser myGeoJson1fdr5 = GeoJsonParser();
// //   GeoJsonParser myGeoJson1fdr6 = GeoJsonParser();

// //   GeoJsonParser myGeoJson2 = GeoJsonParser();

// //   GeoJsonParser myGeoJson3Fdr1 = GeoJsonParser();
// //   GeoJsonParser myGeoJson3Fdr2 = GeoJsonParser();
// //   GeoJsonParser myGeoJson3Fdr3 = GeoJsonParser();
// //   GeoJsonParser myGeoJson3Fdr4 = GeoJsonParser();
// //   GeoJsonParser myGeoJson3Fdr5 = GeoJsonParser();
// //   GeoJsonParser myGeoJson3Fdr6 = GeoJsonParser();

// //   /////////layers data///////////////
// //    GeoJsonParser myGeoJsonLayerData = GeoJsonParser();

// //   late StreamSubscription<Position> _positionStreamSubscription;

// //   // ignore: prefer_typing_uninitialized_variables
// //   var subNumberLocalVariable;

// //   String? lastSubNumber;
// //   final TextEditingController _searchController = TextEditingController();
// //   bool _showedLocationpin = false;

// //   Map<String, dynamic>? consumerData;

// //   Future<void>? _launched;
// //   List<Polyline> myPolylines = [];
// //   List<Marker>myMarkers = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _mapController = MapController();
// //     _initializeMap();
// //     _addLabelMarker();
// //     _startListeningToCompass();
// //     // fetchDataByLatLong(-92.4764153135444, 48.341346233286);
// //     WakelockPlus.enable();
// //   }

// //   Future<void> _initializeMap() async {
// //     await _getCurrentLocation();
// //     _listenToLocationUpdates();
// //     _loadGeoJSONBoundary();
// //     //earlier it was called from here
// //     /////////////////////////////////////////
// //     // _loadGeoJSON1();
// //     // _loadGeoJSON2();
// //     // _loadGeoJSON3();
// //     // await _loadGeoJSON();
// //   }

// //   void _startListeningToCompass() {
// //     // print("_startListeningToCompass called");
// //     FlutterCompass.events?.listen((CompassEvent event) {
// //       setState(() {
// //         _deviceHeading = event.heading ?? 0.0;
// //         if (driveMode == 1) {
// //           _mapController.rotate(-_deviceHeading);
// //         }
// //       });
// //     });
// //   }

// //   Future<void> _loadGeoJSONBoundary() async {
// //     final String geoJSONStringBoundary =
// //         await rootBundle.loadString('assets/sub_boundary_without_chd.geojson');
// //     // final String geoJSONStringBoundary =
// //     //     await rootBundle.loadString('assets/sub_boundary_with_chd1.geojson');
// //     setState(() {
// //       myGeoJson.parseGeoJsonAsString(geoJSONStringBoundary);
// //     });
// //   }

// //   Future<void> _loadGeoJSON() async {
// //     // print("_loadGeoJSON called");
// //     try {
// //       final String geoJSONString = await rootBundle
// //           .loadString('assets/sub_boundary_without_chd.geojson');
// //       // final String geoJSONString =
// //       //     await rootBundle.loadString('assets/sub_boundary_with_chd1.geojson');

// //       // Create a GeoJson object and parse the string
// //       final geoJson = GeoJson();
// //       await geoJson.parse(geoJSONString); // Parse GeoJSON

// //       if (geoJson.features.isNotEmpty) {
// //         // print("GeoJSON successfully parsed.");
// //         // print("Features loaded: ${geoJson.features.length}");
// //         // print("GeoJSON features: ${geoJson.features}");

// //         // List<LatLng> currentLocationList=[];

// //         // LatLng currentLocation0 = LatLng(47.88055437960927, -92.48728531369036); //Frazer Bay
// //         // LatLng currentLocation1 = LatLng(47.83444818680236, -92.34369812225371); //Vermillion
// //         // LatLng currentLocation2 = LatLng(47.04895013622139, -94.15842678612894); //Longville
// //         // LatLng currentLocation3 = LatLng(48.211236867475584, -92.49458100593375); //Orr
// //         // LatLng currentLocation4 = LatLng(46.969032111544934, -93.64780626065327); //Hill City
// //         // LatLng currentLocation5 = LatLng(47.977607951048675, -92.52900686415383); //Cook
// //         // LatLng currentLocation6 = LatLng(47.79918727655814, -92.65972091716121); //Potlatch
// //         // LatLng currentLocation7 = LatLng(47.40769249081645, -92.3730271124764); //Lakeland
// //         // LatLng currentLocation8 = LatLng(47.492748857513604, -93.2708576030474); //Shoal Lake
// //         // LatLng currentLocation9 = LatLng(46.81626410896614, -93.28371047055131); //Big Sandy
// //         // LatLng currentLocation10 = LatLng(47.43972458621422, -92.71564507512474); //Iron
// //         // LatLng currentLocation11 = LatLng(47.39488658263989, -93.98741836831131); //Ball Club
// //         // LatLng currentLocation12 = LatLng(47.98363280627945, -91.68760141011201); //Winton B
// //         // LatLng currentLocation13 = LatLng(47.91096039966965, -93.07470621389601); //Meadowbrook
// //         // LatLng currentLocation14 = LatLng(47.64989335670572, -92.3966821231562); //Pike River
// //         // LatLng currentLocation15 = LatLng(47.63389411798467, -92.99819923063122); //Side Lake
// //         // LatLng currentLocation16 = LatLng(46.69849637697413, -93.24548480032941); //Round Lake
// //         // LatLng currentLocation17 = LatLng(47.4127302161937, -92.09536306158428); //Lakeland B
// //         // LatLng currentLocation18 = LatLng(46.89888854118592, -92.50231191793529); //Grand Lake
// //         // LatLng currentLocation19 = LatLng(46.864062735932201,-92.291461947348395); //Solway
// //         // LatLng currentLocation20 = LatLng( 46.713503158065699, -92.366048900649304); //Knife Falls
// //         // LatLng currentLocation21 = LatLng(47.23455517178613, -93.71686954166097); //Cohasset
// //         // LatLng currentLocation22 = LatLng(47.32706962122148, -92.93774163937496); //Keewatin
// //         // LatLng currentLocation23 = LatLng(46.67817817347821, -93.12612268485078); //Wright
// //         // LatLng currentLocation24 = LatLng(46.50343933751238, -92.91267414007538); //Kettle River
// //         // LatLng currentLocation25 = LatLng(46.80377825632088, -92.66268869892734); //Brandon
// //         // LatLng currentLocation26 = LatLng(46.97700021150396, -92.32579962868962); //Bergen Lake
// //         // LatLng currentLocation27 = LatLng(47.077920977138376, -94.41341405316115); //Onigum
// //         // LatLng currentLocation28 = LatLng(47.211334651716776, -93.13431933460436); //Goodland
// //         // LatLng currentLocation29 = LatLng(47.31437233102813, -92.56485698362752); //Peary
// //         // LatLng currentLocation30 = LatLng(47.29717511053933, -94.3315808579297); //Bena
// //         // LatLng currentLocation31 = LatLng(47.802917995897076, -91.73650419058164); //WINTON A
// //         LatLng currentLocation32 = LatLng(47.08005321167195, -93.00535771569302); //Cedar Valley
// //         // LatLng currentLocation33 = LatLng(47.38460982760358, -93.56694948594011); //Arbo
// //         // LatLng currentLocation34 = LatLng(46.636512714544899,-92.924437582926004, ); //Cromwell
// //         // LatLng currentLocation35 = LatLng(47.67404076013045, -92.67090460249017); //Sand Lake
// //         LatLng currentLocation36 = LatLng(46.87071246305832, -92.90291263872044); //Gowan
// //         // LatLng currentLocation37 = LatLng(47.08565240431225, -93.50683407362655); //Pokegama
// //         // LatLng currentLocation38 = LatLng(47.18631923726539, -94.10334942148874); //Boy River
// //         // LatLng currentLocation39 = LatLng(47.074952567038494, -93.88040845887213); //Remer
// //         // LatLng currentLocation40 = LatLng(47.16578808127717, -93.33253422767572); //Blackberry
// //         // LatLng currentLocation41 = LatLng(47.21834115867768, -93.44958363295417); //Gunn
// //         // LatLng currentLocation42 = LatLng(46.41012814573855, -92.640567427713); //Sturgeon Lake B
// //         // LatLng currentLocation43 = LatLng(46.36308718663967, -92.7272002780472); //Sturgeon Lake
// //         // LatLng currentLocation44 = LatLng(47.71093495958199, -92.06803765316182); //Babbitt
// //         // LatLng currentLocation45 = LatLng(47.85575630331953, -92.09752489509043); //Clear Lake
// //         // LatLng currentLocation46 = LatLng(47.119817653350204, -92.45542845134987); //Cotton

// //         // currentLocationList.add(currentLocation0);
// //         // currentLocationList.add(currentLocation1);
// //         // currentLocationList.add(currentLocation2);
// //         // currentLocationList.add(currentLocation3);
// //         // currentLocationList.add(currentLocation4);
// //         // currentLocationList.add(currentLocation5);
// //         // currentLocationList.add(currentLocation6);
// //         // currentLocationList.add(currentLocation7);
// //         // currentLocationList.add(currentLocation8);
// //         // currentLocationList.add(currentLocation9);
// //         // currentLocationList.add(currentLocation10);
// //         // currentLocationList.add(currentLocation11);
// //         // currentLocationList.add(currentLocation12);
// //         // currentLocationList.add(currentLocation13);
// //         // currentLocationList.add(currentLocation14);
// //         // currentLocationList.add(currentLocation15);
// //         // currentLocationList.add(currentLocation16);
// //         // currentLocationList.add(currentLocation17);
// //         // currentLocationList.add(currentLocation18);
// //         // currentLocationList.add(currentLocation19);
// //         // currentLocationList.add(currentLocation20);
// //         // currentLocationList.add(currentLocation21);
// //         // currentLocationList.add(currentLocation22);
// //         // currentLocationList.add(currentLocation23);
// //         // currentLocationList.add(currentLocation24);
// //         // currentLocationList.add(currentLocation25);
// //         // currentLocationList.add(currentLocation26);
// //         // currentLocationList.add(currentLocation27);
// //         // currentLocationList.add(currentLocation28);
// //         // currentLocationList.add(currentLocation29);
// //         // currentLocationList.add(currentLocation30);
// //         // currentLocationList.add(currentLocation31);
// //         // currentLocationList.add(currentLocation32);
// //         // currentLocationList.add(currentLocation33);
// //         // currentLocationList.add(currentLocation34);
// //         // currentLocationList.add(currentLocation35);
// //         // currentLocationList.add(currentLocation36);
// //         // currentLocationList.add(currentLocation37);
// //         // currentLocationList.add(currentLocation38);
// //         // currentLocationList.add(currentLocation39);
// //         // currentLocationList.add(currentLocation40);
// //         // currentLocationList.add(currentLocation41);
// //         // currentLocationList.add(currentLocation42);
// //         // currentLocationList.add(currentLocation43);
// //         // currentLocationList.add(currentLocation44);
// //         // currentLocationList.add(currentLocation45);
// //         // currentLocationList.add(currentLocation46);
// //         // Random r=Random();
// //         // _parseSubNumbers(geoJson.features, currentLocationList[r.nextInt(47)]); // Pass features directly
// //         // var currentLocationTemp = LatLng(46.50343933751238, -92.91267414007538);
// //         ///////////////////////////////////////////////////////////////////////
// //         // var currentLocationTemp = LatLng( 47.289840451050097 , -93.502918922918695);//arbo
// //         //  var currentLocationTemp = LatLng( 47.862693654625701 ,-92.6937729117613);//cook  
// //         // var currentLocationTemp = LatLng( 47.371520919049303 ,-92.922107081795602); //keewaitin
// //         // var currentLocationTemp = LatLng( 47.941145481628901 ,-92.848821994884602); //meadowBrook
// //         // var currentLocationTemp = LatLng( 48.263433999999897 ,-92.487853);  //Orr
// //         // var currentLocationTemp = LatLng( 47.591574595476303 ,-92.946160387670105);  //sideLake
// //         // var currentLocationTemp = LatLng( 47.660320000009499 ,-92.245978999999807); //Babbit 
// //         // var currentLocationTemp = LatLng( 47.843758946735697,-92.194639986990495); //ClearLake
// //         //  var currentLocationTemp = LatLng(47.864818684664201, -92.461866900374503); //FrazerBay
// //         //  var currentLocationTemp = LatLng(47.618507000009501, -92.523354999999896); //pikeRiver
// //         //  var currentLocationTemp = LatLng( 47.660738834226301, -92.641566258311201); //pikeRiver
         
// //         _parseSubNumbers(geoJson.features, currentLocation36);
// //         // _parseSubNumbers(geoJson.features, _currentLocation!);
// //       } else {
// //         print("Failed to parse GeoJSON: No features found.");
// //       }
// //     } catch (e) {
// //       print("Error loading GeoJSON: $e");
// //     }
// //   }

// //   void _parseSubNumbers(
// //       List<GeoJsonFeature> geoJsonFeatures, LatLng currentLocation) {
// //     // print('location update called...........');
// //     // print('_currentLocation $currentLocation');
// //     if (geoJsonFeatures.isEmpty) {
// //       print("No features to parse.");
// //       return;
// //     }

// //     for (var feature in geoJsonFeatures) {
// //       // print("Feature properties: ${feature.properties}");
// //       // print("Feature geometry: ${feature.geometry}");
// //       if (feature.geometry != null && feature.geometry is GeoJsonMultiPolygon) {
// //         var multiPolygon = feature.geometry as GeoJsonMultiPolygon;

// //         // Loop through each polygon in the multiPolygon
// //         for (var polygon in multiPolygon.polygons) {
// //           var coordinates;
// //           if (polygon.geoSeries != null && polygon.geoSeries.isNotEmpty) {
// //             // Extract the geoPoints from the first geoSeries (assuming each geoSeries has multiple points)
// //             coordinates = polygon
// //                 .geoSeries[0].geoPoints; // This is a list of GeoPoint objects
// //           }
// //           if (coordinates != null) {
// //             // Convert the coordinates to LatLng using the latitude and longitude properties of GeoPoint
// //             List<LatLng> polygonLatLng = coordinates.map<LatLng>((point) {
// //               return LatLng(
// //                   point.latitude,
// //                   point
// //                       .longitude); // GeoPoint has latitude and longitude directly
// //             }).toList();

// //             // Check if the current location is inside this polygon
// //             if (_isPointInPolygon(currentLocation, polygonLatLng)) {
// //               var currentSubNumber = feature.properties!['UplineSour'];
// //               if (currentSubNumber != lastSubNumber) {
// //                 // print("Current location is in Substation: $currentSubNumber");
// //                 subNumberLocalVariable = currentSubNumber;
// //                 // print('subNumberLocalVariable: $subNumberLocalVariable');
// //                 _addPolygonToMap(
// //                     polygonLatLng); // Add polygon only if SubNumber is new
// //                 lastSubNumber =
// //                     currentSubNumber; // Update last processed SubNumber

// //                     String extractedName = currentSubNumber.replaceAll(RegExp(r'^\d+-\s*'), '');
// //                     print("Substation NameOnlyName: $extractedName");
// //                     getMapLinesBySubstation(context,extractedName);

// //               } else {
// //                 print("SubNumber $currentSubNumber is the same as before.");
// //               }
// //             } else {
// //               // print(
// //               //     "Your current loaction is not in any of the Substations00000");
// //               const SnackBar(
// //                   content: Text(
// //                       "Your current loaction is not in any of the Substations"));
// //             }
// //           }
// //         }
// //       } else {
// //         print("Unsupported geometry type: ${feature.geometry.runtimeType}");
// //       }
// //     }
// //   }

// //   Future<void> _getCurrentLocation() async {
// //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       _showSnackBar("Location services are disabled.");
// //       // return;
// //     }

// //     LocationPermission permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         _showSnackBar("Location permissions are denied.");
// //         return;
// //       }
// //     }

// //     if (permission == LocationPermission.deniedForever) {
// //       _showSnackBar("Location permissions are permanently denied.");
// //       return;
// //     }

// //     Position position1 = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high);

// //     setState(() {
// //       position = [position1.latitude, position1.longitude];
// //       _currentLocation = LatLng(position1.latitude, position1.longitude);
// //       _updateMarker();
// //       _checkIfLocationInsidePolygon();
// //     });
// //   }

// //   void _addLabelMarker() {
// //     _markers1 = [
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.88055437960927, -92.48728531369036),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Frazer_Bay.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.83444818680236, -92.34369812225371),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Vermillion.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.04895013622139, -94.15842678612894),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Longville.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(48.211236867475584, -92.49458100593375),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Orr.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.969032111544934, -93.64780626065327),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Hill_City.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.977607951048675, -92.52900686415383),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Cook.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.79918727655814, -92.65972091716121),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Potlatch.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.40769249081645, -92.3730271124764),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Lakeland.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.492748857513604, -93.2708576030474),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Shoal_Lake.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.81626410896614, -93.28371047055131),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Big_Sandy.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.43972458621422, -92.71564507512474),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Iron.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.39488658263989, -93.98741836831131),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Ball_Club.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.98363280627945, -91.68760141011201),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Winton_B.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.91096039966965, -93.07470621389601),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Meadowbrook.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.64989335670572, -92.3966821231562),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Pike_River.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.63389411798467, -92.99819923063122),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Side_Lake.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.69849637697413, -93.24548480032941),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Round_Lake.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.4127302161937, -92.09536306158428),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Lakeland_B.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.89888854118592, -92.50231191793529),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Grand_Lake.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.87953286681191, -92.27364068126433),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Solway.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.74991094955096, -92.41172524061628),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Knife_Falls.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.23455517178613, -93.71686954166097),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Cohasset.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.32706962122148, -92.93774163937496),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Keewatin.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.67817817347821, -93.12612268485078),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Wright.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.50343933751238, -92.91267414007538),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Kettle_River.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.80377825632088, -92.66268869892734),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Brandon.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.97700021150396, -92.32579962868962),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Bergen_Lake.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.077920977138376, -94.41341405316115),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Onigum.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.211334651716776, -93.13431933460436),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Goodland.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.31437233102813, -92.56485698362752),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Peary.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.29717511053933, -94.3315808579297),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Bena.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.802917995897076, -91.73650419058164),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Winton_A.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.08005321167195, -93.00535771569302),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Cedar_Valley.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.38460982760358, -93.56694948594011),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Arbo.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.68349032301296, -92.80646586881205),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Cromwell.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.67404076013045, -92.67090460249017),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Sand_Lake.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.87071246305832, -92.90291263872044),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Gowan.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.08565240431225, -93.50683407362655),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Pokegama.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.18631923726539, -94.10334942148874),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Boy_River.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.074952567038494, -93.88040845887213),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Remer.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.16578808127717, -93.33253422767572),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Blackberry.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.21834115867768, -93.44958363295417),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Gunn.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.41012814573855, -92.640567427713),
// //         builder: (ctx) =>
// //             Image.asset('assets/sub_name_icon/Sturgeon_Lake_B.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(46.36308718663967, -92.7272002780472),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Sturgeon_Lake.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.71093495958199, -92.06803765316182),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Babbitt.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.85575630331953, -92.09752489509043),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/Clear_Lake.png'),
// //       ),
// //       Marker(
// //         rotateOrigin: const Offset(0.5, 0.5),
// //         point: LatLng(47.119817653350204, -92.45542845134987),
// //         builder: (ctx) => Image.asset('assets/sub_name_icon/cotton.png'),
// //       ),
// //     ];
// //   }

// //   void _updateMarker() {
// //     // print("_updateMarker called");
// //     if (_currentLocation != null) {
// //       _markers = [
// //         Marker(
// //           rotateOrigin: const Offset(0.5, 0.5),
// //           point: _currentLocation!,
// //           builder: (ctx) => Transform.rotate(
// //             angle: _deviceHeading * (pi / 180),
// //             child: const Icon(
// //               Icons.navigation,
// //               color: Colors.blue,
// //               size: 40,
// //             ),
// //           ),
// //         ),
// //       ];
// //       setState(() {
// //         //UI Refresh
// //       });
// //     }
// //   }

// //   void _listenToLocationUpdates() {
// //     // print("_listenToLocationUpdates called");
// //     _positionStreamSubscription =
// //         Geolocator.getPositionStream().listen((Position position) {
// //       // print("Location updated: $newLocation");
// //       setState(() {
// //         newLocation = LatLng(position.latitude, position.longitude);
// //         var result = [
// //           position.latitude,
// //           position.longitude
// //         ]; //latitude and longitude of new position
// //         transition(result); //start moving marker
// //         _currentLocation = newLocation;

// //         _updateMarker();
// //         _loadGeoJSON();
// //         if (driveMode == 1) {
// //           _mapController.move(_currentLocation!, _currentZoom);
// //         }
// //       });
// //     });
// //   }

// //   transition(result) {
// //     i = 0;
// //     deltaLat = (result[0] - position[0]) / numDeltas;
// //     deltaLng = (result[1] - position[1]) / numDeltas;
// //     moveMarker();
// //   }

// //   moveMarker() {
// //     position[0] += deltaLat;
// //     position[1] += deltaLng;
// //     var latlng = LatLng(position[0], position[1]);

// //     if (_currentLocation != null) {
// //       _markers = [
// //         Marker(
// //           // rotateOrigin: const Offset(0.5, 0.5),
// //           point: latlng,
// //           builder: (ctx) => Transform.rotate(
// //             angle: _deviceHeading * (pi / 180),
// //             child: const Icon(
// //               Icons.navigation,
// //               color: Colors.blue,
// //               size: 40,
// //             ),
// //           ),
// //         ),
// //       ];
// //     }

// //     setState(() {
// //       //refresh UI
// //     });

// //     if (i != numDeltas) {
// //       i++;
// //       Future.delayed(Duration(milliseconds: delay), () {
// //         moveMarker();
// //       });
// //     }
// //   }

// //   void _zoomIn() {
// //     setState(() {
// //       _currentZoom = (_currentZoom + 1).clamp(1.0, 17.0);
// //       _mapController.move(_mapController.center, _currentZoom);
// //     });
// //   }

// //   void _zoomOut() {
// //     // print('zoomOut pressed');
// //     setState(() {
// //       _currentZoom = (_currentZoom - 1).clamp(1.0, 17.0);
// //       _mapController.move(_mapController.center, _currentZoom);
// //     });
// //   }

// //   void _resetRotation() {
// //     setState(() {
// //       _deviceHeading = 0.0;
// //     });
// //     _mapController.rotate(0.0);
// //   }

// //   void _checkIfLocationInsidePolygon() {
// //     if (_currentLocation != null && myGeoJson.features.isNotEmpty) {
// //       for (var feature in myGeoJson.features) {
// //         final geometry = feature.geometry;
// //         if (geometry?.type == "MultiPolygon") {
// //           // print("MultiPolygon::");
// //           List<dynamic> coordinates = geometry!.coordinates;

// //           // Iterate over the MultiPolygon coordinates
// //           for (var polygon in coordinates) {
// //             if (polygon is List) {
// //               // Convert polygon to List<LatLng>
// //               List<LatLng> latLngList = polygon
// //                   .map<LatLng>((point) =>
// //                       LatLng(point[1], point[0])) // Assuming [lat, lng]
// //                   .toList();

// //               // Now, you can use latLngList which is of type List<LatLng>
// //               if (latLngList.isNotEmpty) {
// //                 for (int i = 0; i < latLngList.length; i++) {
// //                   var p1 = latLngList[i];
// //                   var p2 = latLngList[(i + 1) % latLngList.length];
// //                   // print("p1: $p1, p2: $p2");

// //                   // Check if the current location is inside the polygon
// //                   if (_isPointInPolygon(_currentLocation!, latLngList)) {
// //                     final subNumber =
// //                         feature.properties!['UplineSour'] ?? 'Unknown';
// //                     // print('subNumber33333333333 $subNumber');
// //                     _showSnackBar(
// //                         "Current location is in SubNumber: $subNumber");
// //                     return;
// //                   }
// //                 }
// //               }
// //             }
// //           }
// //         }
// //       }
// //       _showSnackBar("Current location is not in any SubNumber.");
// //       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
// //           "Current location is not in any SubNumber.", context);
// //     }
// //   }

// //   bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
// //     int crossings = 0;
// //     int n = polygon.length;

// //     for (int i = 0; i < n; i++) {
// //       LatLng p1 = polygon[i];
// //       LatLng p2 = polygon[(i + 1) % n];

// //       if (point.latitude > p1.latitude && point.latitude <= p2.latitude ||
// //           point.latitude > p2.latitude && point.latitude <= p1.latitude) {
// //         if (point.longitude <=
// //             (p2.longitude - p1.longitude) *
// //                     (point.latitude - p1.latitude) /
// //                     (p2.latitude - p1.latitude) +
// //                 p1.longitude) {
// //           crossings++;
// //         }
// //       }
// //     }

// //     return crossings % 2 != 0; // Odd number of crossings means inside
// //   }

// //   void _showSnackBar(String message) {
// //     ScaffoldMessenger.of(context)
// //         .showSnackBar(SnackBar(content: Text(message)));

// //     // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(message, context);
// //   }

// //   @override
// //   void dispose() {
// //     _positionStreamSubscription.cancel();
// //     WakelockPlus.disable();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // _loadGeoJSON();
// //     // List<Map<String, dynamic>> convertToMapList(
// //     //     List<GetDataByNameAndAccountNumber> list) {
// //     //   return list.map((item) {
// //     //     return {
// //     //       "parcelNumber": item.parcelNumber,
// //     //       "wmBF_Accou": item.wmBFAccou,
// //     //       "wmBF_Servi": item.wmBFServi,
// //     //       "geometry": item.geometry,
// //     //       "wmBF_Name": item.wmBFName,
// //     //     };
// //     //   }).toList();
// //     // }

// //     // List<Map<String, dynamic>> Function(
// //     //     List<GetDataByNameAndAccountNumber> list) dataList = convertToMapList;

// //     // List<Map<String, dynamic>> mappedDataList =
// //     //     convertToMapList(dataList as List<GetDataByNameAndAccountNumber>);
// //     // print('mappedDataList $mappedDataList');

// //     return Scaffold(
// //       // appBar: AppBar(title: const Text("Live IVM System Map")),
// //               appBar: AppBar(
// //           iconTheme: const IconThemeData(color: Colors.white),
// //           title: const Text(
// //             "Live IVM System Map1",
// //             style: TextStyle(color: Colors.white),
// //           ),
// //           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
       
// //         ),
// //       body: _currentLocation == null
// //           ? const Center(child: CircularProgressIndicator())
// //           : Stack(
// //               children: [
// //                 FlutterMap(
// //                   mapController: _mapController,
// //                   options: MapOptions(
// //                       onTap: (tapPosition, latLng) {
// //                       _handlePolylineTap(latLng);
// //                      },
// //                     center: _currentLocation ?? LatLng(0.0, 0.0),
// //                     zoom: _currentZoom,
// //                     rotation: _deviceHeading * pi / 180,
// //                     maxZoom: 18,
// //                     minZoom: 0.0,
// //                     interactiveFlags: InteractiveFlag.all,
// //                   ),
// //                   children: [
// //                     TileLayer(
// //                       urlTemplate:
// //                           "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
// //                       subdomains: ['a', 'b', 'c'],
// //                     ),
// //                     PolygonLayer(polygons: myGeoJson.polygons),
// //                     // PolylineLayer(polylines: myGeoJson1fdr1.polylines),
// //                     // PolylineLayer(polylines: myGeoJson3Fdr1.polylines),
// //                     PolylineLayer(
// //                       polylines: myGeoJson1fdr1.polylines.map((polyline) {
// //                         return Polyline(
// //                           points: polyline.points,
// //                           color: Colors.green,
// //                           strokeWidth: 4.0,
// //                         );
// //                       }).toList(),
// //                     ),
// //                      PolylineLayer(
// //                       polylines: myGeoJson1fdr2.polylines.map((polyline) {
// //                         return Polyline(
// //                           points: polyline.points,
// //                           color: Colors.purple,
// //                           strokeWidth: 4.0,
// //                         );
// //                       }).toList(),
// //                     ),
// //                      PolylineLayer(
// //                       polylines: myGeoJson1fdr3.polylines.map((polyline) {
// //                         return Polyline(
// //                           points: polyline.points,
// //                           color: Colors.red,
// //                           strokeWidth: 4.0,
// //                         );
// //                       }).toList(),
// //                     ), PolylineLayer(
// //                       polylines: myGeoJson1fdr4.polylines.map((polyline) {
// //                         return Polyline(
// //                           points: polyline.points,
// //                           color: const Color.fromARGB(255, 61, 2, 255),
// //                           strokeWidth: 4.0,
// //                         );
// //                       }).toList(),
// //                     ), PolylineLayer(
// //                       polylines: myGeoJson1fdr5.polylines.map((polyline) {
// //                         return Polyline(
// //                           points: polyline.points,
// //                           color: Colors.yellow,
// //                           strokeWidth: 4.0,
// //                         );
// //                       }).toList(),
// //                     ), PolylineLayer(
// //                       polylines: myGeoJson1fdr6.polylines.map((polyline) {
// //                         return Polyline(
// //                           points: polyline.points,
// //                           color: Colors.brown,
// //                           strokeWidth: 4.0,
// //                         );
// //                       }).toList(),
// //                     ),
// //                     // PolylineLayer(
// //                     //   polylines: myGeoJson3Fdr1.polylines.map((polyline) {
// //                     //     return Polyline(
// //                     //       points: polyline.points,
// //                     //       color: Colors.purple,
// //                     //       strokeWidth: 4.0,
// //                     //       isDotted: true,
// //                     //     );
// //                     //   }).toList(),
// //                     // ),
// //                       PolylineLayer(
// //   polylines: (myGeoJson3Fdr1.polylines).expand((polyline) {
// //     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.green,); // Adjust as necessary
// //   }).toList(),
// // ),
// //  PolylineLayer(
// //   polylines: (myGeoJson3Fdr2.polylines).expand((polyline) {
// //     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.purple,); // Adjust as necessary
// //   }).toList(),
// // ),
// //  PolylineLayer(
// //   polylines: (myGeoJson3Fdr3.polylines).expand((polyline) {
// //     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.red,); // Adjust as necessary
// //   }).toList(),
// // ),
// //  PolylineLayer(
// //   polylines: (myGeoJson3Fdr4.polylines).expand((polyline) {
// //     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, const Color.fromARGB(255, 61, 2, 255)); // Adjust as necessary
// //   }).toList(),
// // ),
// //  PolylineLayer(
// //   polylines: (myGeoJson3Fdr5.polylines).expand((polyline) {
// //     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.yellow,); // Adjust as necessary
// //   }).toList(),
// // ),
// //  PolylineLayer(
// //   polylines: (myGeoJson3Fdr6.polylines).expand((polyline) {
// //     return createDashedLine(polyline.points.first, polyline.points.last, 10.0, Colors.brown,); // Adjust as necessary
// //   }).toList(),
// // ),

// // ////////////////////////////plot layers data////////////////////////////
// //                     // PolylineLayer(
// //                     //   polylines: myGeoJsonLayerData.polylines.map((polyline) {
// //                     //     return Polyline(
// //                     //       points: polyline.points,
// //                     //       color: const Color.fromARGB(255, 248, 3, 228),
// //                     //       strokeWidth: 8.0,
// //                     //     );
// //                     //   }).toList(),
// //                     // ),
// //                     PolylineLayer(
// //                     polylines: myPolylines,
// //                     ),
// // ////////////////////////////layers data end////////////////////////////                    

// //                     MarkerLayer(markers: _markers), //current position marker
// //                     MarkerLayer(markers: _markers1),
// //                     MarkerLayer(
// //                       markers: _markerSearch,
// //                     ),
// //                     MarkerLayer(
// //                       markers: myGeoJson2.markers.map((marker) {
// //                         return Marker(
// //                           point: marker.point,
// //                           builder: (ctx) => GestureDetector(
// //                             onTap: () {
// //                               fetchDataAndShowDialog(
// //                                 ctx,
// //                                 marker.point.longitude,
// //                                 marker.point.latitude,
// //                               );
// //                             },
// //                             child: Image.asset(
// //                               'assets/period1.png',
// //                               fit: BoxFit.cover,
// //                             ),
// //                           ),
// //                         );
// //                       }).toList(),
// //                     ),
// //                     (MarkerLayer(markers: myMarkers))
// //                   ],
// //                 ),
// //                 Positioned(
// //                   top: 20,
// //                   left: 20,
// //                   right: 15,
// //                   height: 45,
// //                   child: TypeAheadField(
// //                     textFieldConfiguration: TextFieldConfiguration(
// //                       controller: _searchController,
// //                       decoration: InputDecoration(
// //                         hintText: 'Search locations...',
// //                         filled: true,
// //                         fillColor: Colors.white,
// //                         prefixIcon: const Icon(Icons.search),
// //                         suffixIcon: _searchController.text.isNotEmpty
// //             ? IconButton(
// //                 icon: const Icon(Icons.clear),
// //                 onPressed: () {
// //                   _searchController.clear();
// //                   _showedLocationpin = false;
// //                 },
// //               )
// //             : null,
// //                         contentPadding: const EdgeInsets.symmetric(
// //                             vertical: 2.0, horizontal: 12.0),
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(10),
// //                           borderSide: BorderSide.none,
// //                         ),
// //                       ),
// //                     ),
// //                     suggestionsCallback: _getLocationSuggestions,
// //                     itemBuilder: (context, suggestion) {
// //                       return ListTile(
// //                         leading: const Icon(Icons.location_city),
// //                         title: Text(suggestion['wmBF_Name'] ??
// //                             suggestion['name'] ??
// //                             'Unknown'),
// //                         subtitle: Text(
// //                           "Service: ${suggestion['wmBF_Servi'] ?? ''}\n"
// //                           "Parcel: ${suggestion['parcelNumber'] ?? ''}",
// //                         ),
// //                         // Text(suggestion),
// //                       );
// //                     },
// //                     onSuggestionSelected: (suggestion) {
// //                       _currentZoom = 15.0;
// //                       _searchController.text = suggestion['wmBF_Name'] ??
// //                           suggestion['name'] ??
// //                           'Unknown';
// //                       //  suggestion;
// //                       // _updateMapLocation(suggestion.toString());
// //                       _updateMapLocation(
// //                           suggestion['name'] ?? suggestion['wmBF_Servi'] ?? '');
// //                       _showedLocationpin = true;
// //                     },
// //                   ),
// //                 ),
// //                 Positioned(
// //                   bottom: 10,
// //                   right: 5,
// //                   child: Column(
// //                     children: [
// //                       GestureDetector(
// //                         onTap: _resetRotation,
// //                         child: Transform.rotate(
// //                           angle: -_deviceHeading * pi / 180,
// //                           child: Image.asset(
// //                             'assets/compass.png',
// //                             width: 60,
// //                             height: 60,
// //                           ),
// //                         ),
// //                       ),
                      
// //                       // const SizedBox(height: 10),
// //                       GestureDetector(
// //                         onTap: _recenterMap,
// //                         // mini: true,
// //                         // child: Icon(Icons.my_location,
// //                         //     color: (driveMode == 0)
// //                         //         ? const Color.fromARGB(233, 54, 54, 54)
// //                         //         : const Color.fromARGB(233, 46, 99, 168)),
// //                          child:(driveMode == 0)?Image.asset(
// //                               'assets/location black.png',width: 50,
// //                             height: 60,
// //                            )
// //                            :Image.asset(
// //                            'assets/location_blue.png',width: 50,
// //                             height: 60,
// //                            ),
                      
// //                       ),
// //                       // const SizedBox(height: 10),
// //                       GestureDetector(
// //                         onTap: _zoomIn,
// //                         // mini: true,
// //                         child: 
// //                         // const Icon(Icons.zoom_in),
// //                         Image.asset(
// //     'assets/zoom in v2.png',width: 50,
// //                             height: 50,)
// //                       ),
// //                       // const SizedBox(height: 10),
// //                       GestureDetector(
// //                         onTap: _zoomOut,
// //                         // mini: true,
// //                         child: 
// //                         // const Icon(Icons.zoom_out),
// //                           Image.asset(
// //                           'assets/zoom out v2.png',width: 50,
// //                             height: 50,)
// //                       ),
// //                       ///fffwww
// //                        GestureDetector(
// //                         onTap: () => _handleFeederTap(context), 
// //                         // mini: true,
// //                         child: 
// //                         // const Icon(Icons.zoom_out),
// //                           Image.asset(
// //                           'assets/F.png',width: 50,
// //                             height: 50,)
// //                       ),
// //                        GestureDetector(
// //                         onTap: () => _handleWorkTap(context), 
// //                         // mini: true,
// //                         child: 
// //                         // const Icon(Icons.zoom_out),
// //                           Image.asset(
// //                           'assets/W.png',width: 50,
// //                             height: 50,)
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 // Positioned(
// //                 //   bottom: 20,
// //                 //   left: 20,
// //                 //   child: FloatingActionButton(
// //                 //     onPressed: _recenterMap,
// //                 //     mini: true,
// //                 //     child: Icon(Icons.my_location,
// //                 //         color: (driveMode == 0)
// //                 //             ? Color.fromARGB(233, 54, 54, 54)
// //                 //             : Color.fromARGB(233, 46, 99, 168)),
// //                 //   ),
// //                 // ),
// //               ],
// //             ),
// //     );
// //   }

// //   Future<void> _recenterMap() async {
// //     if (_currentLocation == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Current location not available.")),
// //       );
// //       return;
// //     }
// //     setState(() {
// //       if (driveMode == 0) {
// //         driveMode = 1;
// //         _mapController.move(_currentLocation!, _currentZoom);
// //       } else {
// //         driveMode = 0;
// //       }
// //     });
// //   }

// //   Future<void> _addPolygonToMap(List<LatLng> polygonLatLng) async {
// //     // print("Adding polygon to map with coordinates: $polygonLatLng");
// //     List<List<double>> coordinates = polygonLatLng.map((latLng) {
// //       return [
// //         latLng.longitude,
// //         latLng.latitude
// //       ]; // Correct order: [longitude, latitude]
// //     }).toList();
// //     String geoJsonString = jsonEncode({
// //       'type': 'FeatureCollection',
// //       'features': [
// //         {
// //           'type': 'Feature',
// //           'geometry': {
// //             'type': 'Polygon',
// //             'coordinates': [coordinates], // Wrap in another list for GeoJSON
// //           },
// //           'properties': {}
// //         }
// //       ]
// //     });
// //     // myGeoJson.parseGeoJsonAsString(geoJsonString);
// //     if (subNumberLocalVariable == '11-COTTON') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });
// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //            myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });
// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd3_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COTTON_frd4_underground.geojson');

// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/COTTON_consumer.geojson');

// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     //////////////////////////////////////////////frazerBay//////////////////////////////////////////
// //      else if (subNumberLocalVariable == '16-FRAZER BAY') {
// //       setState(() {
// //          myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/FRAZER BAY_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/FRAZER_BAY_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     //////////////////////////////////vermilion/////////////////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '15-VERMILION') {
// //       setState(() {
// //           myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd1_overhead.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd2_overhead.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/VERMILION_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/VERMILION_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     /////////////////////////////Longville//////////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '65-LONGVILLE') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LONGVILLE_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LONGVILLE_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/LONGVILLE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ///////////////////////////////////////orr//////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '17-ORR') {
// //       setState(() {
// //          myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ORR_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/ORR_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     /////////////////////////////Hill city////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '56-HILL CITY') {
// //       setState(() {
// //          myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd3_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/HILL CITY_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/HILL_CITY_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     /////////////////////////////Cook///////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '13-COOK') {
// //       setState(() {
// //          myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COOK_frd4_overhead.geojson');
// //           final String geoJSONStringOverheadFrd5 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd5_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //         myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFrd5);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd3_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COOK_frd4_underground.geojson');
// //           final String geoJSONStringUndergroundFdr5 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/cook_frd5_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //           myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //            myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/COOK_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ////////////////////////////////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '10-LAKELAND') {
// //       setState(() {
// //          myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverhead =
// //           await rootBundle.loadString('assets/LAKELAND_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverhead);
// //       });

// //       final String geoJSONStringUnderground =
// //           await rootBundle.loadString('assets/LAKELAND_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUnderground);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/LAKELAND_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ///////////////////////////////////shoal lake//////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '66-SHOAL LAKE') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd3_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SHOAL LAKE_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/SHOAL_LAKE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ///////////////////////////////////Big Sandy//////////////////////////////////////////// 
// //     else if (subNumberLocalVariable == '44-BIG SANDY') {
// //       setState(() {
// //       myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BIG SANDY_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/BIG_SANDY_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     /////////////////////////////////////////////////////////iron//////////////////////////////
// //     else if (subNumberLocalVariable == '08-IRON') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });
// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });
// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd3_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/IRON_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/IRON_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     //////////////////////////////ball club//////////////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '54-BALL CLUB') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd3_overhead.geojson');
// //            final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd3_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BALL CLUB_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/BALL_CLUB_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     //////////////////////////Winton-B/////////////////////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '06B-WINTON B') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr5 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd5_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //           myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr5 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_B_frd5_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/WINTON_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     /////////////////////////////////////meadowBROOK///////////////////////////////////////////
// //     else if (subNumberLocalVariable == '03-MEADOWBROOK') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //         await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd1_overhead.geojson');
// //         final String geoJSONStringOverheadFdr2 =
// //         await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd2_overhead.geojson');
// //         final String geoJSONStringOverheadFdr3 =
// //         await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd3_overhead.geojson');
// //         final String geoJSONStringOverheadFdr4 =
// //         await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //           myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd3_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/MEADOWBROOK_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/MEADOWBROOK_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ///////////////////////////////////pike River/////////////////////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '02-PIKE RIVER') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PIKE RIVER_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/PIKE_RIVER_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     //////////////////////////////////side Lake////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '04-SIDE LAKE') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/sidelake_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/SIDE_LAKE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     /////////////////////////////////////////round Lake//////////////////////////////////
// //      else if (subNumberLocalVariable == '35-ROUND LAKE') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ROUND LAKE_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ROUND LAKE_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //          myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ROUND LAKE_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ROUND LAKE_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //          myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/ROUND_LAKE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ////////////////////////////leakLand B////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '19-LAKELAND B') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd4_overhead.geojson');
// //           final String geoJSONStringOverheadFdr6 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd6_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //         myGeoJson1fdr6.parseGeoJsonAsString(geoJSONStringOverheadFdr6);
// //       });
// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd4_underground.geojson');
// //           final String geoJSONStringUndergroundFdr6 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/LAKELAND B_frd6_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //         myGeoJson3Fdr6.parseGeoJsonAsString(geoJSONStringUndergroundFdr6);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/LAKELAND B_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ///////////////////////////////Grand Lake//////////////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '34-GRAND LAKE') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });
// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr6 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd6_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr6.parseGeoJsonAsString(geoJSONStringOverheadFdr6);
// //       });
// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd3_underground.geojson');
// //           final String geoJSONStringUndergroundFdr6 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GRAND LAKE_frd6_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr6.parseGeoJsonAsString(geoJSONStringUndergroundFdr6);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/GRAND_LAKE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ////////////////////////////solway/////////////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '38-SOLWAY') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd3_overhead.geojson');
// //            final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });
// //       final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd3_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SOLWAY_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/SOLWAY_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ///////////////////////////////////////////knife falls////////////////////////////////////////
// //     else if (subNumberLocalVariable == '45-KNIFE FALLS') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });
// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KNIFE FALLS_frd1_overhead.geojson');
// //          final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KNIFE FALLS_frd2_overhead.geojson');  
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //       });
// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KNIFE FALLS_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KNIFE FALLS_frd2_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/KNIFE_FALLS_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     //////////////////////////cohasset//////////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '55-COHASSET') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd3_overhead.geojson');
// //            final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd4_overhead.geojson'); 
// //           final String geoJSONStringOverheadFdr5 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd5_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //         myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
// //       });

// //       final String geoJSONStringUndergroundFdr1  =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2  =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3  =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd3_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4  =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd4_underground.geojson');
// //            final String geoJSONStringUndergroundFdr5  =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/COHASSET_frd5_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //         myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/COHASSET_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     //////////////////////////////keewatin///////////////////////////////////
// //     else if (subNumberLocalVariable == '05-KEEWATIN') {
// //       print('keewatin case');
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/keewatin_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/keewatin_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/keewatin_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/keewatin_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/KEEWATIN_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     //////////////////////////Wright//////////////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '37-WRIGHT') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1  =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2  =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4  =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WRIGHT_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/WRIGHT_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ///////////////////////////////////////////kettle River///////////////////////////////////
// //     else if (subNumberLocalVariable == '47-KETTLE RIVER') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });
// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd4_overhead.geojson');
// //           final String geoJSONStringOverheadFdr5 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd5_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //         myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
// //       });

// //       final String geoJSONStringUndergroundFdr1 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd3_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd4_underground.geojson');
// //            final String geoJSONStringUndergroundFdr5 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/KETTLE RIVER_frd5_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //             myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/KETTLE_RIVER_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     //////////////////////////////////////////////brandon////////////////////////////////////
// //     else if (subNumberLocalVariable == '31-BRANDON') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BRANDON_frd3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BRANDON_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //          myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BRANDON_frd3_overhead.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BRANDON_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/BRANDON_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     /////////////////////////////////////////////////bergen Lake////////////////////////
// //      else if (subNumberLocalVariable == '41-BERGEN LAKE') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });
// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BERGEN LAKE_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BERGEN LAKE_frd2_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //       });
// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BERGEN LAKE_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BERGEN LAKE_frd2_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/BERGEN_LAKE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     /////////////////////////////////////Onigun////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '51-ONIGUM') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/ONIGUM_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/ONIGUM_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ////////////////////////goodland////////////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '61-GOODLAND') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOODLAND_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/GOODLAND_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     //////////////////////////////////////////////peary//////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '01-PEARY') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/PEARY_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/PEARY_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     //////////////////////////////Bena////////////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '60-BENA') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd2_overhead.geojson');
// //             final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd3_overhead.geojson');
// //             final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //          myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //           myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd3_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BENA_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/BENA_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ///////////////////////////Winton-A///////////////////////////////////////////////////////////////////// 
// //     else if (subNumberLocalVariable == '06A-WINTON A') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_A_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/WINTON_A_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/WINTON_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ///////////////////////////////////cedar Valley////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '36-CEDAR VALLEY') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });
// //       final String geoJSONStringUndergroundFdr1 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/CEDAR VALLEY_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/CEDAR_VALLEY_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //      //////////////////////////////////////////Arbo////////////////////////////////////////
// //      else if (subNumberLocalVariable == '53-ARBO') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           // await rootBundle.loadString('assets/ARBO_overhead.geojson');
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           // await rootBundle.loadString('assets/ARBO_overhead.geojson');
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           // await rootBundle.loadString('assets/ARBO_overhead.geojson');
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr3_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           // await rootBundle.loadString('assets/ARBO_overhead.geojson');
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr4_overhead.geojson');
          
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr3_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/arbo_fdr4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //           myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //             myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //               myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/ARBO_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ///////////////////////////////Cromwell////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '33-CROMWELL') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd3_overhead.geojson');
// //            final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });
// //       final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd3_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/CROMWELL_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //          myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //           myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/CROMWELL_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     /////////////////////////////////sand lake/////////////////////////////////////////
// //      else if (subNumberLocalVariable == '12-SAND LAKE') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd3_overhead.geojson');
// //            final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //           myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //             myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //               myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd3_underground.geojson');
// //            final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/SAND LAKE_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/SAND_LAKE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ///////////////////////////////////////Gowan/////////////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '32-GOWAN') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });
// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //           myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });
// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GOWAN_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/GOWAN_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     /////////////////////////////////pokegama//////////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '67-POKEGAMA') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd1_underground.geojson');
// //            final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/POKEGAMA_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/POKEGAMA_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     //////////////////////////////////////Boy River///////////////////////////////////////
// //      else if (subNumberLocalVariable == '52-BOY RIVER') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });
// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd3_overhead.geojson');
          
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
           
// //       });
// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd2_underground.geojson');
// //  final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BOY RIVER_frd3_underground.geojson');
           
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
       
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/BOY_RIVER_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     //////////////////////////////////////////remer///////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '64-REMER') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/REMER_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/REMER_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //             myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/REMER_frd2_underground.geojson');
// //            final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/REMER_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/REMER_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     //////////////////////////////Blackberry///////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '58-BLACKBERRY') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/BLACKBERRY_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/BLACKBERRY_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     /////////////////////////////////////////Gunn///////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '59-GUNN') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd2_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd3_overhead.geojson');
// //            final String geoJSONStringOverheadFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd4_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //         myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //         myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd3_underground.geojson');
// //           final String geoJSONStringUndergroundFdr4 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/GUNN_frd4_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //           myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //            myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //       });
// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/GUNN_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     /////////////////////////////////STURGEON LAKE B///////////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '43-STURGEON LAKE B') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr4 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/STURGEON LAKE B_frd4_overhead.geojson');
// //           final String geoJSONStringOverheadFdr5 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/STURGEON LAKE B_frd5_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr4.parseGeoJsonAsString(geoJSONStringOverheadFdr4);
// //          myGeoJson1fdr5.parseGeoJsonAsString(geoJSONStringOverheadFdr5);
// //       });

// //       final String geoJSONStringUndergroundFdr4 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/STURGEON LAKE B_frd4_underground.geojson');
// //           final String geoJSONStringUndergroundFdr5 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/STURGEON LAKE B_frd5_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr4.parseGeoJsonAsString(geoJSONStringUndergroundFdr4);
// //         myGeoJson3Fdr5.parseGeoJsonAsString(geoJSONStringUndergroundFdr5);
// //       });

// //       final String geoJSONStringConsumer = await rootBundle
// //           .loadString('assets/STURGEON_LAKE_B_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ////////////////////////////sturgeon lake////////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '39-STURGEONLAKE') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/STURGEONLAKE_frd1_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //       });

// //       final String geoJSONStringUndergroundFdr1 = await rootBundle
// //           .loadString('assets/geoJson_files_accToFeeder/STURGEONLAKE_frd1_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/STURGEONLAKE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     } 
// //     ///////////////////////////////babbit/////////////////////////////////////////////
// //     else if (subNumberLocalVariable == '09-BABBITT') {
// //       setState(() {
// //        myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd1_overhead.geojson');
// //           final String geoJSONStringOverheadFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd2_overhead.geojson');
// //           final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr2.parseGeoJsonAsString(geoJSONStringOverheadFdr2);
// //           myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr2 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd2_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/babbitt_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //         myGeoJson3Fdr2.parseGeoJsonAsString(geoJSONStringUndergroundFdr2);
// //         myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/BABBITT_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ///////////////////////////////////Clear Lake/////////////////////////////////////////////////////
// //      else if (subNumberLocalVariable == '07-CLEAR LAKE') {
// //       setState(() {
// //         myGeoJson1fdr1 = GeoJsonParser();
// //         myGeoJson1fdr2 = GeoJsonParser();
// //         myGeoJson1fdr3 = GeoJsonParser();
// //         myGeoJson1fdr4 = GeoJsonParser();
// //         myGeoJson1fdr5 = GeoJsonParser();
// //         myGeoJson1fdr6 = GeoJsonParser();
// //         myGeoJson2 = GeoJsonParser();
// //         myGeoJson3Fdr1 = GeoJsonParser();
// //         myGeoJson3Fdr2 = GeoJsonParser();
// //         myGeoJson3Fdr3 = GeoJsonParser();
// //         myGeoJson3Fdr4 = GeoJsonParser();
// //         myGeoJson3Fdr5= GeoJsonParser();
// //         myGeoJson3Fdr6= GeoJsonParser();
// //       });

// //       final String geoJSONStringOverheadFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/clearlake_frd1_overhead.geojson');
// //            final String geoJSONStringOverheadFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/clearlake_frd3_overhead.geojson');
// //       setState(() {
// //         myGeoJson1fdr1.parseGeoJsonAsString(geoJSONStringOverheadFdr1);
// //          myGeoJson1fdr3.parseGeoJsonAsString(geoJSONStringOverheadFdr3);
// //       });

// //       final String geoJSONStringUndergroundFdr1 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/clearlake_frd1_underground.geojson');
// //           final String geoJSONStringUndergroundFdr3 =
// //           await rootBundle.loadString('assets/geoJson_files_accToFeeder/clearlake_frd3_underground.geojson');
// //       setState(() {
// //         myGeoJson3Fdr1.parseGeoJsonAsString(geoJSONStringUndergroundFdr1);
// //          myGeoJson3Fdr3.parseGeoJsonAsString(geoJSONStringUndergroundFdr3);
// //       });

// //       final String geoJSONStringConsumer =
// //           await rootBundle.loadString('assets/CLEAR_LAKE_consumer.geojson');
// //       setState(() {
// //         myGeoJson2.parseGeoJsonAsString(geoJSONStringConsumer);
// //       });
// //     }
// //     ////////////////////////////////////////////////////////////////////////////////////////////////
// //   }

// //   Future<List<Map<String, dynamic>>> _getLocationSuggestions(
// //       String query) async {
// //     try {
// //       final url =
// //           'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5';
// //       final response = await http.get(Uri.parse(url));

// //       if (response.statusCode == 200) {
// //         final results = json.decode(response.body) as List;
// //         if (results.isEmpty) {
// //           // Call getDataByNameAndAccountNumber if no suggestions
// //           final fallbackData = await getDataByNameAndAccountNumber(query);
// //           if (fallbackData['getDataByNameAndAccountNumber'] != null) {
// //             return List<Map<String, dynamic>>.from(
// //                 fallbackData['getDataByNameAndAccountNumber']);
// //           }
// //           return [];
// //         }

// //         return results.map((result) {
// //           return {
// //             'name': result['display_name'],
// //             'latitude': result['lat'],
// //             'longitude': result['lon']
// //           };
// //         }).toList();
// //       } else {
// //         final fallbackData = await getDataByNameAndAccountNumber(query);
// //         if (fallbackData['getDataByNameAndAccountNumber'] != null) {
// //           return List<Map<String, dynamic>>.from(
// //               fallbackData['getDataByNameAndAccountNumber']);
// //         }
// //         return [];
// //       }
// //     } catch (e) {
// //       print("Error fetching location suggestions: $e");
// //       return [];
// //     }
// //   }

// //   // Update map location based on the selected suggestion
// //   Future<void> _updateMapLocation(String suggestion) async {
// //     try {
// //       final url =
// //           'https://nominatim.openstreetmap.org/search?q=$suggestion&format=json&limit=1';
// //       final response = await http.get(Uri.parse(url));

// //       if (response.statusCode == 200) {
// //         final results = json.decode(response.body) as List;
// //         if (results.isNotEmpty) {
// //           final location = results.first;
// //           final newLocation = LatLng(
// //             double.parse(location['lat']),
// //             double.parse(location['lon']),
// //           );

// //           // setState(() {
// //           //   _currentLocation = newLocation;
// //           // });
// //           // _mapController.move(
// //           //     newLocation, _currentZoom); // Center the map on the location

// //           setState(() {
// //             _currentLocation = newLocation;
// //             _markerSearch = [
// //               Marker(
// //                 point: newLocation,
// //                 builder: (ctx) => const Icon(
// //                   Icons.location_on,
// //                   color: Colors.red,
// //                   size: 40.0,
// //                 ),
// //               ),
// //             ];
// //           });
// //           _mapController.move(newLocation, _currentZoom);
// //         }
// //       }
// //     } catch (e) {
// //       // print("Error updating map location: $e");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Error locating address')),
// //       );
// //     }
// //   }

// //   Future<List<dynamic>?> fetchDataByLatLong(
// //       double latitude, double longitude) async {
// //     const String baseUrl =
// //         'https://civmapi.ariespro.com/civmapi/supervisorLoginPanel/getDataByLatitudeLongitude';
// //     final Uri url =
// //         Uri.parse('$baseUrl?latitude=$latitude&longitude=$longitude');
// //     print(url);
// //     final userPreferences = Provider.of<UserPref>(context, listen: false);
// //     UserModel data = await userPreferences.getUser();

// //     try {
// //       final http.Response response = await http.get(
// //         url,
// //         headers: {
// //           'Authorization': 'Bearer ${data.token!}',
// //           'Content-Type': 'application/json',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         final jsonData = jsonDecode(response.body);
// //         if (jsonData['getDataByLatitudeLongitude'] is List) {
// //           return jsonData['getDataByLatitudeLongitude'];
// //         } else {
// //           print('Unexpected response structure: ${response.body}');
// //           return null;
// //         }
// //       } else {
// //         print('Failed to fetch data: ${response.statusCode}');
// //         return null;
// //       }
// //     } catch (e) {
// //       print('Error fetching data: $e');
// //       return null;
// //     }
// //   }

// //   Future<void> fetchDataAndShowDialog(
// //       BuildContext ctx, double latitude, double longitude) async {
// //           showDialog(
// //     context: ctx,
// //     barrierDismissible: false, // Prevent dismissing while loading
// //     builder: (context) {
// //       return AlertDialog(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(16), // Rounded corners
// //         ),
// //         content: const SizedBox(
// //           height: 120,
// //           child: Center(
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 CircularProgressIndicator(
// //                   color: Colors.blue, // Customize color
// //                   strokeWidth: 4, // Thicker stroke
// //                 ),
// //                 SizedBox(height: 16),
// //                 Text(
// //                   "Fetching Data...",
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       );
// //     }, 
// //   );
// //     final data = await fetchDataByLatLong(latitude, longitude);
// //     Navigator.pop(ctx);
// //     if (data != null && data.isNotEmpty) {
// //       showDialog(
// //         context: ctx,
// //         builder: (context) {
// //           return AlertDialog(
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const SizedBox(
// //                   height: 8,
// //                 ),
// //                 RichText(
// //                   text: TextSpan(
// //                     text: 'Customer Name : ',
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.bold, color: Colors.black),
// //                     children: [
// //                       TextSpan(
// //                         text: data[0]['wmBF_Name'] ?? "NA",
// //                         style: const TextStyle(fontWeight: FontWeight.normal),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 8,
// //                 ),
// //                 RichText(
// //                   text: TextSpan(
// //                     text: 'Address : ',
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.bold, color: Colors.black),
// //                     children: [
// //                       TextSpan(
// //                         text: data[0]['wmBF_Ser_2'] ?? "NA",
// //                         style: const TextStyle(fontWeight: FontWeight.normal),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 8,
// //                 ),
// //                 InkWell(
// //                   onTap: () {
// //                     if (data[0]['wmBF_Phone'] != '' &&
// //                         data[0]['wmBF_Phone'] != null) {
// //                       setState(() {
// //                         _launched = _makePhoneCall(data[0]['wmBF_Phone']);
// //                       });
// //                     }
// //                   },
// //                   child: RichText(
// //                     text: TextSpan(
// //                       text: 'Phone Number : ',
// //                       style: const TextStyle(
// //                           fontWeight: FontWeight.bold, color: Colors.blue),
// //                       children: [
// //                         TextSpan(
// //                           text: data[0]['wmBF_Phone'] ?? "NA",
// //                           style: const TextStyle(fontWeight: FontWeight.normal),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 8,
// //                 ),
// //                 RichText(
// //                   text: TextSpan(
// //                     text: 'Phase : ',
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.bold, color: Colors.black),
// //                     children: [
// //                       TextSpan(
// //                         text: data[0]['wmPhasing'] ?? "NA",
// //                         style: const TextStyle(fontWeight: FontWeight.normal),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 8,
// //                 ),
// //                 RichText(
// //                   text: TextSpan(
// //                     text: 'Map Location No : ',
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.bold, color: Colors.black),
// //                     children: [
// //                       TextSpan(
// //                         text: data[0]['wmElementN'] ?? "NA",
// //                         style: const TextStyle(fontWeight: FontWeight.normal),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 8,
// //                 ),
// //                 RichText(
// //                   text: TextSpan(
// //                     text: 'Parcel : ',
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.bold, color: Colors.black),
// //                     children: [
// //                       TextSpan(
// //                         text: data[0]['parcelNumber'] ?? "NA",
// //                         style: const TextStyle(fontWeight: FontWeight.normal),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                  const SizedBox(
// //                   height: 8,
// //                 ),
// //                 RichText(
// //                   text: TextSpan(
// //                     text: 'Comment : ',
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.bold, color: Colors.black),
// //                     children: [
// //                       TextSpan(
// //                         text: data[0]['comment'] ?? "NA",
// //                         style: const TextStyle(fontWeight: FontWeight.normal),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //               ],
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () => Navigator.of(context).pop(),
// //                 child: const Text('Close'),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //     } else {
// //       _showSnackBar('No data available');
// //     }
// //   }

// //   Future<void> _makePhoneCall(String phoneNumber) async {
// //     final Uri launchUri = Uri(
// //       scheme: 'tel',
// //       path: phoneNumber,
// //     );
// //     await launchUrl(launchUri);
// //   }

// //   Future<dynamic> getDataByNameAndAccountNumber(String accOrName) async {
// //     //102114900
// //     print('inside getDataByNameAndAccountNumber');
// //     const String endpoint =
// //         "https://civmapi.ariespro.com/civmapi/supervisorLoginPanel/getDataByNameAndAccountNumber";
// //     final Uri url = Uri.parse("$endpoint?accOrName=$accOrName");
// //     print('inside getDataByNameAndAccountNumber');
// //     print(url);
// //     final userPreferences = Provider.of<UserPref>(context, listen: false);
// //     UserModel data = await userPreferences.getUser();

// //     final headers = {'Authorization': 'Bearer ${data.token!}'};

// //     try {
// //       final response = await http.get(url, headers: headers);

// //       print('Response status: ${response.statusCode}');
// //       print('Response body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         print('data: $data');
// //         return data;
// //       } else {
// //         print(
// //             'Error: Status code ${response.statusCode}, Body: ${response.body}');
// //         return {
// //           "error":
// //               "Failed to load data. Status code: ${response.statusCode}, Body: ${response.body}"
// //         };
// //       }
// //     } catch (e) {
// //       print("Error occurred: $e");
// //       return {"error": "An error occurred: $e"};
// //     }
// //   }
// //    double haversineDistance(LatLng start, LatLng end) {
// //   const R = 6371e3; // Earth's radius in meters
// //   final lat1 = start.latitude * pi / 180;
// //   final lat2 = end.latitude * pi / 180;
// //   final deltaLat = (end.latitude - start.latitude) * pi / 180;
// //   final deltaLon = (end.longitude - start.longitude) * pi / 180;

// //   final a = sin(deltaLat / 2) * sin(deltaLat / 2) +
// //       cos(lat1) * cos(lat2) * sin(deltaLon / 2) * sin(deltaLon / 2);
// //   final c = 2 * atan2(sqrt(a), sqrt(1 - a));

// //   return R * c; // Distance in meters
// // }


// // List<LatLng> createSegment(LatLng start, LatLng end, double fraction) {
// //   return [
// //     LatLng(
// //       start.latitude + (end.latitude - start.latitude) * fraction,
// //       start.longitude + (end.longitude - start.longitude) * fraction,
// //     ),
// //   ];
// // }

// // List<Polyline> createDashedLine(LatLng start, LatLng end, double dashLength, Color passedColor, ) {
// //   List<Polyline> dashedLine = [];
// //   double totalDistance = haversineDistance(start, end);
// //   int dashCount = (totalDistance / dashLength).floor();

// //   for (int i = 0; i < dashCount; i++) {
// //     double startFraction = (i * dashLength) / totalDistance;
// //     double endFraction = ((i + 1) * dashLength) / totalDistance;

// //     if (i % 2 == 0) {
// //       // Create visible segments
// //       dashedLine.add(
// //         Polyline(
// //           points: [
// //             createSegment(start, end, startFraction)[0],
// //             createSegment(start, end, endFraction)[0],
// //           ],
// //           color: passedColor,
// //           strokeWidth: 4.0,
// //         ),
// //       );
// //     }
// //   }
// //   return dashedLine;
// // }

// // Future<String?> _showFeederColorDialog(BuildContext context) async {
// //   Map<String, Color> colorMap = {
// //     "FDR1": const Color.fromARGB(255, 1, 127, 5),
// //     "FDR2": const Color.fromARGB(255, 96, 0, 113),
// //     "FDR3": const Color.fromARGB(255, 247, 19, 2),
// //     "FDR4": const Color.fromARGB(255, 38, 1, 247),
// //     "FDR5": Colors.yellow,
// //     "FDR6": const Color.fromARGB(255, 113, 68, 1),
// //   };

// //   return showDialog<String>(
// //     context: context,
// //     builder: (context) {
// //       return AlertDialog(
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             const Text("Color Feeder"), // Title
// //             IconButton(
// //               icon: const Icon(Icons.close, color: Colors.red),
// //               onPressed: () {
// //                 Navigator.pop(context); // Close dialog
// //               },
// //             ),
// //           ],
// //         ),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: colorMap.entries.map((entry) {
// //             return ListTile(
// //               leading: Container(
// //                 width: 60,
// //                 height: 8, 
// //                 decoration: BoxDecoration(
// //                   color: entry.value,
// //                   borderRadius: BorderRadius.circular(1),
// //                 ),
// //               ),
// //               title: Text(entry.key.toUpperCase()),
// //               onTap: () {
// //                 Navigator.pop(context, entry.key); // Return the selected color
// //               },
// //             );
// //           }).toList(),
// //         ),
// //       );
// //     },
// //   );
// // }
// // void _handleFeederTap(BuildContext context) async {
// //   String? selectedColor = await _showFeederColorDialog(context);
// //   if (selectedColor != null) {
// //     print("Selected color: $selectedColor");
// //   }
// // }

// // Future<String?> _showWorkColorDialog(BuildContext context) async {
// //   Map<String, Color> colorMap = {
// //     "Jaraff": const Color.fromARGB(255, 96, 0, 113),
// //     "Mowing": const Color.fromARGB(255, 113, 68, 1),
// //     "Mini Jaraff": const Color.fromARGB(255, 247, 19, 2),
// //     "BYL": const Color.fromARGB(255, 2, 212, 249), 
// //     "Bucket": Colors.orange,
// //     "Ground": Colors.yellow,
// //     "Cross-country spray": const Color.fromARGB(255, 38, 1, 247),
// //     "Roadside spray": const Color.fromARGB(255, 1, 127, 5),
// //     "No spray":const Color.fromARGB(255, 252, 199, 249),
// //   };

// //   return showDialog<String>(
// //     context: context,
// //     builder: (context) {
// //       return AlertDialog(
// //        title: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             const Text("Color Work"), // Title
// //             IconButton(
// //               icon: const Icon(Icons.close, color: Colors.red),
// //               onPressed: () {
// //                 Navigator.pop(context); // Close dialog
// //               },
// //             ),
// //           ],
// //         ),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: colorMap.entries.map((entry) {
// //             return ListTile(
// //               leading: Container(
// //                 width: 60,
// //                 height: 8, 
// //                 decoration: BoxDecoration(
// //                   color: entry.value,
// //                   borderRadius: BorderRadius.circular(1),
// //                 ),
// //               ),
// //               title: Text(entry.key.toUpperCase()),
// //               onTap: () {
// //                 Navigator.pop(context, entry.key); // Return the selected color
// //               },
// //             );
// //           }).toList(),
// //         ),
// //       );
// //     },
// //   );
// // }
// // void _handleWorkTap(BuildContext context) async {
// //   String? selectedColor = await _showWorkColorDialog(context);
// //   if (selectedColor != null) {
// //     print("Selected color: $selectedColor");
// //   }
// // }




// // Future<void> getMapLinesBySubstation(BuildContext context, String substationName) async {
// //   final String url =
// //       'https://civmapi.ariespro.com/civmapi/supervisorLoginPanel/getMapLinesBySubstationAndType?substationName=$substationName';
// //   final userPreferences = Provider.of<UserPref>(context, listen: false);
// //   UserModel data = await userPreferences.getUser();
// //   print('Fetching map lines from URL: $url');
// //   try {
// //     final response = await http.get(
// //       Uri.parse(url),
// //       headers: {
// //         "Authorization": 'Bearer ${data.token!}',
// //         'Content-Type': 'application/json',
// //       },
// //     );
// //     if (response.statusCode == 200) {
// //       final jsonData = jsonDecode(response.body);
// //       print("API Response: $jsonData");

// //       if (jsonData == null || !jsonData.containsKey('data') || jsonData['data'] == null) {
// //         print("Error: 'data' key is missing or null in API response.");
// //         return;
// //       }
// //       // Extract all line categories (MidCycle, ChangeOrder, IVM)
// //       List allLines = [
// //         ...?jsonData['data']['MidCycleMapLines'],
// //         ...?jsonData['data']['ChangeOrderMapLines'],
// //         ...?jsonData['data']['IVMMapLines']
// //       ];
// //       if (allLines.isEmpty) {
// //         print("Warning: No map lines available for this substation.");
// //         return;
// //       }
// //       List<Map<String, dynamic>> parsedLines = [];
// //       List<LatLng> memberPoints = [];

// //       for (var feature in allLines) {
// //         if (feature is Map<String, dynamic> && feature.containsKey('geometry')) {
// //           String geometry = feature['geometry'];
// //           String color = feature.containsKey('color') ? feature['color'] : "black"; // Default color

// //           if (geometry.startsWith("LINESTRING")) {
// //             List<LatLng> line = _parseLineString(geometry);
// //             if (line.isNotEmpty) {
// //               parsedLines.add({
// //                 "coordinates": line,
// //                 "color": _getColorFromString(color), // Convert color string to Color object
// //               });
// //             }
// //           }
// //         }
// //       }
// //        // Parse MemberData (POINT)
// //       if (jsonData['data'].containsKey('MemberData') && jsonData['data']['MemberData'] is List) {
// //         for (String point in jsonData['data']['MemberData']) {
// //           LatLng? latLng = _parsePoint(point);
// //           if (latLng != null) {
// //             memberPoints.add(latLng);
// //           }
// //         }
// //       }
// //       if (parsedLines.isNotEmpty) {
// //         print("✅ Calling _plotLayersOnMap()");
// //         _plotLayersOnMap(parsedLines, memberPoints);
// //       } else {
// //         print("⚠️ No data to plot!");
// //       }
// //     } else {
// //       print('Failed to load layers data from API: ${response.statusCode} - ${response.body}');
// //     }
// //   } catch (e) {
// //     print('Error in loading layers data: $e');
// //   }
// // }

// // Color _getColorFromString(String colorName) {
// //   Map<String, Color> colorMap = {
// //     "red": const Color.fromARGB(255, 247, 19, 2),
// //     "blue": const Color.fromARGB(255, 38, 1, 247),
// //     "green":  const Color.fromARGB(255, 1, 127, 5),
// //     "yellow": Colors.yellow,
// //     "purple": const Color.fromARGB(255, 96, 0, 113),
// //     "orange": Colors.orange,
// //     "skyblue": const Color.fromARGB(255, 2, 212, 249), // Custom color
// //     "black": Colors.black,
// //   };
// //   return colorMap[colorName.toLowerCase()] ?? Colors.black; // Default to black if not found
// // }

// // List<LatLng> _parseLineString(String lineString) {
// //   String cleanString = lineString.replaceAll("LINESTRING (", "").replaceAll(")", "");
// //   List<LatLng> coordinates = [];
// //   List<String> pairs = cleanString.split(", ");
// //   for (var pair in pairs) {
// //     List<String> values = pair.split(" ");
// //     if (values.length == 2) {
// //       double lon = double.parse(values[0]); // Longitude
// //       double lat = double.parse(values[1]); // Latitude
// //       coordinates.add(LatLng(lat, lon));
// //     }
// //   }
// //   print("Parsed LINESTRING: $coordinates");
// //   return coordinates;
// // }

// // void _plotLayersOnMap(List<Map<String, dynamic>> linesWithColors,  List<LatLng> memberPoints) {
// //   List<Polyline> polylines = [];
// //   List<Marker> markers = [];

// //   for (var lineData in linesWithColors) {
// //     List<LatLng> line = lineData["coordinates"];
// //     Color lineColor = lineData["color"];
// //     polylines.add(Polyline(
// //       points: line,
// //       color: lineColor,
// //       strokeWidth: 8.0,
// //     ));
// //   }
// //   for (LatLng point in memberPoints) {
// //   markers.add(
// //     Marker(
// //       point: point,
// //       width: 40, // Marker size
// //       height: 40,
// //      builder: (context) => InkWell(
// //       onTap: () {
// //         fetchDataAndShowDialog(
// //                                 context,
// //                                 point.longitude,
// //                                 point.latitude,
// //                               );
// //       },
// //        child: Image.asset(
// //           'assets/caution_icon.png', // Replace with your image path
// //           width: 10,
// //           height: 10,
// //         ),
// //      ),)
// //   );
// // }

// //   setState(() {
// //     myPolylines = polylines;
// //     myMarkers = markers;
// //   });
// // }

// // LatLng? _parsePoint(String pointString) {
// //   try {
// //     String cleanString = pointString.replaceAll("POINT (", "").replaceAll(")", "");
// //     List<String> values = cleanString.split(" ");
// //     if (values.length == 2) {
// //       double lon = double.parse(values[0]);
// //       double lat = double.parse(values[1]);
// //       return LatLng(lat, lon);
// //     }
// //   } catch (e) {
// //     print("Error parsing POINT: $pointString - $e");
// //   }
// //   return null;
// // }



// // // void _handlePolylineTap(LatLng tapPoint) {
// // //   double threshold = 0.0005; // Adjust threshold to detect nearby lines
// // //   for (var polyline in myPolylines) {
// // //     for (var point in polyline.points) {
// // //       if ((point.latitude - tapPoint.latitude).abs() < threshold &&
// // //           (point.longitude - tapPoint.longitude).abs() < threshold) {
// // //         String geometryString = _convertLineToGeometry(polyline.points);
// // //         print("Selected Polyline Geometry: $geometryString");
// // //         // sendGeometryToApi(geometryString);
// // //         return;
// // //       }
// // //     }
// // //   }
// // //   print("No polyline found near the tapped location.");
// // // }
// // // String _convertLineToGeometry(List<LatLng> coordinates) {
// // //   String geometry = coordinates
// // //       .map((coord) => "${coord.longitude} ${coord.latitude}")
// // //       .join(", ");
// // //   return "(($geometry))";
// // // }


// // void _handlePolylineTap(LatLng tapPoint) {
// //   print("📌 Tapped Location: Latitude = ${tapPoint.latitude}, Longitude = ${tapPoint.longitude}");
// // }

// // // void _handlePolylineTap(LatLng tapPoint) {
// // //   print("📌 Tapped Location: Latitude = ${tapPoint.latitude}, Longitude = ${tapPoint.longitude}");

// // //   // Process only myPolylines, ignoring other layers
// // //   for (var polyline in myPolylines) {
// // //     for (var point in polyline.points) {
// // //       print("📍 Polyline Point: ${point.latitude}, ${point.longitude}");
// // //     }
// // //   }
// // // }


// // }
