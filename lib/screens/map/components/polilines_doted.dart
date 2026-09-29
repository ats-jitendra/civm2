// // // // import 'dart:math';
// // // // import 'dart:ui';
// // // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // // class MapPolylineHelper {
// // // //   static Set<Polyline> createPolylines() {
// // // //     // Define separate sets of points for each line
// // // //     List<LatLng> line1 = [
// // // //       LatLng(47.0693083392409, -93.1539033292594),
// // // //       LatLng(47.0694374848388, -93.1530638100798),
// // // //     ];
// // // //     List<LatLng> line2 = [
// // // //       LatLng(47.0855783000088, -93.0938638),
// // // //       LatLng(47.0855776861665, -93.0939641859492),
// // // //     ];

// // // //     Set<Polyline> polylines = {};
// // // //     polylines.addAll(createDottedPolyline(line1, 0.0001, 'route2'));
// // // //     polylines.addAll(createDottedPolyline(line2, 0.0001, 'route3'));

// // // //     return polylines;
// // // //   }

// // // //   static Set<Polyline> createDottedPolyline(
// // // //       List<LatLng> points, double segmentLength, String baseId) {
// // // //     Set<Polyline> polylines = {};
// // // //     int polylineIdCount = 1;

// // // //     for (int i = 0; i < points.length - 1; i++) {
// // // //       LatLng start = points[i];
// // // //       LatLng end = points[i + 1];
// // // //       List<LatLng> dottedSegment = _generateSegments(start, end, segmentLength);

// // // //       for (int j = 0; j < dottedSegment.length - 1; j += 2) {
// // // //         polylines.add(
// // // //           Polyline(
// // // //             polylineId: PolylineId('${baseId}_$polylineIdCount'),
// // // //             points: [dottedSegment[j], dottedSegment[j + 1]],
// // // //             color: const Color.fromARGB(255, 1, 100, 4),
// // // //             width: 5,
// // // //           ),
// // // //         );
// // // //         polylineIdCount++;
// // // //       }
// // // //     }
// // // //     return polylines;
// // // //   }

// // // //   static List<LatLng> _generateSegments(LatLng start, LatLng end, double segmentLength) {
// // // //     List<LatLng> segments = [];
// // // //     double distance = _calculateDistance(start, end);
// // // //     int totalSegments = (distance / segmentLength).ceil();

// // // //     for (int i = 0; i <= totalSegments; i++) {
// // // //       double fraction = i / totalSegments;
// // // //       double lat = start.latitude + (end.latitude - start.latitude) * fraction;
// // // //       double lng = start.longitude + (end.longitude - start.longitude) * fraction;
// // // //       segments.add(LatLng(lat, lng));
// // // //     }

// // // //     return segments;
// // // //   }

// // // //   static double _calculateDistance(LatLng start, LatLng end) {
// // // //     const double earthRadius = 6371000;
// // // //     double dLat = _toRadians(end.latitude - start.latitude);
// // // //     double dLon = _toRadians(end.longitude - start.longitude);
// // // //     double a = sin(dLat / 2) * sin(dLat / 2) +
// // // //         cos(_toRadians(start.latitude)) * cos(_toRadians(end.latitude)) *
// // // //             sin(dLon / 2) * sin(dLon / 2);
// // // //     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
// // // //     return earthRadius * c;
// // // //   }

// // // //   static double _toRadians(double degree) {
// // // //     return degree * pi / 180;
// // // //   }
// // // // }























// // // import 'dart:math';
// // // import 'dart:ui';
// // // import 'package:flutter/material.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // class MapPolylineHelper {
// // //   /// Creates a set of polylines including both solid and dotted lines.
// // //   static Set<Polyline> createPolylines() {
// // //     Set<Polyline> polylines = {};

// // //     // Add Solid Polylines
// // //     polylines.add(
// // //       const Polyline(
// // //         polylineId: PolylineId('route4'),
// // //         points: [
// // //           LatLng(46.9402822348143, -93.2620857915419),
// // //           LatLng(46.9402576533952, -93.260914919532),
// // //         ],
// // //         color: Color.fromARGB(255, 1, 100, 4),
// // //         width: 5,
// // //       ),
// // //     );

// // //     polylines.add(
// // //       const Polyline(
// // //         polylineId: PolylineId('route5'),
// // //         points: [
// // //           LatLng(46.9506120157871, -93.2744712167776),
// // //           LatLng(46.9500918014193, -93.2747873659341),
// // //         ],
// // //         color: Color.fromARGB(255, 1, 100, 4),
// // //         width: 5,
// // //       ),
// // //     );

// // //     // Add Dotted Polylines
// // //     polylines.addAll(createDottedPolyline(
// // //       [
// // //         LatLng(47.0693083392409, -93.1539033292594),
// // //         LatLng(47.0694374848388, -93.1530638100798),
// // //       ],
// // //       0.0001, // Adjust segment length for density
// // //       'route2_dotted',
// // //        Colors.blue,
// // //       5,
// // //     ));

// // //     polylines.addAll(createDottedPolyline(
// // //       [
// // //         LatLng(47.0855783000088, -93.0938638),
// // //         LatLng(47.0855776861665, -93.0939641859492),
// // //       ],
// // //       0.0001, // Adjust segment length for density
// // //       'route3_dotted',
// // //     Colors.blue,
// // //       5,
// // //     ));

// // //     return polylines;
// // //   }

// // //   /// Creates dotted polylines by splitting the main line into smaller segments with gaps.
// // //   static Set<Polyline> createDottedPolyline(
// // //     List<LatLng> points,
// // //     double segmentLength,
// // //     String baseId,
// // //     Color color,
// // //     int width,
// // //   ) {
// // //     Set<Polyline> polylines = {};
// // //     int polylineIdCount = 1;

