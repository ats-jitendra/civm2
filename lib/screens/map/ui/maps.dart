// import 'package:CIVM/screens/map/components/google_map_widget_temp.dart';
// import 'package:CIVM/screens/map/components/google_maps_widget.dart';
// import 'package:CIVM/screens/map/models/user_location.dart';
// import 'package:CIVM/screens/map/provider/location_provider.dart';
// import 'package:CIVM/screens/map/services/location_services.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';

// class Maps extends StatefulWidget {
//   @override
//   _MapsState createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch the location when the widget initializes
//     Provider.of<LocationProvider>(context, listen: false).getLocation();
//   }

//   @override
//   void dispose() {
//     LocationServices().closeLocation();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var locationProvider = Provider.of<LocationProvider>(context);
//     print(locationProvider.userLocation);
//     return Scaffold(
//       appBar: AppBar(),
//       body: StreamProvider<UserLocation>(
//           initialData: locationProvider.userLocation,
//           create: (context) => LocationServices().locationStream,
//           child: MapsScreen()),
//     );
//   }
// }

// const double cameraZoom = 15;
// const double cameraTilt = 50;
// const double cameraBearing = 30;

// class MapsScreen extends StatefulWidget {
//   @override
//   _MapsScreenState createState() => _MapsScreenState();
// }

// class _MapsScreenState extends State<MapsScreen> {
//   late Position position;
//   late GoogleMapController mapControler;
//   Completer<GoogleMapController> _controller = Completer();
//   late LatLng lastPosition;
//   final Set<Marker> _markers = {};

//   void dispose() {
//     LocationServices().closeLocation();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Consumer(builder: (context, LocationProvider provider, _) {
//       if (provider.status == LocationProviderStatus.Loading ||
//           provider.status == LocationProviderStatus.Initial) {
//         return Center(child: CircularProgressIndicator());
//       } else if (provider.status == LocationProviderStatus.Success) {
//         var locationProvider = Provider.of<UserLocation>(context);

//         CameraPosition initialCameraPosition = CameraPosition(
//             zoom: cameraZoom,
//             target:
//                 LatLng(locationProvider.latitude, locationProvider.longitude));
//         lastPosition = initialCameraPosition.target;

//         animatedViewofMap(
//             lat: locationProvider.latitude, lng: locationProvider.longitude);

//         return Stack(children: [
//           // GoogleMapWidget(
//           //     markers: _markers,
//           //     initialCameraPosition: initialCameraPosition,
//           //     controller: _controller,
//           //     locationProvider: locationProvider),

//             GoogleMapWidgetTemp(
//               markers: _markers,
//               initialCameraPosition: initialCameraPosition,
//               controller: _controller,
//               locationProvider: locationProvider),
//         ]);
//       } else {
//         return Center(child: Text("We can't reach your location"));
//       }
//     }));
//   }

//   void animatedViewofMap({required double lat, required double lng}) async {
//     CameraPosition cPosition = CameraPosition(
//       zoom: cameraZoom,
//       target: LatLng(lat, lng),
//     );
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//   }
// }


// /////////////////////////////////////////////////////////////////////////
// // import 'dart:async';
// // import 'dart:math' as math;
// // import 'package:CIVM/screens/map/lib/components/google_maps_widget.dart';
// // import 'package:CIVM/screens/map/lib/models/user_location.dart';
// // import 'package:CIVM/screens/map/lib/provider/location_provider.dart';
// // import 'package:CIVM/screens/map/lib/services/location_services.dart';
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:provider/provider.dart';

// // class Maps extends StatefulWidget {
// //   @override
// //   _MapsState createState() => _MapsState();
// // }

// // class _MapsState extends State<Maps> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     Provider.of<LocationProvider>(context, listen: false).getLocation();
// //   }

