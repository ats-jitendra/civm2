// import 'dart:io';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/repository/map_url.dart';
// import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/screens/map/provider/location_provider.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_add_crew_memeber.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_table.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_change_order_all_status.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_row_maintenance_plan_dashboard.dart';
// import 'package:CIVM/sharedPrefs/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/screens/login_page.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:provider/provider.dart';
// import 'package:upgrader/upgrader.dart';

// class PlannerRowMaintenanceView extends StatefulWidget {
//   const PlannerRowMaintenanceView({Key? key}) : super(key: key);

//   @override
//   State<PlannerRowMaintenanceView> createState() =>
//       _PlannerRowMaintenanceViewState();
// }

// class _PlannerRowMaintenanceViewState extends State<PlannerRowMaintenanceView> {
//   // int _currentIndex = 0;
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

//   @override
//   void initState() {
//     // getOwnPermissions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Row Maintenance Plan',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         drawer: DrawerManu(menu: menu),
//         body: UpgradeAlert(
//           barrierDismissible: false,
//           showLater: true,
//           showIgnore: true,
//           showReleaseNotes: false,
//           dialogStyle: Platform.isIOS
//               ? UpgradeDialogStyle.cupertino
//               : UpgradeDialogStyle.material,
//           upgrader: Upgrader(
//               debugDisplayAlways: false,
//               messages: UpgraderMessages(code: "Kindly update your app.")),
//           child: PopScope(
//       canPop: false,
//        onPopInvokedWithResult: (didPop, result) async {
//         if (didPop) {
//           return;
//         }
//         showExitPopup(context);
//       },
//             child: const DefaultTabController(
//               length: 1,
//               child: Padding(
//                 padding: EdgeInsets.all(4.0),
//                 child: Column(
//                   children: [
//                     // Container(
//                     //   margin: const EdgeInsets.all(4),
//                     //   height: 45,
//                     //   decoration: const BoxDecoration(
//                     //     color: Color.fromARGB(255, 132, 179, 233),
//                     //     // borderRadius: BorderRadius.circular(25.0)
//                     //   ),
//                     //   child: const TabBar(
//                     //     indicator: BoxDecoration(
//                     //       color: Color.fromARGB(255, 7, 59, 120),
//                     //       // borderRadius: BorderRadius.circular(25.0),
//                     //     ),
//                     //     indicatorSize: TabBarIndicatorSize.tab,
//                     //     labelColor: Colors.white,
//                     //     unselectedLabelColor: Color.fromARGB(255, 7, 59, 120),
//                     //     tabs: [
//                     //       Tab(
//                     //         // icon: Icon(Icons.tab, color: Colors.white),
//                     //         text: 'Dashboard',
//                     //       ),
//                     //       Tab(
//                     //         // icon: Icon(Icons.map, color: Colors.white),
//                     //         text: 'Tab View',
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     Expanded(
//                       child: TabBarView(
//                         children: [
//                           PlannerRowMaintenancePlanDashboard(),
//                           //   PlannerRowMaintenancePlanTabView(),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
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
//                   menuLogoLCP(),
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
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.computer,
//                   //   ),
//                   //   title: const Text('Row Maintenance Plan'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () {
//                   //     // Navigator.of(context).push(MaterialPageRoute(
//                   //     //     builder: (BuildContext context) =>
//                   //     //         const PlannerRowMaintenancePlanDashboardCopy()));
//                   //     //  Navigator.of(context).push(MaterialPageRoute(
//                   //     //   builder: (BuildContext context) =>
//                   //     //       const PlannerRowMaintenancePlanDashboard()));

//                   //     Navigator.pop(context);
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.computer,
//                     ),
//                     title: const Text('IVM Maintenance Job List'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (BuildContext context) =>
//                       //         PlannerAddNewRowMaintenancePlan(
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
//                       //           task: 'createOrder',
//                       //         )));

//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const PlannerAddNewRowTable()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.change_circle,
//                     ),
//                     title: const Text('Change Order Job List'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (BuildContext context) => ChangeOrderPlanner(
//                       //           budgetType: '',
//                       //           maintenanceType: 'Change Order',
//                       //           heading: 'Change Order',
//                       //         )));
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               PlannerChangeOrderAllStatus()));
//                     },
//                   ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.map,
//                   //   ),
//                   //   title: const Text('Add Change Order Map'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () async {
//                   //     String id = '';
//                   //     final userPreferences1 =
//                   //         Provider.of<UserPref>(context, listen: false);
//                   //     UserModel data = await userPreferences1.getUser();
//                   //     id = data.user!.id.toString();
//                   //     // Navigator.push(
//                   //     //   context,
//                   //     //   MaterialPageRoute(
//                   //     //     builder: (context) => MapViewPage(
//                   //     //       url: MapUrl.getCreateChangeOrderFromPlannerEndPoint(id),
//                   //     //     ),
//                   //     //   ),
//                   //     // );
//                   //     await browser.open(
//                   //         url: WebUri(
//                   //             MapUrl.getCreateChangeOrderFromPlannerEndPoint(
//                   //                 id)),
//                   //         settings: ChromeSafariBrowserSettings(
//                   //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                   //             barCollapsingEnabled: true));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.location_searching,
//                     ),
//                     title: const Text('Add Row Maintenance Map'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => MapViewPage(
//                       //       url: MapUrl.getPlannerWithoutTokenEndPoint(id),
//                       //     ),
//                       //   ),
//                       // );
//                       await browser.open(
//                           url: WebUri(
//                               // "https://mapapi.ariespro.com/main/planner/CIVM_Map/USRQWXH589Z"),
//                               MapUrl.getPlannerWithoutTokenEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.map_outlined,
//                   //   ),
//                   //   title: const Text('Add Spray Map'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () async {
//                   //     String id = '';
//                   //     final userPreferences1 =
//                   //         Provider.of<UserPref>(context, listen: false);
//                   //     UserModel data = await userPreferences1.getUser();
//                   //     id = data.user!.id.toString();
//                   //     // Navigator.push(
//                   //     //   context,
//                   //     //   MaterialPageRoute(
//                   //     //     builder: (context) => MapViewPage(
//                   //     //       url: MapUrl.getPlannerSprayWithoutTokenEndPoint(id),
//                   //     //     ),
//                   //     //   ),
//                   //     // );
//                   //     await browser.open(
//                   //         url: WebUri(
//                   //             // "https://mapapi.ariespro.com/main/spray_map/CIVM_Map/USRQWXH589Z"),
//                   //             MapUrl.getPlannerSprayWithoutTokenEndPoint(id)),
//                   //         settings: ChromeSafariBrowserSettings(
//                   //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                   //             barCollapsingEnabled: true));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.location_on,
//                     ),
//                     title: const Text('Live IVM System Map'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       provider.getLocation();
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const MapScreenLeafLat()));
//                     },
//                   ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //    // Icons.share_location,
//                   //      Icons.my_location,
//                   //   ),
//                   //   title: const Text('AI Enable On Demand Area'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () async {
//                   //     String id = '';
//                   //     final userPreferences1 =
//                   //         Provider.of<UserPref>(context, listen: false);
//                   //     UserModel data = await userPreferences1.getUser();
//                   //     id = data.user!.id.toString();
//                   //     await browser.open(
//                   //         url: WebUri("https://lcpmapapi.ariespro.com/main/Ai_enable_on_demand_Area"),

//                   //         settings: ChromeSafariBrowserSettings(
//                   //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                   //             barCollapsingEnabled: true));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.add,
//                     ),
//                     title: const Text('Add Crew Member'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const PlannerAddCrewMember()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.logout,
//                     ),
//                     title: const Text('Logout'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       // Constants.prefs.setBool("LoggedIn", false);
//                       userPreferences.remove().then((value) {
//                         // ignore: use_build_context_synchronously
//                         // Navigator.pushReplacement(context, RoutesName.login);
//                         // Navigator.pushNamed(
//                         //     context, RoutesName.login);
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 const LoginPage()));
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
//       print('userName $fName');
//     });
//   }
// }
