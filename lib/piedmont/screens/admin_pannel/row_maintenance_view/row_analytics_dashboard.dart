// import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/approve_civm_access.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/budget_planning.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/inspection_zielies.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/maintenance_analysis_report.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/outage_by_vegetation_report.dart';
// import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/piedmont/screens/login_page.dart';
// import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
// import 'package:CIVM/piedmont/utils/common_functions.dart';
// import 'package:CIVM/sharedPrefs/constants.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

// // ignore: must_be_immutable
// class RowAnalyticsDashboard extends StatefulWidget {
//   const RowAnalyticsDashboard({Key? key}) : super(key: key);

//   @override
//   State<RowAnalyticsDashboard> createState() => _RowAnalyticsDashboardState();
// }

// class _RowAnalyticsDashboardState extends State<RowAnalyticsDashboard> {
//   List<Map<String, dynamic>> listOfColumns = [];
//   List<Map<String, dynamic>> listOfColumns1 = [];
//   var result = [];
//   List<String> menu = [];

//   final List<Chart> chart = [
//     Chart(40, 50),
//     Chart(10, 16),
//     Chart(12, 22),
//     Chart(40, 50),
//     Chart(10, 16),
//     Chart(12, 22),
//     Chart(40, 50),
//     Chart(10, 16),
//     Chart(12, 22),
//     Chart(40, 50),
//     Chart(10, 16),
//     Chart(12, 22),
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           'Row Analytics Dashboard',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: AppColors.baseColor,
//         actions: const <Widget>[],
//       ),
//       drawer: DrawerManu(menu: menu),
//       body: SingleChildScrollView(
//           child: Center(
//               child: Column(children: [
//         Container(
//           margin: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//           decoration: const BoxDecoration(
//               // shape: BoxShape.circle,
//               // borderRadius: BorderRadius.only(
//               //     topRight: Radius.circular(50),
//               //     bottomLeft: Radius.circular(50)),
//               boxShadow: [
//                 BoxShadow(
//                     color: Color.fromARGB(255, 1, 31, 65),
//                     blurRadius: 5,
//                     offset: Offset(2.0, 5.0))
//               ],
//               color: Color.fromARGB(255, 130, 193, 245),
//               gradient: LinearGradient(
//                 colors: [AppColors.baseColor, Color.fromARGB(255, 7, 59, 120)],
//               )),
//           child: InkWell(
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => const LCP()));
//             },
//             child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.white,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 3, 47, 97),
//                         blurRadius: 10,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   image: DecorationImage(
//                     image: const AssetImage('assets/1.jpeg'),
//                     fit: BoxFit.cover,
//                     colorFilter: ColorFilter.mode(
//                         Colors.black.withOpacity(0.65), BlendMode.darken),
//                   ),
//                 ),
//                 margin: const EdgeInsets.only(
//                     left: 8, right: 8, top: 10, bottom: 8),
//                 padding: const EdgeInsets.all(8),
//                 alignment: Alignment.center,
//                 height: size.height * 0.3,
//                 width: size.width * 0.99,
//                 child: Column(children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.99,
//                     // width: MediaQuery.of(context).size.width,
//                     // height: 40,
//                     decoration: const BoxDecoration(
//                         // shape: BoxShape.circle,
//                         //borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromARGB(255, 3, 47, 97),
//                               blurRadius: 5,
//                               offset: Offset(2.0, 5.0))
//                         ],
//                         color: Color.fromARGB(255, 130, 193, 245),
//                         gradient: LinearGradient(
//                           colors: [
//                             AppColors.baseColor,
//                             Color.fromARGB(255, 7, 59, 120)
//                           ],
//                         )),
//                     child: const Row(children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "MAINTENANCE ANALYSIS REPORT",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Row(
//                       children: [
//                         const Expanded(
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 20.0),
//                               child: Image(
//                                   image: AssetImage('assets/icon1.png'),
//                                   width: 100,
//                                   height: 100)

//                               // Icon(
//                               //   Icons.analytics,
//                               //   color: Colors.pink,
//                               //   size: 100,
//                               // ),
//                               ),
//                         ),
//                         Expanded(
//                           child: InkWell(
//                               onTap: () {
//                                 // Navigator.pushNamed(context,
//                                 //     RoutesNamePemc.maintenanceAnalysisReport);
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (BuildContext contex) =>
//                                             const MaintenanceAnalysisReport()));
//                               },
//                               child: Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 10,
//                                       right: 10,
//                                       top: 10.0,
//                                       bottom: 10),
//                                   padding: const EdgeInsets.all(8),
//                                   alignment: Alignment.center,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.3,
//                                   // height: 100,
//                                   decoration: BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color.fromARGB(
//                                           255, 243, 33, 33),
//                                       gradient: const LinearGradient(
//                                         colors: [Colors.orange, Colors.red],
//                                       )),
//                                   child: const Row(children: [
//                                     Expanded(
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           "Get Report ->",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                                 ),
//                               )),
//                         )
//                       ],
//                     ),
//                   ),
//                 ])),
//           ),
//         ),

