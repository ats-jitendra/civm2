// import 'package:civm/controllers/test_controller.dart';
// import 'package:civm/models/album.dart';
// import 'package:civm/services/api_services.dart';
// import 'package:flutter/material.dart'; 

// class DailyHerbicideApplicationReport extends StatefulWidget {
//   const DailyHerbicideApplicationReport({Key? key}) : super(key: key);

//   @override
//   State<DailyHerbicideApplicationReport> createState() =>
//       _DailyHerbicideApplicationReportState();
// }

// class _DailyHerbicideApplicationReportState
//     extends State<DailyHerbicideApplicationReport> {
//   final equipment = [
//     'Pickup',
//     'All Terrain Sprayer',
//     'Skidder/Bombardier',
//     'Other'
//   ];
//   String? value;

//   final labor = ['Foreman', 'Operator', 'Laborer'];
//   String? value1;

//   TimeOfDay _applicationStartTime = const TimeOfDay(hour: 00, minute: 00);
//   TimeOfDay _applicationEndTime = const TimeOfDay(hour: 00, minute: 00);
//   TimeOfDay _breakStartTime = const TimeOfDay(hour: 00, minute: 00);
//   TimeOfDay _breakEndTime = const TimeOfDay(hour: 00, minute: 00);
//   TimeOfDay _Time = const TimeOfDay(hour: 00, minute: 00);

//   var isLoaded = false;
//   final controller = TestController();

