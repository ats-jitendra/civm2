// import 'dart:convert';
// import 'package:civm/screens/contractor_pannel/change_order_contractor.dart';
// import 'package:civm/screens/contractor_pannel/contractor_dispatch_dashboard.dart';
// import 'package:civm/screens/contractor_pannel/invoice_form_contractor.dart';
// import 'package:civm/screens/contractor_pannel/power_time_form.dart';
// import 'package:civm/screens/contractor_pannel/row_maintenance_progress_contractor.dart';
// import 'package:civm/screens/contractor_pannel/change_order_pending_contractor.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter_profile_picture/flutter_profile_picture.dart';

// import '../login_page.dart';

// class WorkOrderClosedContractor extends StatefulWidget {
//   const WorkOrderClosedContractor({Key? key}) : super(key: key);

//   @override
//   State<WorkOrderClosedContractor> createState() =>
//       _WorkOrderClosedContractorState();
// }

// class _WorkOrderClosedContractorState extends State<WorkOrderClosedContractor> {
//   // int _currentIndex = 0;
//   // final List<Widget> _children = [
//   //   RowMaintenancePlan(),
//   //   // BottomNavigationHomePage(),
//   //   // BottomNavigationAccountPage()
//   // ];

//   final TextEditingController _input = TextEditingController();

//   List<String> menu = [];

//   // ignore: non_constant_identifier_names
//   List<String> select_substation = ['Boy River', ''];
//   String? substation;
// // ignore: non_constant_identifier_names
//   List<String> select_feeder = ['-N/A-', ''];
//   String? feeder;
// // ignore: non_constant_identifier_names
//   List<String> select_crew = ['-N/A-', ''];
//   String? crew;
// // ignore: non_constant_identifier_names

// // ignore: non_constant_identifier_names
//   List<String> select_workOrder = ['-N/A-', ''];
//   String? workOrder;
// // ignore: non_constant_identifier_names

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     // getOwnPermissions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text('Work Order Closed'),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.filter_alt_outlined,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 openDailogAddCrewMember();
//                 // do something
//               },
//             )
//           ],
//         ),
//         drawer: DrawerManu(menu: menu),
//         body: SingleChildScrollView(
//             child: Column(children: [
//           Container(
//             margin:
//                 const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//             padding: const EdgeInsets.all(8),
//             alignment: Alignment.center,
//             // height: size.height * 0.5,
//             width: size.width * 0.99,
//             decoration: BoxDecoration(
//                 // shape: BoxShape.circle,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Color.fromARGB(255, 7, 59, 120),
//                       blurRadius: 10,
//                       offset: Offset(2.0, 5.0))
//                 ],
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 255, 255, 255),
//                     Color.fromARGB(255, 255, 255, 255),
//                   ],
//                 )),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(left: 10.0, right: 10.0, top: 8),
//                     child: TextFormField(
//                       onChanged: (value) => _runFilter(value),
//                       //  key: formkey2,
//                       controller: _input,
//                       style: const TextStyle(color: Colors.blue, fontSize: 16),
//                       obscureText: false,

//                       //keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Search your inpur...',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please search your input";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: 5,
//                       physics: const NeverScrollableScrollPhysics(),
//                       // itemCount: energyhistory!.result!.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin: const EdgeInsets.only(
//                               left: 4, right: 4, top: 10, bottom: 10),
//                           padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           // height: size.height * 0.2,
//                           width: size.width - 40,
//                           decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 2, 85, 4),
//                                     blurRadius: 10,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 255, 255, 255),
//                                   Color.fromARGB(255, 255, 255, 255),
//                                 ],
//                               )),
//                           child: Column(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 alignment: Alignment.center,
//                                 width: size.width * 0.99,
//                                 // width: MediaQuery.of(context).size.width,
//                                 // height: 40,
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     //borderRadius: BorderRadius.circular(25),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Color.fromARGB(255, 0, 66, 3),
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Colors.black,
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Color.fromARGB(255, 7, 59, 120),
//                                         Colors.purple,
//                                       ],
//                                     )),
//                                 child: const Row(children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "Serial: ",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '1',
//                                         // energyhistory!.result![index].aUDITID!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 8.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Work Order No.: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '28',
//                                         // energyhistory!.result![index].dATE!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Status: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         'Approved',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 2, 92, 249),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Documet Upload: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Icon(
//                                           Icons.check_circle_outline,
//                                           color: Colors.purple,
//                                         )),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "View: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Icon(
//                                           Icons.remove_red_eye_outlined,
//                                           color: Colors.red,
//                                         )),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Substation: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         'Tygerville',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Feeder: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         'FDR 2 ( Tygerville )',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Street: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         'Ruby',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Type: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         'Mechanical Clearing',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Crew: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Cost Per Mile: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '52000',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Row Installation Year: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '2022',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Cycle Length: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '2',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Next Row Maintenance Due: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '1/1/2023 12:00:00 AM',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(left: 8.0),
//                                 child: Row(children: [
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Order Date: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         '11/24/2022',
//                                         // energyhistory!.result![index].cUSTOMERNAME!,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           // fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ])));
//   }