//         Container(
//           margin: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//           decoration: const BoxDecoration(
//               // shape: BoxShape.circle,
//               // borderRadius: BorderRadius.only(
//               //     topRight: Radius.circular(50),
//               //     bottomLeft: Radius.circular(50)),
//               boxShadow: [
//                 BoxShadow(
//                     color: Color.fromARGB(255, 1, 31, 65),
//                     blurRadius: 5,
//                     offset: Offset(2.0, 5.0))
//               ],
//               color: Color.fromARGB(255, 130, 193, 245),
//               gradient: LinearGradient(
//                 colors: [AppColors.baseColor, Color.fromARGB(255, 7, 59, 120)],
//               )),
//           child: InkWell(
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => const LCP()));
//             },
//             child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.white,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 3, 47, 97),
//                         blurRadius: 10,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   image: DecorationImage(
//                     image: const AssetImage('assets/1.jpeg'),
//                     fit: BoxFit.cover,
//                     colorFilter: ColorFilter.mode(
//                         Colors.black.withOpacity(0.65), BlendMode.darken),
//                   ),
//                 ),
//                 margin: const EdgeInsets.only(
//                     left: 8, right: 8, top: 10, bottom: 8),
//                 padding: const EdgeInsets.all(8),
//                 alignment: Alignment.center,
//                 height: size.height * 0.3,
//                 width: size.width * 0.99,
//                 child: Column(children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.99,
//                     // width: MediaQuery.of(context).size.width,
//                     // height: 40,
//                     decoration: const BoxDecoration(
//                         // shape: BoxShape.circle,
//                         //borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromARGB(255, 3, 47, 97),
//                               blurRadius: 5,
//                               offset: Offset(2.0, 5.0))
//                         ],
//                         color: Color.fromARGB(255, 130, 193, 245),
//                         gradient: LinearGradient(
//                           colors: [
//                             AppColors.baseColor,
//                             Color.fromARGB(255, 7, 59, 120)
//                           ],
//                         )),
//                     child: const Row(children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "OUTAGE BY VEGETATION REPORT",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Row(
//                       children: [
//                         const Expanded(
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 20.0),
//                               child: Image(
//                                   image: AssetImage('assets/icon4.png'),
//                                   width: 100,
//                                   height: 100)

//                               // Icon(
//                               //   Icons.analytics,
//                               //   color: Colors.pink,
//                               //   size: 100,
//                               // ),
//                               ),
//                         ),
//                         Expanded(
//                           child: InkWell(
//                               onTap: () {
//                                 // Navigator.pushNamed(context,
//                                 //     RoutesNamePemc.outageByVegetationReport);
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (BuildContext contex) =>
//                                             const OutageByVegetationReport()));
//                               },
//                               child: Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 10,
//                                       right: 10,
//                                       top: 10.0,
//                                       bottom: 10),
//                                   padding: const EdgeInsets.all(8),
//                                   alignment: Alignment.center,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.3,
//                                   // height: 100,
//                                   decoration: BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color.fromARGB(
//                                           255, 243, 33, 33),
//                                       gradient: const LinearGradient(
//                                         colors: [Colors.orange, Colors.red],
//                                       )),
//                                   child: const Row(children: [
//                                     Expanded(
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           "Get Report ->",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                                 ),
//                               )),
//                         )
//                       ],
//                     ),
//                   ),
//                 ])),
//           ),
//         ),

