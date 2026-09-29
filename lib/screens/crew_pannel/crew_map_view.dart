// import 'dart:io';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// // ignore: must_be_immutable
// class CrewMapView extends StatefulWidget {
//   const CrewMapView({Key? key}) : super(key: key);

//   @override
//   State<CrewMapView> createState() => _CrewMapViewState();
// }

// class _CrewMapViewState extends State<CrewMapView> {
//   late Future<void> _initDataFuture;
//   String id = '';
//   @override
//   void initState() {
//     _initDataFuture = initData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           'Map',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//       ),
//       body: FutureBuilder<void>(
//         future: _initDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return SingleChildScrollView(
//               child: SizedBox(
//                 width: size.width * 0.99,
//                 height: size.height * 0.99,
//                 child: WebView(
//                   initialUrl:
//                       'https://mapapi.ariespro.com/main/dashboard/CIVM_Master_Map/USRQWXH589Z/${id}',
//                   javascriptMode: JavascriptMode.unrestricted,
//                   onWebResourceError: (WebResourceError error) {
//                     print('Map Error in phone');
//                     print("WebView error: ${error.description}");
//                   },
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<bool> showExitPopup(context) async {
//     return await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: SizedBox(
//               height: 90,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Do you want to exit?"),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             print('yes selected');
//                             exit(0);
//                           },
//                           child: const Text("Yes",
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white)),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red.shade800),
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       Expanded(
//                           child: ElevatedButton(
//                         onPressed: () {
//                           print('no selected');
//                           Navigator.of(context).pop();
//                         },
//                         child: const Text("No",
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white)),
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

//   Future<void> initData() async {
//     final userPreferences1 = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences1.getUser();
//     id = data.user!.id.toString();
//     print('id====$id');
//   }

//   // _launchURL(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(url);
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }
// }
