// import 'dart:convert';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/models/user_model.dart'; 
// import 'package:CIVM/resources/app_url.dart';
// import 'package:CIVM/screens/crew_pannel/change_order_records.dart';
// import 'package:CIVM/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
// import 'package:CIVM/screens/crew_pannel/crew_ivm_maintenance_plan_table.dart';
// import 'package:CIVM/screens/crew_pannel/crew_total_order_all_change_order.dart';
// import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/screens/map/provider/location_provider.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/sharedPrefs/constants.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:provider/provider.dart';
// import '../login_page.dart';
// import 'package:http/http.dart' as http;

// // ignore: must_be_immutable
// class ChangeOrderCrew extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   ChangeOrderCrew(
//       {Key? key,
//       required this.budgetType,
//       required this.maintenanceType,
//       required this.heading})
//       : super(key: key);

//   @override
//   State<ChangeOrderCrew> createState() => _ChangeOrderCrewState();
// }

// class _ChangeOrderCrewState extends State<ChangeOrderCrew> {
//   String id = "";
//   // final List<Widget> _children = [
//   //   RowMaintenancePlan(),
//   //   // BottomNavigationHomePage(),
//   //   // BottomNavigationAccountPage()
//   // ];
//   List<String> menu = [];

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedWorkOrderNo;

//   // ContractorChangeOrderViewModel contractorChangeOrderViewModel =
//   //     ContractorChangeOrderViewModel();
//   // LCPViewModel lCPViewModel = LCPViewModel();

//   late final Future? myFuture;

//   int initiatedCount = 0;
//   int pendingApprovalCount = 0;
//   int assignedCount = 0;
//   int rejectedCount = 0;
//   int workedCount = 0;
//   int completedCount = 0;
//   int cancelledCount = 0;
//   int assignedAndRejectedCount = 0;
//   int remainingStatusesCount = 0;

//   int pendingCount = 0;
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();
//   bool isSearchActive = false;

