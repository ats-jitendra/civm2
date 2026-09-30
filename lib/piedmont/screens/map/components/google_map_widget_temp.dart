// import 'dart:async';
// import 'dart:convert';
// import 'package:CIVM/piedmont/screens/map/components/polygons.dart';
// import 'package:CIVM/piedmont/screens/map/components/polyline_points.dart';
// import 'package:CIVM/piedmont/screens/map/models/user_location.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMapWidgetTemp extends StatefulWidget {
//   const GoogleMapWidgetTemp({
//     Key? key,
//     required this.initialCameraPosition,
//     required this.locationProvider,
//     required Completer<GoogleMapController> controller,
//     required Set<Marker> markers,
//   }) : super(key: key);

//   final CameraPosition initialCameraPosition;
//   final UserLocation locationProvider;

//   @override
//   _GoogleMapWidgetTempState createState() => _GoogleMapWidgetTempState();
// }

// class _GoogleMapWidgetTempState extends State<GoogleMapWidgetTemp> {
//   final Completer<GoogleMapController> _controller = Completer();
//   Set<Polygon> _polygons = {};
//   Set<Marker> _markers = {};

//   GoogleMapController? _mapController;

//   LatLng _textPosition = const LatLng(47.0552778, -92.9569444);
//   Offset? _textOffset;

//   @override
//   void initState() {
//     super.initState();

//     _polygons = MapPolygonHelper.createPolygons();
//     _addMarker();
//     _loadIndependentMarkers();
//     _loadGeoJsonPolygons(); // ✅ FIXED METHOD
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GoogleMap(
//           initialCameraPosition: widget.initialCameraPosition,
//           myLocationEnabled: true,
//           mapToolbarEnabled: true,
//           mapType: MapType.normal,
//           myLocationButtonEnabled: true,

//           polygons: _polygons,
//           markers: _markers, // ✅ IMPORTANT (you missed this)

//           onMapCreated: (GoogleMapController controller) async {
//             _mapController = controller;
//             await _calculateTextPosition();
//           },

//           onCameraMove: (position) {
//             _calculateTextPosition();
//           },
//         ),
//       ],
//     );
//   }

//   void _addMarker() {
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('1'),
//         position: _textPosition,
//         infoWindow: const InfoWindow(title: 'Cedar Valley'),
//       ),
//     );
//   }

//   Future<void> _calculateTextPosition() async {
//     if (_mapController == null) return;

//     ScreenCoordinate screenCoord =
//         await _mapController!.getScreenCoordinate(_textPosition);

//     setState(() {
//       _textOffset = Offset(
//         screenCoord.x.toDouble(),
//         screenCoord.y.toDouble(),
//       );
//     });
//   }

//   Future<void> _loadIndependentMarkers() async {
//     Set<Marker> markers =
//         await MapPolylinePointsHelper.getColoredMarkers();

//     setState(() {
//       _markers.addAll(markers);
//     });
//   }

//   /// ✅ FULLY FIXED GEOJSON PARSER (NO PACKAGE NEEDED)
//   Future<void> _loadGeoJsonPolygons() async {
//     String geoJsonString =
//         await rootBundle.loadString('assets/sub_boundary_json.geojson');

//     final data = jsonDecode(geoJsonString);

//     Set<Polygon> newPolygons = {};

//     for (var feature in data['features']) {
//       final geometry = feature['geometry'];
//       final type = geometry['type'];

//       if (type == 'Polygon') {
//         final coordinates = geometry['coordinates'];

//         for (var ring in coordinates) {
//           List<LatLng> points = ring
//               .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
//               .toList();

//           newPolygons.add(
//             Polygon(
//               polygonId: PolygonId(
//                   feature['properties']?['name'] ?? UniqueKey().toString()),
//               points: points,
//               strokeColor: Colors.red,
//               fillColor: Colors.red.withOpacity(0.3),
//               strokeWidth: 2,
//             ),
//           );
//         }
//       }

//       else if (type == 'MultiPolygon') {
//         final coordinates = geometry['coordinates'];

//         for (var polygon in coordinates) {
//           for (var ring in polygon) {
//             List<LatLng> points = ring
//                 .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
//                 .toList();

//             newPolygons.add(
//               Polygon(
//                 polygonId: PolygonId(
//                     feature['properties']?['name'] ??
//                         UniqueKey().toString()),
//                 points: points,
//                 strokeColor: Colors.blue,
//                 fillColor: Colors.blue.withOpacity(0.3),
//                 strokeWidth: 2,
//               ),
//             );
//           }
//         }
//       }
//     }

//     setState(() {
//       _polygons.addAll(newPolygons);
//     });
//   }
// }