//   @override
//   Widget build(BuildContext context) {
//     Color hexToColor(String code) {
//       return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       // drawer: DrawerClass(),
//       appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text('Daily Herbicide Application Report',
//             style: TextStyle(color: Colors.white),),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//             child: Column(children: [
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: Row(children: [
//               const Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Date : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextField(
//                       // getCurrentDate1(),
//                       enabled: false,
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         labelText: getCurrentDate(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Job Number : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Job Number ',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Foreman : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Foreman',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Outpost Area : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Outpost Area',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Map/Line Number : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Map/Line Number',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Sub Number : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Sub Number',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Circuit Number : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Circuit Number',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             color: Colors.blue,
//             padding: const EdgeInsets.all(4),
//             height: 40,
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: Text(
//                       "Herbicide ",
//                       style: TextStyle(
//                           fontSize: 20.0,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "SEC-TWP-RGN Road/Pole Number : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'SEC-TWP-RGN Road/Pole Number',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Product Name : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Product Name',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "EPA Number : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'EPA Number',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Applied Rate per Gallon : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Applied Rate per Gallon',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Gallons of Solution : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Gallons of Solution',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Row Width 20 : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Row Width 20',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Row Width 30 : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Row Width 30',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Row Width 40 : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Row Width 40',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Row Width 50 : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Row Width 50',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Row Width 60 : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Row Width 60',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Row Width 70 : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Row Width 70',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Row Width 80 : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Row Width 80',
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Acres per Section : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Acres per Section',
//                         ),
//                         keyboardType: TextInputType.number),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//               margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//               child: InkWell(
//                 onTap: () {},
//                 child: Container(
//                   margin: const EdgeInsets.only(
//                       left: 40, right: 40, top: 10.0, bottom: 10.0),
//                   padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.blue,
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Colors.blue,
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 148, 207, 255),
//                           Colors.blue
//                         ],
//                       )),
//                   child: const Row(children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Add Herbicide",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//               )),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Total Gallons of Solution : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: TextField(
//                       enabled: false,
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: '0',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Total Acres Applied : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     enabled: false,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: '0',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             color: Colors.blue,
//             padding: const EdgeInsets.all(4),
//             height: 40,
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Equipment ",
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: Row(
//               children: [
//                 const Expanded(
//                   child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           "Equipment : ",
//                           style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                         ),
//                       )),
//                 ),
//                 Expanded(
//                     child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: Container(
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4.5),
//                         border: Border.all(
//                             color: const Color.fromARGB(255, 136, 130, 130)),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           hint: const Text('Select Equipment'),
//                           value: value,
//                           icon: const Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.black,
//                           ),
//                           isExpanded: true,
//                           items: equipment.map(buildMenuItem).toList(),
//                           onChanged: (value) =>
//                               setState(() => this.value = value),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ))
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Equipment Number : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Equipment Number',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Quantity : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Quantity',
//                       ),
//                       keyboardType: TextInputType.number),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Hours Each : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Hours Each',
//                       ),
//                       keyboardType: TextInputType.number),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Total Hours : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     enabled: false,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: '0',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//               margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//               child: InkWell(
//                 onTap: () {},
//                 child: Container(
//                   margin: const EdgeInsets.only(
//                       left: 40, right: 40, top: 10.0, bottom: 10.0),
//                   padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.blue,
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Colors.blue,
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 148, 207, 255),
//                           Colors.blue
//                         ],
//                       )),
//                   child: const Row(children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Add Another Equipment",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//               )),
//           Container(
//             color: Colors.blue,
//             padding: const EdgeInsets.all(4),
//             height: 40,
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Labor ",
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: Row(
//               children: [
//                 const Expanded(
//                   child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           "Labor : ",
//                           style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                         ),
//                       )),
//                 ),
//                 Expanded(
//                     child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: Container(
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4.5),
//                         border: Border.all(
//                             color: const Color.fromARGB(255, 136, 130, 130)),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           hint: const Text('Select Labor'),
//                           value: value1,
//                           icon: const Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.black,
//                           ),
//                           isExpanded: true,
//                           items: labor.map(buildMenuItem).toList(),
//                           onChanged: (value1) =>
//                               setState(() => this.value1 = value1),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ))
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Quantity : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Quantity',
//                       ),
//                       keyboardType: TextInputType.number),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Hours Each : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Hours Each',
//                       ),
//                       keyboardType: TextInputType.number),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Total Hours : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     enabled: false,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: '0',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//               margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//               child: InkWell(
//                 onTap: () {},
//                 child: Container(
//                   margin: const EdgeInsets.only(
//                       left: 40, right: 40, top: 10.0, bottom: 10.0),
//                   padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.blue,
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Colors.blue,
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 148, 207, 255),
//                           Colors.blue
//                         ],
//                       )),
//                   child: const Row(children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Add Another Labor",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//               )),
//           Container(
//             color: Colors.blue,
//             padding: const EdgeInsets.all(4),
//             height: 40,
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Time Of Application ",
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//               ),
//             ]),
//           ),
//           Container(
//             child: InkWell(
//               onTap: () {
//                 _showTimePiker('_applicationStartTime');
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: Row(children: [
//                   const Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Application Start Time : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       // child: Padding(
//                       // padding: EdgeInsets.all(2.0),
//                       child: TextField(
//                         obscureText: false,
//                         enabled: false,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(),
//                           labelText:
//                               _applicationStartTime.format(context).toString(),
//                         ),
//                       ),
//                       // ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           ),
//           Container(
//             child: InkWell(
//               onTap: () {
//                 _showTimePiker('_applicationEndTime');
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: Row(children: [
//                   const Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Application End Time : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       // child: Padding(
//                       // padding: EdgeInsets.all(2.0),
//                       child: TextField(
//                         obscureText: false,
//                         enabled: false,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(),
//                           labelText:
//                               _applicationEndTime.format(context).toString(),
//                         ),
//                       ),
//                       // ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           ),
//           Container(
//             child: InkWell(
//               onTap: () {
//                 _showTimePiker('_breakStartTime');
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: Row(children: [
//                   const Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Break Start Time : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       // child: Padding(
//                       // padding: EdgeInsets.all(2.0),
//                       child: TextField(
//                         obscureText: false,
//                         enabled: false,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(),
//                           labelText: _breakStartTime.format(context).toString(),
//                         ),
//                       ),
//                       // ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           ),
//           Container(
//             child: InkWell(
//               onTap: () {
//                 _showTimePiker('_breakEndTime');
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: Row(children: [
//                   const Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Break End Time : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       // child: Padding(
//                       // padding: EdgeInsets.all(2.0),
//                       child: TextField(
//                         obscureText: false,
//                         enabled: false,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(),
//                           labelText: _breakEndTime.format(context).toString(),
//                         ),
//                       ),
//                       // ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.blue,
//             padding: const EdgeInsets.all(4),
//             height: 40,
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Weather Condition at site ",
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//               ),
//             ]),
//           ),
//           Container(
//             child: InkWell(
//               onTap: () {
//                 _showTimePiker('_Time');
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: Row(children: [
//                   const Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Time : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       // child: Padding(
//                       // padding: EdgeInsets.all(2.0),
//                       child: TextField(
//                         obscureText: false,
//                         enabled: false,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(),
//                           labelText: _Time.format(context).toString(),
//                         ),
//                       ),
//                       // ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Temperature(F) : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     obscureText: false,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Temperature(F)',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Wind Speed(mph) : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     obscureText: false,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Wind Speed(mph)',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Wind Direction : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     obscureText: false,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Wind Direction',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//               margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//               child: InkWell(
//                 onTap: () {},
//                 child: Container(
//                   margin: const EdgeInsets.only(
//                       left: 40, right: 40, top: 10.0, bottom: 10.0),
//                   padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.blue,
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Colors.blue,
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 148, 207, 255),
//                           Colors.blue
//                         ],
//                       )),
//                   child: const Row(children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Add Another Time",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//               )),
//           Container(
//             color: Colors.blue,
//             padding: const EdgeInsets.all(4),
//             height: 40,
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Applicants ",
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Applicant Name : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     obscureText: false,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Applicant Name',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Applicant License Number : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     obscureText: false,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Applicant License Number',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//             child: const Row(children: [
//               Expanded(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Text(
//                         "Applicants digital Signature : ",
//                         style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                       ),
//                     )),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   // child: Padding(
//                   // padding: EdgeInsets.all(2.0),
//                   child: TextField(
//                     obscureText: false,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Applicants digital Signature',
//                     ),
//                   ),
//                   // ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//               margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//               child: InkWell(
//                 onTap: () {},
//                 child: Container(
//                   margin: const EdgeInsets.only(
//                       left: 40, right: 40, top: 10.0, bottom: 10.0),
//                   padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.blue,
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Colors.blue,
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 148, 207, 255),
//                           Colors.blue
//                         ],
//                       )),
//                   child: const Row(children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Add another Applicant",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//               )),
//           Container(
//               margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//               child: InkWell(
//                 onTap: () {
//                   _showSubmitDataDialog();
//                 },
//                 child: Container(
//                   margin:
//                       const EdgeInsets.only(left: 40, right: 40, bottom: 10.0),
//                   padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.blue,
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Colors.blue,
//                       gradient: const LinearGradient(
//                         colors: [Colors.blue, Colors.blue],
//                       )),
//                   child: const Row(children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Submit",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//               )),
//         ])),
//       ),
//     );
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   String greetingMessage() {
//     var timeNow = DateTime.now().hour;

//     if (timeNow <= 11.59) {
//       return 'Good Morning';
//     } else if (timeNow > 12 && timeNow <= 16) {
//       return 'Good Afternoon';
//     } else if (timeNow > 16 && timeNow < 20) {
//       return 'Good Evening';
//     } else {
//       return 'Good Night';
//     }
//   }

//   String getCurrentDate() {
//     var date = DateTime.now().toString();

//     var dateParse = DateTime.parse(date);

//     var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
//     return formattedDate.toString();
//   }

//   void _showTimePiker(String flag) {
//     showTimePicker(context: context, initialTime: TimeOfDay.now())
//         .then((value) {
//       setState(() {
//         if (flag.contains('_applicationStartTime')) {
//           _applicationStartTime = value!;
//         } else if (flag.contains('_applicationEndTime')) {
//           _applicationEndTime = value!;
//         } else if (flag.contains('_breakStartTime')) {
//           _breakStartTime = value!;
//         } else if (flag.contains('_breakEndTime')) {
//           _breakEndTime = value!;
//         } else if (flag.contains('_Time')) {
//           _Time = value!;
//         }
//       });
//     });
//   }

//   void _showSubmitDataDialog() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Container(
//             child: AlertDialog(
//               title: const Text('Are you sure to submit?'),
//               // content: Text("Are you sure to submit?"),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text("NO")),
//                 TextButton(
//                     onPressed: () {
//                       sendData();
//                       Navigator.pop(context);
//                     },
//                     child: const Text("Yes")),
//               ],
//             ),
//           );
//         });
//   }

//   void sendData() async {
//     Album? album = await APIServices().getAlbums();
//     if (album != null) {
//       setState(() {
//         isLoaded = true;
//         print('object:' + album.title);
//         var data = controller.getData() as Album?;
//         print('data');
//         print(data);
//       });
//     }
//   }
// }