//         // Container(
//         //   margin:
//         //       const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
//         //   padding: const EdgeInsets.all(8),
//         //   alignment: Alignment.center,
//         //   // height: size.height * 0.55,
//         //   width: size.width * 0.99,
//         //   decoration: BoxDecoration(
//         //       // shape: BoxShape.circle,
//         //       borderRadius: BorderRadius.circular(10),
//         //       boxShadow: const [
//         //         BoxShadow(
//         //             color: Color.fromARGB(255, 3, 47, 97),
//         //             blurRadius: 10,
//         //             offset: Offset(2.0, 5.0))
//         //       ],
//         //       gradient: const LinearGradient(
//         //         colors: [
//         //           Color.fromARGB(255, 255, 255, 255),
//         //           Color.fromARGB(255, 255, 255, 255),
//         //         ],
//         //       )),
//         //   child: Column(
//         //     children: [
//         //       Container(
//         //         padding: const EdgeInsets.all(10),
//         //         alignment: Alignment.center,
//         //         width: size.width * 0.99,
//         //         // width: MediaQuery.of(context).size.width,
//         //         // height: 40,
//         //         decoration: const BoxDecoration(
//         //             // shape: BoxShape.circle,
//         //             //borderRadius: BorderRadius.circular(25),
//         //             boxShadow: [
//         //               BoxShadow(
//         //                   color: Color.fromARGB(255, 3, 47, 97),
//         //                   blurRadius: 5,
//         //                   offset: Offset(2.0, 5.0))
//         //             ],
//         //             color: Color.fromARGB(255, 130, 193, 245),
//         //             gradient: LinearGradient(
//         //               colors: [
//         //                 AppColors.baseColor,
//         //                 Color.fromARGB(255, 7, 59, 120)
//         //               ],
//         //             )),
//         //         child: const Row(children: [
//         //           Align(
//         //             alignment: Alignment.centerLeft,
//         //             child: Text(
//         //               "TEMPERATURE EFFECT ON OUTAGE",
//         //               textAlign: TextAlign.left,
//         //               style: TextStyle(
//         //                 color: Colors.white,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontSize: 20,
//         //               ),
//         //             ),
//         //           ),
//         //         ]),
//         //       ),
//         //       Row(
//         //         children: [
//         //           const Expanded(
//         //             child: Padding(
//         //               padding: EdgeInsets.only(top: 20.0),
//         //               child: Icon(
//         //                 Icons.thermostat,
//         //                 color: Colors.purple,
//         //                 size: 100,
//         //               ),
//         //             ),
//         //           ),
//         //           Expanded(
//         //             child: InkWell(
//         //                 onTap: () {
//         //                   Navigator.pushNamed(context,
//         //                       RoutesName.temperatureEffectOnOutage);
//         //                 },
//         //                 child: Align(
//         //                   alignment: Alignment.bottomRight,
//         //                   child: Container(
//         //                     margin: const EdgeInsets.only(
//         //                         left: 10, right: 10, top: 10.0, bottom: 10),
//         //                     padding: const EdgeInsets.all(8),
//         //                     alignment: Alignment.center,
//         //                     width: MediaQuery.of(context).size.width * 0.3,
//         //                     // height: 100,
//         //                     decoration: BoxDecoration(
//         //                         // shape: BoxShape.circle,
//         //                         borderRadius: BorderRadius.circular(10),
//         //                         boxShadow: const [
//         //                           BoxShadow(
//         //                               color:
//         //                                   AppColors.baseColor,
//         //                               blurRadius: 5,
//         //                               offset: Offset(2.0, 5.0))
//         //                         ],
//         //                         color:
//         //                             const Color.fromARGB(255, 243, 33, 33),
//         //                         gradient: const LinearGradient(
//         //                           colors: [Colors.orange, Colors.red],
//         //                         )),
//         //                     child: const Row(children: [
//         //                       Expanded(
//         //                         child: Align(
//         //                           alignment: Alignment.center,
//         //                           child: Text(
//         //                             "Get Report ->",
//         //                             textAlign: TextAlign.center,
//         //                             style: TextStyle(
//         //                               color: Colors.white,
//         //                               fontWeight: FontWeight.bold,
//         //                               fontSize: 15,
//         //                             ),
//         //                           ),
//         //                         ),
//         //                       ),
//         //                     ]),
//         //                   ),
//         //                 )),
//         //           )
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         // Container(
//         //   margin:
//         //       const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
//         //   padding: const EdgeInsets.all(8),
//         //   alignment: Alignment.center,
//         //   // height: size.height * 0.55,
//         //   width: size.width * 0.99,
//         //   decoration: BoxDecoration(
//         //       // shape: BoxShape.circle,
//         //       borderRadius: BorderRadius.circular(10),
//         //       boxShadow: const [
//         //         BoxShadow(
//         //             color: Color.fromARGB(255, 3, 47, 97),
//         //             blurRadius: 10,
//         //             offset: Offset(2.0, 5.0))
//         //       ],
//         //       gradient: const LinearGradient(
//         //         colors: [
//         //           Color.fromARGB(255, 255, 255, 255),
//         //           Color.fromARGB(255, 255, 255, 255),
//         //         ],
//         //       )),
//         //   child: Column(
//         //     children: [
//         //       Container(
//         //         padding: const EdgeInsets.all(10),
//         //         alignment: Alignment.center,
//         //         width: size.width * 0.99,
//         //         // width: MediaQuery.of(context).size.width,
//         //         // height: 40,
//         //         decoration: const BoxDecoration(
//         //             // shape: BoxShape.circle,
//         //             //borderRadius: BorderRadius.circular(25),
//         //             boxShadow: [
//         //               BoxShadow(
//         //                   color: Color.fromARGB(255, 3, 47, 97),
//         //                   blurRadius: 5,
//         //                   offset: Offset(2.0, 5.0))
//         //             ],
//         //             color: Color.fromARGB(255, 130, 193, 245),
//         //             gradient: LinearGradient(
//         //               colors: [
//         //                 AppColors.baseColor,
//         //                 Color.fromARGB(255, 7, 59, 120)
//         //               ],
//         //             )),
//         //         child: const Row(children: [
//         //           Align(
//         //             alignment: Alignment.centerLeft,
//         //             child: Text(
//         //               "VEGETATION COST ANALYSIS",
//         //               textAlign: TextAlign.left,
//         //               style: TextStyle(
//         //                 color: Colors.white,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontSize: 20,
//         //               ),
//         //             ),
//         //           ),
//         //         ]),
//         //       ),
//         //       Row(
//         //         children: [
//         //           const Expanded(
//         //             child: Padding(
//         //               padding: EdgeInsets.only(top: 20.0),
//         //               child: Icon(
//         //                 Icons.lightbulb,
//         //                 color: Colors.blue,
//         //                 size: 100,
//         //               ),
//         //             ),
//         //           ),
//         //           Expanded(
//         //             child: InkWell(
//         //                 onTap: () {
//         //                   Navigator.pushNamed(
//         //                       context, RoutesName.vegetationCostAnalysis);
//         //                 },
//         //                 child: Align(
//         //                   alignment: Alignment.bottomRight,
//         //                   child: Container(
//         //                     margin: const EdgeInsets.only(
//         //                         left: 10, right: 10, top: 10.0, bottom: 10),
//         //                     padding: const EdgeInsets.all(8),
//         //                     alignment: Alignment.center,
//         //                     width: MediaQuery.of(context).size.width * 0.3,
//         //                     // height: 100,
//         //                     decoration: BoxDecoration(
//         //                         // shape: BoxShape.circle,
//         //                         borderRadius: BorderRadius.circular(10),
//         //                         boxShadow: const [
//         //                           BoxShadow(
//         //                               color:
//         //                                   AppColors.baseColor,
//         //                               blurRadius: 5,
//         //                               offset: Offset(2.0, 5.0))
//         //                         ],
//         //                         color:
//         //                             const Color.fromARGB(255, 243, 33, 33),
//         //                         gradient: const LinearGradient(
//         //                           colors: [Colors.orange, Colors.red],
//         //                         )),
//         //                     child: const Row(children: [
//         //                       Expanded(
//         //                         child: Align(
//         //                           alignment: Alignment.center,
//         //                           child: Text(
//         //                             "Get Report ->",
//         //                             textAlign: TextAlign.center,
//         //                             style: TextStyle(
//         //                               color: Colors.white,
//         //                               fontWeight: FontWeight.bold,
//         //                               fontSize: 15,
//         //                             ),
//         //                           ),
//         //                         ),
//         //                       ),
//         //                     ]),
//         //                   ),
//         //                 )),
//         //           )
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ]))),
//     );
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