//   Future<void> getOwnPermissions() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var APIURL =
//         "http://oemapi.ariespro.com/api/MenuAuthentication/userDetails";

//     Map mappedData = {
//       'id': prefs.getString('USER_NAME'),
//     };
//     print("Json data: ${mappedData}");
//     http.Response response =
//         await http.post(Uri.parse(APIURL), body: mappedData);
//     var data = jsonDecode(response.body);
//     print(" data: ${data}");
//     var status = "${data['code']}";

//     if (status.contains("SUCCESS")) {
//       setState(() {
//         var result = data["result"];
//         var temp = result['User Menu Access'] as List;
//         for (int i = 0; i < temp.length; i++) {
//           menu.add(temp[i]['MENU']);
//         }
//       });
//     } else if (status.contains("ERROR")) {
//       final snackBar = SnackBar(
//         content: Text("${data['message']}"),
//         action: SnackBarAction(
//           label: '',
//           onPressed: () {
//             // Some code to undo the change.
//           },
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } else {
//       final snackBar = SnackBar(
//         content: const Text('Somthing went wrong!!!'),
//         action: SnackBarAction(
//           label: '',
//           onPressed: () {
//             // Some code to undo the change.
//           },
//         ),
//       );

//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }

//   void _runFilter(String enteredKeyword) {
//     // List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       // results = listOfColumns1;
//     } else {
//       // results = listOfColumns1
//       // .where((user) =>
//       //     user["USER_NAME"]!
//       //         .toLowerCase()
//       //         .contains(enteredKeyword.toLowerCase()) ||
//       //     user["NAME"]!
//       //         .toLowerCase()
//       //         .contains(enteredKeyword.toLowerCase()) ||
//       //     user["USER_NAME"]!.contains('USER NAME'))
//       // .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }

//     // Refresh the UI
//     setState(() {
//       // listOfColumns = results;
//     });
//   }

//   Future openDailogAddCrewMember() => showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             content: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(top: 10),
//                           child: const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.all(2.0),
//                                 child: Text(
//                                   "Substation",
//                                   style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120)),
//                                 ),
//                               )),
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),

//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor:
//                                       const Color.fromARGB(255, 208, 249, 209),
//                                   value: substation,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_substation
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     this.substation = value;
//                                     // showLoaderDialog(context);
//                                     // getYear();
//                                     // getMonth();
//                                     // getData(program.toString(), year.toString(),
//                                     //     '0', '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Feeder",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),

//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor:
//                                       const Color.fromARGB(255, 208, 249, 209),
//                                   value: feeder,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items:
//                                       select_feeder.map(buildMenuItem).toList(),
//                                   onChanged: (value) {
//                                     this.feeder = value;
//                                     // showLoaderDialog(context);
//                                     // getYear();
//                                     // getMonth();
//                                     // getData(program.toString(), year.toString(),
//                                     //     '0', '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Work Order",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),