//   @override
//   void initState() {
//     // contractorChangeOrderViewModel.fetchContractorChangeOrdercountApi(context);
//     myFuture = fetchCardsCountMethod('');
//     // getContractorDataCount();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//           title: isSearching
//               ? Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: TextField(
//                     controller: searchController,
//                     style: const TextStyle(
//                       color: Color.fromARGB(255, 7, 59, 120),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         isSearchActive = value.isNotEmpty;
//                         myFuture = fetchCardsCountMethod(value);
//                       });
//                     },
//                     decoration: const InputDecoration(
//                       hintText: "Search...",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: InputBorder.none,
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                       contentPadding: EdgeInsets.only(top: 8),
//                     ),
//                   ),
//                 )
//               : const Text(
//                   'Change Order',
//                   style: TextStyle(color: Colors.white),
//                 ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 isSearching ? Icons.close : Icons.search,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 setState(() {
//                   if (isSearching) {
//                     searchController.clear();
//                     fetchCardsCountMethod('');
//                   }
//                   isSearching = !isSearching;
//                 });
//               },
//             )
//           ],
//         ),
//         drawer: DrawerManu(menu: menu),
//         body: FutureBuilder(
//           future: myFuture,
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return GestureDetector(
//                 onTap: () {
//                   FocusScopeNode currentFocus = FocusScope.of(context);
//                   if (!currentFocus.hasPrimaryFocus) {
//                     currentFocus.unfocus();
//                   }
//                 },
//                 child: Stack(fit: StackFit.expand, children: [
//                   RefreshIndicator(
//                     onRefresh: () async {
//                       await fetchCardsCountMethod('');
//                       print('RefreshIndicator called');
//                     },
//                     child: SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Column(
//                           children: [
//                             if (!isSearchActive || remainingStatusesCount > 0)
//                               DashboardCard(
//                                 title: 'All Change Order',
//                                 imagePath: 'assets/Dash_1.jpg',
//                                 height: size.height * 0.15,
//                                 width: size.width * 0.99,
//                                 count: remainingStatusesCount.toString(),
//                                 onTap: () {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           CrewTotalOrderAllChangeOrder(
//                                         budgetType: widget.budgetType,
//                                         maintenanceType: widget.maintenanceType,
//                                         heading: 'All Change Order',
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             // if (!isSearchActive || initiatedCount > 0)
//                             //   DashboardCard(
//                             //     title: 'Total Order (Initiated)',
//                             //     imagePath: 'assets/Dash_1.jpg',
//                             //     height: size.height * 0.15,
//                             //     width: size.width * 0.99,
//                             //     count: initiatedCount.toString(),
//                             //     onTap: () {
//                             //       Navigator.of(context).push(
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               CrewTotalOrderIniciated(
//                             //             budgetType: widget.budgetType,
//                             //             maintenanceType: widget.maintenanceType,
//                             //             heading: 'Total Order Initiated',
//                             //           ),
//                             //         ),
//                             //       );
//                             //     },
//                             //   ),
//                             // if (!isSearchActive || pendingApprovalCount > 0)
//                             //   DashboardCard(
//                             //     title: 'Pending Approval',
//                             //     imagePath: 'assets/Dash_2.jpg',
//                             //     height: size.height * 0.15,
//                             //     width: size.width * 0.99,
//                             //     count: pendingApprovalCount.toString(),
//                             //     onTap: () {
//                             //       Navigator.of(context).push(
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               CrewTotalOrderPendingApproval(
//                             //             budgetType: widget.budgetType,
//                             //             maintenanceType: widget.maintenanceType,
//                             //             heading:
//                             //                 'Pending Approval (${widget.heading})',
//                             //           ),
//                             //         ),
//                             //       );
//                             //     },
//                             //   ),
//                             // if (!isSearchActive || pendingCount > 0)
//                             //   DashboardCard(
//                             //     title: 'Pending',
//                             //     imagePath: 'assets/Dash_3.png',
//                             //     height: size.height * 0.15,
//                             //     width: size.width * 0.99,
//                             //     count: pendingCount.toString(),
//                             //     onTap: () {
//                             //       Navigator.of(context).push(
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               CrewTotalOrderPending(
//                             //             budgetType: widget.budgetType,
//                             //             maintenanceType: widget.maintenanceType,
//                             //             heading: 'Pending (${widget.heading})',
//                             //           ),
//                             //         ),
//                             //       );
//                             //     },
//                             //   ),

//                             if (!isSearchActive || assignedAndRejectedCount > 0)
//                               DashboardCard(
//                                 title: 'Assigned',
//                                 imagePath: 'assets/Dash_4.jpg',
//                                 height: size.height * 0.15,
//                                 width: size.width * 0.99,
//                                 count: assignedAndRejectedCount.toString(),
//                                 onTap: () {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const ChangeOrderTable(),
//                                     ),
//                                   );
//                                 },
//                               ),

//                             // if (!isSearchActive || rejectedCount > 0)
//                             //   DashboardCard(
//                             //     title: 'Total Order (Rejected)',
//                             //     imagePath: 'assets/Dash_6.jpg',
//                             //     height: size.height * 0.15,
//                             //     width: size.width * 0.99,
//                             //     count: rejectedCount.toString(),
//                             //     onTap: () {
//                             //       Navigator.of(context).push(
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               const ChangeOrderTableRejected(),
//                             //         ),
//                             //       );
//                             //     },
//                             //   ),
//                             // if (!isSearchActive || workedCount > 0)
//                             //   DashboardCard(
//                             //     title: 'Worked',
//                             //     imagePath: 'assets/Dash_5.jpg',
//                             //     height: size.height * 0.15,
//                             //     width: size.width * 0.99,
//                             //     count: workedCount.toString(),
//                             //     onTap: () {
//                             //       Navigator.of(context).push(
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               CrewTotalOrderWorked(
//                             //             budgetType: widget.budgetType,
//                             //             maintenanceType: widget.maintenanceType,
//                             //             heading:
//                             //                 'Total Order Inspection (${widget.heading})',
//                             //           ),
//                             //         ),
//                             //       );
//                             //     },
//                             //   ),
//                             // if (!isSearchActive || completedCount > 0)
//                             //   DashboardCard(
//                             //     title: 'Total Orders (Completed)',
//                             //     imagePath: 'assets/Dash_1.jpg',
//                             //     height: size.height * 0.15,
//                             //     width: size.width * 0.99,
//                             //     count: completedCount.toString(),
//                             //     onTap: () {
//                             //       Navigator.of(context).push(
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               CrewTotalOrderClosed(
//                             //             budgetType: widget.budgetType,
//                             //             maintenanceType: widget.maintenanceType,
//                             //             heading:
//                             //                 'Total Order Closed (${widget.heading})',
//                             //           ),
//                             //         ),
//                             //       );
//                             //     },
//                             //   ),
//                             // if (!isSearchActive || cancelledCount > 0)
//                             //   DashboardCard(
//                             //     title: 'Total Orders (Cancelled)',
//                             //     imagePath: 'assets/Dash_6.jpg',
//                             //     height: size.height * 0.15,
//                             //     width: size.width * 0.99,
//                             //     count: cancelledCount.toString(),
//                             //     onTap: () {
//                             //       Navigator.of(context).push(
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               CrewTotalOrderCancelled(
//                             //             budgetType: widget.budgetType,
//                             //             maintenanceType: widget.maintenanceType,
//                             //             heading:
//                             //                 'Total Order Cancelled (${widget.heading})',
//                             //           ),
//                             //         ),
//                             //       );
//                             //     },
//                             //   ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: Color.fromARGB(255, 7, 59, 120),
//                 ),
//               );
//             }
//           },
//         ));
//   }

//   Future<void> fetchCardsCountMethod(String search) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     id = data.user!.id.toString();
//     print("id test ${id}");
//     String url =
//         '${AppUrl.baseUrl}changeOrderLcpCreateOrder/countAllChangeOrdersCardData?compnyName=ZIELIES&id=$id&search=$search';

//     print("url cards count $url");
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer ${data.token}',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//       );

//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         print('responseBody $data');

//         print('API call successful $url');
//         setState(() {
//           initiatedCount = data['countOfInitiatedOrder'] ?? 0;
//           pendingApprovalCount = data['countOfPendingApprovalOrder'] ?? 0;
//           pendingCount = data['countOfPendingOrder'] ?? 0;
//           assignedCount = data['countOfAssignOrder'] ?? 0;
//           rejectedCount = data['countOfRejectOrder'] ?? 0;
//           workedCount = data['countOfWorkedOrder'] ?? 0;
//           completedCount = data['countOfCompletedOrder'] ?? 0;
//           cancelledCount = data['countOfCancelledOrder'] ?? 0;
//           assignedAndRejectedCount = data['countofassignedandrejected'] ?? 0;
//           remainingStatusesCount = data['countofremainingstatuses'] ?? 0;
//         });
//       } else {
//         setState(() {});
//         print('Failed to update status: ${response.statusCode}');
//       }
//     } catch (e) {
//       setState(() {});
//       print('Error occurred: $e');
//     }
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
//   final browser = MyChromeSafariBrowser();
//   @override
//   void initState() {
//     setUserName();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userPreferences = Provider.of<UserPref>(context);
//     var provider = Provider.of<LocationProvider>(context, listen: true);
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           // Important: Remove any padding from the ListView.
//           // padding: EdgeInsets.zero,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 180,
//               color: const Color.fromARGB(255, 3, 47, 97),
//               padding: const EdgeInsets.only(top: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
// menuLogoLCP(), const SizedBox(height: 6),
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
//                     title: const Text('Crew Dashboard'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const CrewBottomNavigationPannel()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.running_with_errors,
//                     ),
//                     title: const Text('IVM Maintenance Job List'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const CrewIVMMaintenancePlanTable()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.table_view,
//                     ),
//                     title: const Text('View Change Order'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.map,
//                   //   ),
//                   //   title: const Text('Map View'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () async {
//                   //     String id = '';
//                   //     final userPreferences1 =
//                   //         Provider.of<UserPref>(context, listen: false);
//                   //     UserModel data = await userPreferences1.getUser();
//                   //     id = data.user!.id.toString();
//                   //     //  Navigator.push(
//                   //     //                 context,
//                   //     //                 MaterialPageRoute(
//                   //     //                   builder: (context) =>
//                   //     //                       MapViewPage(
//                   //     //                     url: MapUrl.getCrewWithIdEndPoint(id),
//                   //     //                   ),
//                   //     //                 ),
//                   //     //               );

//                   //     await browser.open(
//                   //         url: WebUri(MapUrl.getCrewWithIdEndPoint(id)),
//                   //         // "https://mapapi.ariespro.com/main/crew_main/CIVM_Map/USRQWXH589Z/${id}"),
//                   //         settings: ChromeSafariBrowserSettings(
//                   //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                   //             barCollapsingEnabled: true));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.location_on,
//                     ),
//                     title: const Text('LCP System Map'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       provider.getLocation();
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const MapScreenLeafLat()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.logout,
//                     ),
//                     title: const Text('Log Out'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       // // Constants.prefs.setBool("LoggedIn", false);
//                       userPreferences.remove().then((value) {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 const LoginPage()));
//                       });
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
//       'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
//     );
//     String imageUrl =
//         'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
//     _imagePath = imageUrl;
//     setState(() {
//       String fName =
//           (data.user!.fName == 'null') ? '' : data.user!.fName.toString();
//       String lName =
//           (data.user!.lName == 'null') ? '' : data.user!.lName.toString();
//       // userName = '${data.user!.fName} ${(data.user!.lName) != null? data.user!.lName :''}';
//       userName = '$fName $lName';
//     });
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final String title;
//   final String? count;
//   final VoidCallback onTap;
//   final String imagePath;
//   final double height;
//   final double width;

//   const DashboardCard({
//     Key? key,
//     required this.title,
//     required this.onTap,
//     required this.imagePath,
//     this.count,
//     required this.height,
//     required this.width,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//       decoration: const BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Color.fromARGB(255, 3, 47, 97),
//             blurRadius: 5,
//             offset: Offset(2.0, 5.0),
//           )
//         ],
//         gradient: LinearGradient(
//           colors: [
//             Color.fromARGB(255, 7, 59, 120),
//             Color.fromARGB(255, 7, 59, 120),
//           ],
//         ),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           margin: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.center,
//           height: height,
//           width: width,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color.fromARGB(255, 3, 47, 97),
//                 blurRadius: 10,
//                 offset: Offset(2.0, 5.0),
//               )
//             ],
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(
//                 Colors.black.withOpacity(0.45),
//                 BlendMode.darken,
//               ),
//             ),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//               Text(
//                 count ?? '',
//                 style: const TextStyle(
//                   fontSize: 22,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