//   showSnackBar(String msg) {
//     final snackBar = SnackBar(
//       content: Text(msg),
//       action: SnackBarAction(
//         label: '',
//         onPressed: () {
//           // Some code to undo the change.
//         },
//       ),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
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
//   String? _imagePath;

//   @override
//   void initState() {
//     setUserName();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userPreferences = Provider.of<UserPref>(context);
//     var provider = Provider.of<LocationProviderPemc>(context, listen: true);
//      final browser = MyChromeSafariBrowser();
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           // Important: Remove any padding from the ListView.
//           // padding: EdgeInsets.zero,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 180,
//               color: AppColors.lighterBaseColor,
//               padding: const EdgeInsets.only(top: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   menuLogo(),
//                   const SizedBox(height: 6),
//                   Text(
//                     userName,
//                     style: const TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   ListTile(
//                     leading: const Icon(
//                       Icons.computer,
//                     ),
//                     title: const Text('Row Maintenance Plan'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const EnergyAuditPannel()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.compare,
//                     ),
//                     title: const Text('Inspection'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const InspectionZielies()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.pending,
//                     ),
//                     title: const Text('Service Order'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const AdmServiceOrder()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.airplane_ticket_sharp,
//                     ),
//                     title: const Text('Job List'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                                AdminAddNewRowTable(index:'0')));
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (BuildContext context) => AddNewRowMaintenancePlan(
//                       //           tokenNo: '',
//                       //           index: '0',
//                       //           subStation: '',
//                       //           feeder: '',
//                       //           nextMaintYear: '',
//                       //           maintType: '',
//                       //           totalMiles: '',
//                       //           costPerMile: '',
//                       //           totalCost: '',
//                       //           budgetType: '',
//                       //           contractRowYear: '',
//                       //           rowCycle: '',
//                       //           rowYear: '',
//                       //           contractorCompany: '',
//                       //           assignForeman: '',
//                       //         )));
//                     },
//                   ),
//                   // Visibility(
//                   //   visible: (widget.menu.isNotEmpty &&
//                   //           widget.menu.contains('Energy Audit Ticket'))
//                   //       ? true
//                   //       : false,
//                   // child:
//                       ///////////new added maps for PEMC
//                   ListTile(
//                     leading: const Icon(
//                       Icons.vertical_distribute,
//                     ),
//                     title: const Text('Add ROW Distribution Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       await browser.open(
//                           url: WebUri(
//                               MapUrl.getPlannerDistributionMapEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.maps_ugc,
//                     ),
//                     title: const Text('Add ROW Transmission Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       await browser.open(
//                           url: WebUri(
//                               MapUrl.getPlannerTransmissionMapEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.map,
//                     ),
//                     title: const Text('Add Herbicide Transmission Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       await browser.open(
//                           url: WebUri(MapUrl.midTransmissionMapEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.maps_ugc_rounded,
//                     ),
//                     title: const Text('Add Annual Herbicide Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       await browser.open(
//                           url: WebUri(MapUrl.officeTransmissionMapEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),

//                   ////////////////////////////////////
//                   ListTile(
//                     leading: const Icon(
//                       Icons.open_in_new,
//                     ),
//                     title: const Text('IVM Maintenance Progress'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const RowMaintenanceProgress()));
//                     },
//                   ),
//                   // ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.closed_caption_off,
//                   //   ),
//                   //   title: const Text('Row Analytics Dashboard'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.pop(context);
//                   //   },
//                   // ),
//                           ListTile(
//                     leading: const Icon(
//                       Icons.list,
//                     ),
//                     title: const Text('Invoice List'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const AdmInvoiceList()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.data_usage,
//                     ),
//                     title: const Text('Budget Planning'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const BudgetPlanning()));
//                     },
//                   ),

//                   ListTile(
//                     leading: const Icon(
//                       Icons.location_on,
//                     ),
//                     title: const Text('Live IVM System Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       provider.getLocation();
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const MapScreenLeafLat()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.check,
//                     ),
//                     title: const Text('Approve CIVM Access'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const ApproveCIVMAccess()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.add,
//                     ),
//                     title: const Text('Add Crew Member'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const AddCrewMember()));
//                     },
//                   ),

//                   ListTile(
//                     leading: const Icon(
//                       Icons.logout,
//                     ),
//                     title: const Text('Logout'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       // Constants.prefs.setBool("LoggedIn", false);
//                       userPreferences.remove().then((value) {
//                         // ignore: use_build_context_synchronously
//                         // Navigator.pushReplacement(context, RoutesName.login);
//                         // Navigator.pushNamed(
//                         //     context, RoutesName.login);
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 const LoginPagePemc()));
//                       });
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (BuildContext context) => const LoginPage()));
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               alignment: Alignment.center,
//               child: Column(
//                 children: [
//                   Text(
//                     'Version: ${Constants.prefs.getString('VERSION') ?? ''}',
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     'Updated: ${Constants.prefs.getString('VERSION_DATE') ?? ''}',
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> setUserName() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     Image.network(
//       'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
//     );
//     String imageUrl =
//         'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
//     _imagePath = imageUrl;
//     setState(() {
//       userName = '${data.user!.fName} ${data.user!.lName}';
//     });
//   }
// }

// class Chart {
//   final int y1;
//   final int y2;

//   Chart(
//     this.y1,
//     this.y2,
//   );
// }