//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor:
//                                       const Color.fromARGB(255, 208, 249, 209),
//                                   value: workOrder,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_workOrder
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     setState(
//                                       () => this.workOrder = value,
//                                     );
//                                     // String m = getMonthNum(month.toString());
//                                     // showLoaderDialog(context);
//                                     // print(m);
//                                     // print(m);
//                                     // getData(program.toString(), year.toString(),
//                                     //     (m.isEmpty) ? '0' : m, '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Crew",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),

//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor:
//                                       const Color.fromARGB(255, 208, 249, 209),
//                                   value: crew,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items:
//                                       select_crew.map(buildMenuItem).toList(),
//                                   onChanged: (value) {
//                                     setState(
//                                       () => this.crew = value,
//                                     );
//                                     // String m = getMonthNum(month.toString());
//                                     // showLoaderDialog(context);
//                                     // print(m);
//                                     // print(m);
//                                     // getData(program.toString(), year.toString(),
//                                     //     (m.isEmpty) ? '0' : m, '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               Container(
//                   margin: const EdgeInsets.only(
//                       left: 6, right: 6, top: 6.0, bottom: 10),
//                   child: InkWell(
//                     onTap: () {
//                       print("object");
//                       // if (program != '' &&
//                       //     year != '' &&
//                       //     _customerNameAcNo.text.toString() != '') {
//                       //   const snackBar =
//                       //       SnackBar(content: Text('Submitting Form'));
//                       //   showLoaderDialog(context);
//                       //   String m = getMonthNum(month.toString());

//                       //   getData(
//                       //       program.toString(),
//                       //       year.toString(),
//                       //       (m.isEmpty) ? '0' : m,
//                       //       (_customerNameAcNo.text.toString().isEmpty)
//                       //           ? '0'
//                       //           : _customerNameAcNo.text.toString());
//                       Navigator.pop(context);
//                       // } else {
//                       //   print("Please fill all mandetory fields!!");
//                       // }
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(
//                           left: 40, right: 40, bottom: 10.0),
//                       // padding: const EdgeInsets.all(8),
//                       alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           // shape: BoxShape.circle,
//                           borderRadius: BorderRadius.circular(25),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.blue,
//                                 blurRadius: 5,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           color: Colors.black,
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 1, 45, 120),
//                               Colors.blue,
//                               Color.fromARGB(255, 0, 79, 215),
//                             ],
//                           )),
//                       child: const Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Search",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   )),
//             ],
//           );
//         });
//       });

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));
// }

// // ignore: must_be_immutable
// class DrawerManu extends StatefulWidget {
//   List<String> menu;
//   DrawerManu({Key? key, required this.menu}) : super(key: key);

//   @override
//   State<DrawerManu> createState() => _DrawerManuState();
// }

// class _DrawerManuState extends State<DrawerManu> {
//   String userName = '';

//   @override
//   void initState() {
//     // setUserName();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 7, 59, 120),
//             ),
//             child: Column(
//               children: [
//                 ProfilePicture(
//                   name: 'ABC',
//                   // name: userName,
//                   radius: 50,
//                   fontsize: 25,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 6.0),
//                   child: Text(
//                     // userName,
//                     'abc@vhbhb.com',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.computer,
//             ),
//             title: const Text('Contractor / Dispatch Dashboard'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ContractorDispatchDashboard()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.open_in_browser,
//             ),
//             title: const Text('Work Order Pending'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const WorkOrderPendingContractor()));
//             },
//           ),
//           // Visibility(
//           //   visible: (widget.menu.isNotEmpty &&
//           //           widget.menu.contains('Energy Audit Ticket'))
//           //       ? true
//           //       : false,
//           // child:
//           ListTile(
//             leading: const Icon(
//               Icons.pending,
//             ),
//             title: const Text('Row Maintenance Progress'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const RowMaintenanceProgressContractor()));
//             },
//           ),
//           // ),
//           ListTile(
//             leading: const Icon(
//               Icons.closed_caption_off,
//             ),
//             title: const Text('Change Order'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ChangeOrderContractor()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.inventory,
//             ),
//             title: const Text('Daily Herbicide Application Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) =>
//               //         const DailyHerbicideApplicationFormContractor()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.list_alt,
//             ),
//             title: const Text('Power Time Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const PowerTimeFormContractor()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.list_alt,
//             ),
//             title: const Text('Invoice Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const InvoiceFormContractor()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.list_alt,
//             ),
//             title: const Text('Mixing Inventory Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) =>
//               //         const MixingInventoryFormContractor(
//               //           id: '',
//               //         )));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.logout,
//             ),
//             title: const Text('Log Out'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               // // Constants.prefs.setBool("LoggedIn", false);
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (BuildContext context) => const LoginPage()));
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> setUserName() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       userName =
//           '${preferences.getString('FIRST_NAME')} ${preferences.getString('LAST_NAME')!}';
//     });
//   }
// }
