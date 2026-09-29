// import 'dart:async';
// import 'package:CIVM/screens/map/components/polilines.dart';
// import 'package:CIVM/screens/map/components/polilines_doted.dart';
// import 'package:CIVM/screens/map/components/polygons.dart';
// import 'package:CIVM/screens/map/components/polyline_points.dart';
// import 'package:CIVM/screens/map/models/user_location.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMapWidget extends StatefulWidget {
//   const GoogleMapWidget({
//     Key? key,
//     required this.initialCameraPosition,
//     required this.locationProvider,
//     required Completer<GoogleMapController> controller,
//     required Set<Marker> markers,
//   }) : super(key: key);

//   final CameraPosition initialCameraPosition;
//   final UserLocation locationProvider;

//   @override
//   _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
// }

// class _GoogleMapWidgetState extends State<GoogleMapWidget> {
//   final Completer<GoogleMapController> _controller = Completer();
//   Set<Polygon> _polygons = {};
//   Offset? _polygonLabelPosition;
//   Set<Marker> _markers = {};

//   GoogleMapController? _mapController;
//   LatLng _textPosition = const LatLng(47.0552778, -92.9569444);
//   Offset? _textOffset;
//   bool _mapIsReady = false;
//   late UserLocation locationProvider = UserLocation(47.055, -92.957);

//   @override
//   void initState() {
//     super.initState();
//     _polygons = MapPolygonHelper.createPolygons();
//     // _createPolygons();
//     _addMarker();
//     // _addIndependentMarkers();
//     _loadIndependentMarkers();
//     // MapPolylinePointsHelper.getIndependentMarkers();
//     MapPolylinePointsHelper.getColoredMarkers();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // _updatePolygonLabelPosition();
//     });
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
//           // polylines: _createPolylines(),
//           // polygons: _polygons,
//           polylines:
//           // MapPolylineDotedHelper.createPolylines(),
//            MapPolylineHelper.createPolylines(),
//           polygons: _polygons,
//           markers: _markers,
//           onMapCreated: (GoogleMapController controller) async {
//             // _controller.complete(controller);
//             _mapController = controller;
//             setState(() {
//               _mapIsReady = true;
//             });
//             await _calculateTextPosition();
//             // _updatePolygonLabelPosition();
//           },
//           onCameraMove: (position) {
//             // _updatePolygonLabelPosition();
//             _calculateTextPosition();
//           },
//         ),
//         if (_polygonLabelPosition != null)
//           Positioned(
//             left: _polygonLabelPosition!.dx,
//             top: _polygonLabelPosition!.dy,
//             child: Container(
//               // color: Colors.white70,
//               padding: const EdgeInsets.all(4),
//               child: const Text(
//                 "Cedar Valley",
//                 style: TextStyle(color: Colors.red, fontSize: 14),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   void _addMarker() {
//     setState(() {
//       _markers.add(Marker(
//         markerId: const MarkerId('1111111111111111111111111111111111'),
//         position: _textPosition,
//         // infoWindow: InfoWindow(title: '1111111111111111111111111111111111'),
//         infoWindow: const InfoWindow(
//           title: 'Cedar Valley',
//           // snippet: 'This is a sample text',
//         ),
//       ));
//     });
//   }

//   ////////////multiple Markers/////////////////////////////////////////////
//   ///void _addMarkers() {
//   //   List<LatLng> markerPositions = [
//   //     const LatLng(47.0552778, -92.9569444),
//   //     const LatLng(47.2611111, -92.9777777),
//   //     // Add more positions as needed
//   //   ];

//   //   for (var position in markerPositions) {
//   //     _markers.add(
//   //       Marker(
//   //         markerId: MarkerId(position.toString()),
//   //         position: position,
//   //         infoWindow: InfoWindow(
//   //           title: 'Marker at ${position.latitude}, ${position.longitude}',
//   //         ),
//   //         icon: BitmapDescriptor.defaultMarker,
//   //       ),
//   //     );
//   //   }
//   // }
// /////////////////////////////////////////////

//   Future<void> _calculateTextPosition() async {
//     if (_mapController == null) return;

//     ScreenCoordinate screenCoord =
//         await _mapController!.getScreenCoordinate(_textPosition);
//     setState(() {
//       _textOffset = Offset(screenCoord.x.toDouble(), screenCoord.y.toDouble());
//     });
//   }

//   Future<void> _loadIndependentMarkers() async {
//     // Set<Marker> markers = await MapPolylinePointsHelper.getIndependentMarkers();
//      Set<Marker> markers = await MapPolylinePointsHelper.getColoredMarkers();
//     setState(() {
//       _markers.addAll(markers); // Add the markers to the set
//     });
//   }
// }