// //   @override
// //   void dispose() {
// //     LocationServices().closeLocation();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     var locationProvider = Provider.of<LocationProvider>(context);
// //     print(locationProvider.userLocation);
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: StreamProvider<UserLocation>(
// //           initialData: locationProvider.userLocation,
// //           create: (context) => LocationServices().locationStream,
// //           child: MapsScreen()),
// //     );
// //   }
// // }

// // const double cameraZoom = 15;
// // const double cameraTilt = 50;
// // const double cameraBearing = 30;

// // class MapsScreen extends StatefulWidget {
// //   @override
// //   _MapsScreenState createState() => _MapsScreenState();
// // }

// // class _MapsScreenState extends State<MapsScreen> {
// //   late Position position;
// //   late GoogleMapController mapController;
// //   Completer<GoogleMapController> _controller = Completer();
// //   late LatLng lastPosition;
// //   final Set<Marker> _markers = {};
// //   double bearing = 0.0; // To store the user's heading direction

// //   @override
// //   void initState() {
// //     super.initState();
// //     _startListeningToHeading();
// //   }

// //   @override
// //   void dispose() {
// //     LocationServices().closeLocation();
// //     super.dispose();
// //   }

// //   // Listen to heading changes
// //   void _startListeningToHeading() {
// //     Geolocator.getPositionStream().listen((Position position) {
// //       setState(() {
// //         bearing = position.heading;
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Consumer<LocationProvider>(builder: (context, provider, _) {
// //         if (provider.status == LocationProviderStatus.Loading ||
// //             provider.status == LocationProviderStatus.Initial) {
// //           return Center(child: CircularProgressIndicator());
// //         } else if (provider.status == LocationProviderStatus.Success) {
// //           var locationProvider = Provider.of<UserLocation>(context);

// //           CameraPosition initialCameraPosition = CameraPosition(
// //             zoom: cameraZoom,
// //             target: LatLng(locationProvider.latitude, locationProvider.longitude),
// //           );
// //           lastPosition = initialCameraPosition.target;

// //           animatedViewofMap(
// //               lat: locationProvider.latitude, lng: locationProvider.longitude);

// //           return Stack(
// //             children: [
// //               GoogleMapWidget(
// //                 markers: _markers,
// //                 initialCameraPosition: initialCameraPosition,
// //                 controller: _controller,
// //                 locationProvider: locationProvider,
// //               ),
// //               // Overlay the arrow on top of the map, rotating it based on the bearing
// //               Positioned(
// //                 bottom: 30,
// //                 left: MediaQuery.of(context).size.width / 2 - 25, // Center the arrow
// //                 child: Transform.rotate(
// //                   angle: bearing * (math.pi / 180), // Convert degrees to radians
// //                   child: Icon(
// //                     Icons.navigation,
// //                     color: Colors.blue,
// //                     size: 50, // Set size for a larger arrow
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           );
// //         } else {
// //           return Center(child: Text("We can't reach your location"));
// //         }
// //       }),
// //     );
// //   }

// //   void animatedViewofMap({required double lat, required double lng}) async {
// //     CameraPosition cPosition = CameraPosition(
// //       zoom: cameraZoom,
// //       target: LatLng(lat, lng),
// //     );
// //     final GoogleMapController controller = await _controller.future;
// //     controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
// //   }
// // }
// ////////////////////////////////////////////////////////////////////////










// // import 'dart:async';
// // import 'dart:typed_data';
// // import 'dart:ui' as ui;
// // import 'dart:math' as math;
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:provider/provider.dart';
// // import 'package:google_map_in_flutter/models/user_location.dart';
// // import 'package:google_map_in_flutter/provider/location_provider.dart';
// // import 'package:google_map_in_flutter/services/location_services.dart';

// // class Maps extends StatefulWidget {
// //   @override
// //   _MapsState createState() => _MapsState();
// // }

// // class _MapsState extends State<Maps> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     Provider.of<LocationProvider>(context, listen: false).getLocation();
// //   }

// //   @override
// //   void dispose() {
// //     LocationServices().closeLocation();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     var locationProvider = Provider.of<LocationProvider>(context);
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: StreamProvider<UserLocation>(
// //         initialData: locationProvider.userLocation,
// //         create: (context) => LocationServices().locationStream,
// //         child: MapsScreen(),
// //       ),
// //     );
// //   }
// // }

// // const double cameraZoom = 15;

// // class MapsScreen extends StatefulWidget {
// //   @override
// //   _MapsScreenState createState() => _MapsScreenState();
// // }

// // class _MapsScreenState extends State<MapsScreen> {
// //   late GoogleMapController mapController;
// //   Completer<GoogleMapController> _controller = Completer();
// //   late LatLng userPosition;
// //   final Set<Marker> _markers = {};
// //   double userHeading = 0.0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _startListeningToLocationAndHeading();
// //   }

// //   void _startListeningToLocationAndHeading() {
// //     Geolocator.getPositionStream().listen((Position position) {
// //       setState(() {
// //         userPosition = LatLng(position.latitude, position.longitude);
// //         userHeading = position.heading;
// //         _updateMarker();
// //       });
// //     });
// //   }

// //   Future<void> _updateMarker() async {
// //     final BitmapDescriptor customIcon = await _getRotatedMarkerIcon(userHeading);
// //     setState(() {
// //       _markers.clear();
// //       _markers.add(
// //         Marker(
// //           markerId: MarkerId("user_location"),
// //           position: userPosition,
// //           icon: customIcon,
// //           rotation: userHeading, // Ensures the marker rotates with the heading
// //           anchor: Offset(0.5, 0.5), // Center the icon on the location
// //         ),
// //       );
// //     });
// //   }

// // Future<BitmapDescriptor> _getRotatedMarkerIcon(double rotationAngle) async {
// //   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
// //   final Canvas canvas = Canvas(pictureRecorder);
// //   final Paint paint = Paint()..color = Colors.blue; // Set the arrow color

// //   // Arrow dimensions
// //   final double arrowWidth = 20; // Width of the arrowhead
// //   final double arrowHeight = 40; // Height of the arrowhead
// //   final double tailLength = 10; // Length of the tail

// //   // Create the arrow shape
// //   Path arrowPath = Path()
// //     ..moveTo(0, -arrowHeight) // Tip of the arrow
// //     ..lineTo(-arrowWidth / 2, 0) // Left base
// //     ..lineTo(0, -arrowHeight + tailLength) // Tail start
// //     ..lineTo(arrowWidth / 2, 0) // Right base
// //     ..close(); // Close the path to form the arrowhead

// //   // Move the canvas to the center of the arrow shape and rotate
// //   canvas.translate(arrowWidth / 2, (arrowHeight + tailLength) / 2); // Center the arrow on the canvas
// //   canvas.rotate(rotationAngle * math.pi / 180); // Rotate canvas to match heading

// //   // Draw the arrow
// //   canvas.drawPath(arrowPath, paint);

// //   // Create an image from the canvas
// //   final ui.Image image = await pictureRecorder.endRecording().toImage(
// //     arrowWidth.toInt(),
// //     (arrowHeight + tailLength).toInt(),
// //   );
// //   final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
// //   final Uint8List pngBytes = byteData!.buffer.asUint8List();

// //   // Use BitmapDescriptor.bytes instead of fromBytes
// //   return BitmapDescriptor.bytes(pngBytes, width: arrowWidth.toDouble(), height: (arrowHeight + tailLength).toDouble());
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Consumer<LocationProvider>(builder: (context, provider, _) {
// //         if (provider.status == LocationProviderStatus.Loading ||
// //             provider.status == LocationProviderStatus.Initial) {
// //           return Center(child: CircularProgressIndicator());
// //         } else if (provider.status == LocationProviderStatus.Success) {
// //           var locationProvider = Provider.of<UserLocation>(context);
// //           userPosition = LatLng(locationProvider.latitude, locationProvider.longitude);
          
// //           CameraPosition initialCameraPosition = CameraPosition(
// //             zoom: cameraZoom,
// //             target: userPosition,
// //           );

// //           return GoogleMap(
// //             onMapCreated: (GoogleMapController controller) {
// //               _controller.complete(controller);
// //               mapController = controller;
// //             },
// //             markers: _markers,
// //             initialCameraPosition: initialCameraPosition,
// //           );
// //         } else {
// //           return Center(child: Text("We can't reach your location"));
// //         }
// //       }),
// //     );
// //   }
// // }
