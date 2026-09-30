// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';

// class NewMapTest extends StatefulWidget {
//   const NewMapTest({Key? key}) : super(key: key);

//   @override
//   NewMapTestState createState() => NewMapTestState();
// }

// class NewMapTestState extends State<NewMapTest>
//     with TickerProviderStateMixin {
//   GoogleMapController? mapController; //contrller for Google map
//   Set<Marker> markers = Set(); //markers for google map

//   LatLng loc1 = LatLng(28.484279, 77.159584);  

//   int numDeltas = 50; //number of delta to devide total distance
//   int delay = 50; //milliseconds of delay to pass each delta
//   var i = 0;
//   double? deltaLat; 
//   double? deltaLng;
//   var position; //position variable while moving marker

//   @override
//   void initState() {
//     super.initState();
//     position = [loc1.latitude, loc1.longitude]; //initial position of moving marker
//     addMarkers();

//     WakelockPlus.enable();
//   }

//  addMarkers() async {
//       markers.add(
//         Marker( 
//           markerId: MarkerId(loc1.toString()),
//           position: loc1, 
//           icon: BitmapDescriptor.defaultMarker
//         )
//       );

//       setState(() {
//           //refresh UI
//       });
//   }

//   transition(result){
//       i = 0;
//       deltaLat = (result[0] - position[0])/numDeltas;
//       deltaLng = (result[1] - position[1])/numDeltas;
//       moveMarker();
//   }

//   moveMarker(){
//       position[0] += deltaLat;
//       position[1] += deltaLng;
//       var latlng = LatLng(position[0], position[1]);
      
//       markers = {
//         Marker(
//             markerId: MarkerId("movingmarker"),
//             position: latlng,
//             icon: BitmapDescriptor.defaultMarker,
//         )
//       };

//       setState(() {
//          //refresh UI
//       });
    

//       if(i!=numDeltas){
//           i++;
//           Future.delayed(Duration(milliseconds: delay), (){
//               moveMarker();
//           });
//       }
//   }

//   @override
//   void dispose() {
//     WakelockPlus.disable();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//      return  Scaffold(
//           appBar: AppBar( 
//              title: Text("Move Marker Position on Google Map"),
//              backgroundColor: Colors.deepPurpleAccent,
//           ),
//           floatingActionButton: FloatingActionButton(
//              child: Text("Move"),
//              onPressed: (){
//                  var result = [28.485323, 77.157542];
//                  //latitude and longitude of new position

//                  transition(result);
//                  //start moving marker
//              },
//           ),
//           body: GoogleMap( //Map widget from google_maps_flutter package
//                   zoomGesturesEnabled: true, //enable Zoom in, out on map
//                   initialCameraPosition: CameraPosition( //innital position in map
//                     target: loc1, //initial position
//                     zoom: 17.0, //initial zoom level
//                   ),
//                   markers: markers, //markers to show on map
//                   mapType: MapType.normal, //map type
//                   onMapCreated: (controller) { //method called when map is created
//                     setState(() {
//                       mapController = controller; 
//                     });
//                   },
//           )
//        );
// }
  
// }


