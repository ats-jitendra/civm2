// import 'dart:io';
// import 'package:CIVM/screens/admin_pannel/row_maintenance_view/row_maintenance_plan.dart';
// import 'package:CIVM/screens/admin_pannel/row_vegitation_management_view/vegitation_management_dashboard.dart';
// import 'package:CIVM/screens/login_page.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BottomNavigationHomePage extends StatefulWidget {
//   const BottomNavigationHomePage({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigationHomePage> createState() =>
//       _BottomNavigationHomePageState();
// }

// class _BottomNavigationHomePageState extends State<BottomNavigationHomePage> {
//   DateTime now = DateTime.now();
//   int currentYear = getCurrentYear();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final userPreferences = Provider.of<UserPref>(context);
//     // ignore: deprecated_member_use
//     return PopScope(
//       canPop: false,
//        onPopInvokedWithResult: (didPop, result) async {
//         if (didPop) {
//           return;
//         }
//         showExitPopup(context);
//       },
//       child: Container(
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage('assets/vma_bg.png'),
//           fit: BoxFit.fill,
//         )),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             title: const Text(
//               'CIVM',
//               style: TextStyle(color: Colors.white),
//             ),
//             backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//             actions: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   userPreferences.remove().then((value) {
//                     // ignore: use_build_context_synchronously
//                     // Navigator.pushReplacement(context, RoutesName.login);
//                     // Navigator.pushNamed(
//                     //     context, RoutesName.login);
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (BuildContext context) => const LoginPage()));
//                   });
//                   // Navigator.of(context).push(MaterialPageRoute(
//                   //     builder: (BuildContext context) => const LoginPage()));
//                 },
//               ),
//             ],
//           ),
//           body: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: const AssetImage('assets/bac3.jpg'),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                     Colors.black.withOpacity(0.45), BlendMode.darken),
//               ),
//             ),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(
//                             left: 10, right: 10, top: 70.0),
//                         padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                       ),
//                       Card(
//                         color: Colors.white.withOpacity(0.4),
//                         margin: const EdgeInsets.only(
//                           left: 16.0,
//                           right: 16,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(children: [
//                             Form(
//                                 child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.5),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           right: 8.0,
//                                           left: 8,
//                                           top: 2,
//                                           bottom: 2),
//                                       child: Image(
//                                         image: const AssetImage(
//                                             'assets/logo_dark.png'),
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.4,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.05,
//                                       ),
//                                     ),
//                                   ),
//                                   const Padding(
//                                     padding: EdgeInsets.only(top: 8.0),
//                                     child: Text(
//                                       "Getting started",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   const Padding(
//                                     padding: EdgeInsets.only(top: 8.0),
//                                     child: Text(
//                                       "Cloud Integrated Vegetation Management",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: (BuildContext context) =>
//                                                   const RowMaintenanceView()));
//                                     },
//                                     child: Container(
//                                       margin: const EdgeInsets.only(top: 10.0),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.15,
//                                       width: size.width * 0.99,
//                                       decoration: BoxDecoration(
//                                           // shape: BoxShape.circle,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 2, 75, 4),
//                                                 blurRadius: 5,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Colors.white,
//                                               Colors.white,
//                                             ],
//                                           )),
//                                       child: const Row(children: [
//                                         Expanded(
//                                           child: Align(
//                                             alignment: Alignment.topCenter,
//                                             child: Padding(
//                                               padding: EdgeInsets.only(
//                                                   top: 10.0, bottom: 10),
//                                               child: ClipRRect(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(15.0)),
//                                                 child: Image(
//                                                   image: AssetImage(
//                                                       'assets/1.png'),
//                                                   color: Color.fromARGB(
//                                                       255, 82, 185, 13),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 bottom: 10.0, top: 10),
//                                             child: Text(
//                                               "ROW Maintenance View",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 82, 185, 13),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               const VegitationManangemnetDashboard()));
//                                     },
//                                     child: Container(
//                                       margin: const EdgeInsets.only(top: 30.0),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.15,
//                                       width: size.width * 0.99,
//                                       decoration: BoxDecoration(
//                                           // shape: BoxShape.circle,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 2, 75, 4),
//                                                 blurRadius: 5,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Colors.white,
//                                               Colors.white,
//                                             ],
//                                           )),
//                                       child: const Row(children: [
//                                         Expanded(
//                                           child: Align(
//                                             alignment: Alignment.topCenter,
//                                             child: Padding(
//                                               padding: EdgeInsets.only(
//                                                   bottom: 10.0, top: 10),
//                                               child: ClipRRect(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(15.0)),
//                                                 child: Image(
//                                                   image: AssetImage(
//                                                       'assets/2.png'),
//                                                   color: Color.fromARGB(
//                                                       255, 82, 185, 13),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 bottom: 10.0, top: 10),
//                                             child: Text(
//                                               "ROW Vegetation Management View",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 82, 185, 13),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                           ]),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           // alignment: Alignment.bottomCenter,

//                           children: [
//                             Text(
//                               "Copyright © $currentYear",
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             const Text(
//                               "Cloud Integrated Vegetation Management",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Color.fromARGB(255, 255, 102, 0),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<bool> showExitPopup(context) async {
//     return await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: SizedBox(
//               height: 100,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: Text(
//                       "Do you want to exit?",
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             exit(0);
//                           },
//                           child: const Text("Yes",
//                               style: TextStyle(color: Colors.white)),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red.shade800),
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       Expanded(
//                           child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: const Text("No",
//                             style: TextStyle(color: Colors.white)),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                         ),
//                       ))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   static int getCurrentYear() {
//     DateTime now = DateTime.now();
//     int currentYear = now.year;
//     return currentYear;
//   }
// }