// // //     for (int i = 0; i < points.length - 1; i++) {
// // //       LatLng start = points[i];
// // //       LatLng end = points[i + 1];
// // //       List<LatLng> dottedSegment = _generateSegments(start, end, segmentLength);

// // //       // Create polylines for every other segment to simulate dots
// // //       for (int j = 0; j < dottedSegment.length - 1; j += 2) {
// // //         polylines.add(
// // //           Polyline(
// // //             polylineId: PolylineId('${baseId}_$polylineIdCount'),
// // //             points: [dottedSegment[j], dottedSegment[j + 1]],
// // //             color: color,
// // //             width: width,
// // //           ),
// // //         );
// // //         polylineIdCount++;
// // //       }
// // //     }
// // //     return polylines;
// // //   }

// // //   /// Generates a list of LatLng points between start and end with the specified segment length.
// // //   static List<LatLng> _generateSegments(
// // //       LatLng start, LatLng end, double segmentLength) {
// // //     List<LatLng> segments = [];
// // //     double distance = _calculateDistance(start, end);
// // //     int totalSegments = (distance / segmentLength).ceil();

// // //     for (int i = 0; i <= totalSegments; i++) {
// // //       double fraction = i / totalSegments;
// // //       double lat = start.latitude + (end.latitude - start.latitude) * fraction;
// // //       double lng = start.longitude + (end.longitude - start.longitude) * fraction;
// // //       segments.add(LatLng(lat, lng));
// // //     }

// // //     return segments;
// // //   }

// // //   /// Calculates the distance between two LatLng points using the Haversine formula.
// // //   static double _calculateDistance(LatLng start, LatLng end) {
// // //     const double earthRadius = 6371000; // in meters
// // //     double dLat = _toRadians(end.latitude - start.latitude);
// // //     double dLon = _toRadians(end.longitude - start.longitude);
// // //     double a = sin(dLat / 2) * sin(dLat / 2) +
// // //         cos(_toRadians(start.latitude)) *
// // //             cos(_toRadians(end.latitude)) *
// // //             sin(dLon / 2) *
// // //             sin(dLon / 2);
// // //     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
// // //     return earthRadius * c;
// // //   }

// // //   /// Converts degrees to radians.
// // //   static double _toRadians(double degree) {
// // //     return degree * pi / 180;
// // //   }
// // // }


















// import 'dart:math';
// import 'dart:ui';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPolylineDotedHelper {
//   static Set<Polyline> createPolylines() {
//     Set<Polyline> polylines = {
//       // Solid line polylines
//       const Polyline(
//         polylineId: PolylineId('route4'),
//         points: [
//           LatLng(46.9402822348143, -93.2620857915419),
//           LatLng(46.9402576533952, -93.260914919532),
//         ],
//         color: Color.fromARGB(255, 132, 2, 152),
//         width: 5,
//       ),
//       const Polyline(
//         polylineId: PolylineId('route5'),
//         points: [
//           LatLng(46.9506120157871, -93.2744712167776),
//           LatLng(46.9500918014193, -93.2747873659341)
//         ],
//         color: Color.fromARGB(255, 1, 100, 4),
//         width: 5,
//       ),
//     };

//     // Dotted line polylines
//     polylines.addAll(createDottedPolyline([
//       LatLng(47.0693083392409, -93.1539033292594),
//       LatLng(47.0694374848388, -93.1530638100798),
//     ], 0.0001, 'route2'));

//     polylines.addAll(createDottedPolyline([
//       LatLng(47.0855783000088, -93.0938638),
//       LatLng(47.0855776861665, -93.0939641859492),
//     ], 0.0001, 'route3'));

//     return polylines;
//   }

//   static Set<Polyline> createDottedPolyline(
//       List<LatLng> points, double segmentLength, String baseId) {
//     Set<Polyline> polylines = {};
//     int polylineIdCount = 1;

//     for (int i = 0; i < points.length - 1; i++) {
//       LatLng start = points[i];
//       LatLng end = points[i + 1];
//       List<LatLng> dottedSegment = _generateSegments(start, end, segmentLength);

//       for (int j = 0; j < dottedSegment.length - 1; j += 2) {
//         polylines.add(
//           Polyline(
//             polylineId: PolylineId('${baseId}_$polylineIdCount'),
//             points: [dottedSegment[j], dottedSegment[j + 1]],
//             color: const Color.fromARGB(255, 1, 100, 4),
//             width: 5,
//           ),
//         );
//         polylineIdCount++;
//       }
//     }
//     return polylines;
//   }

//   static List<LatLng> _generateSegments(LatLng start, LatLng end, double segmentLength) {
//     List<LatLng> segments = [];
//     double distance = _calculateDistance(start, end);
//     int totalSegments = (distance / segmentLength).ceil();

//     for (int i = 0; i <= totalSegments; i++) {
//       double fraction = i / totalSegments;
//       double lat = start.latitude + (end.latitude - start.latitude) * fraction;
//       double lng = start.longitude + (end.longitude - start.longitude) * fraction;
//       segments.add(LatLng(lat, lng));
//     }

//     return segments;
//   }

//   static double _calculateDistance(LatLng start, LatLng end) {
//     const double earthRadius = 6371000;
//     double dLat = _toRadians(end.latitude - start.latitude);
//     double dLon = _toRadians(end.longitude - start.longitude);
//     double a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(_toRadians(start.latitude)) * cos(_toRadians(end.latitude)) *
//             sin(dLon / 2) * sin(dLon / 2);
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     return earthRadius * c;
//   }

//   static double _toRadians(double degree) {
//     return degree * pi / 180;
//   }
// }
