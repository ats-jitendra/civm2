// import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/approve_civm_access.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/budget_planning.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/inspection_zielies.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_cost_analysis.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_cost_analysis_by_month.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_cost_analysis_by_season.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_maintenance_plan.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
// import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/piedmont/screens/login_page.dart';
// import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
// import 'package:CIVM/piedmont/utils/common_functions.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

// // ignore: must_be_immutable
// class VegetationCostAnalysis extends StatefulWidget {
//   const VegetationCostAnalysis({Key? key}) : super(key: key);

//   @override
//   State<VegetationCostAnalysis> createState() => _VegetationCostAnalysisState();
// }

// class _VegetationCostAnalysisState extends State<VegetationCostAnalysis> {
//   List<Map<String, dynamic>> listOfColumns = [];
//   List<Map<String, dynamic>> listOfColumns1 = [];
//   var result = [];
//   List<String> menu = [];

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
//           '',
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
//           margin: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.center,
//           // height: size.height * 0.65,
//           width: size.width * 0.99,
//           decoration: BoxDecoration(
//               // shape: BoxShape.circle,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Color.fromARGB(255, 3, 47, 97),
//                     blurRadius: 10,
//                     offset: Offset(2.0, 5.0))
//               ],
//               gradient: const LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 255, 255, 255),
//                   Color.fromARGB(255, 255, 255, 255),
//                 ],
//               )),
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(top: 8.0),
//                 child: Text(
//                   "Vegetation Cost Analysis",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   // Navigator.pushNamed(context, RoutesNamePemc.rowCostAnalysis);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (BuildContext contex) =>
//                               const RowCostAnalysis()));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.8,
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
//                           "ROW COST ANALYSIS",
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
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   // Navigator.pushNamed(
//                   //     context, RoutesNamePemc.rowCostAnalysisByMonth);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (BuildContext contex) =>
//                               const RowCostAnalysisByMonth()));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.8,
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
//                           "ROW COST ANALYSIS BY MONTH",
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
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   // Navigator.pushNamed(
//                   //     context, RoutesNamePemc.rowCostAnalysisBySeason);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (BuildContext contex) =>
//                               const RowCostAnalysisBySeason()));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.8,
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
//                           "ROW COST ANALYSIS BY SEASON",
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
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.center,
//           // height: size.height * 0.55,
//           width: size.width * 0.99,
//           decoration: BoxDecoration(
//               // shape: BoxShape.circle,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Color.fromARGB(255, 3, 47, 97),
//                     blurRadius: 10,
//                     offset: Offset(2.0, 5.0))
//               ],
//               gradient: const LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 255, 255, 255),
//                   Color.fromARGB(255, 255, 255, 255),
//                 ],
//               )),
//           child: const Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 8.0),
//                       child: Image(
//                         image: AssetImage('assets/maintenance_analysis.jpg'),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0, left: 8),
//                           child: Text(
//                             "ROW COST ANALYSIS",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 color: Colors.orangeAccent,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0, left: 8),
//                           child: Text(
//                             "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Recusandae voluptate repellendus magni illo ea animi?",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 3, 47, 97),
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.center,
//           // height: size.height * 0.55,
//           width: size.width * 0.99,
//           decoration: BoxDecoration(
//               // shape: BoxShape.circle,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Color.fromARGB(255, 3, 47, 97),
//                     blurRadius: 10,
//                     offset: Offset(2.0, 5.0))
//               ],
//               gradient: const LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 255, 255, 255),
//                   Color.fromARGB(255, 255, 255, 255),
//                 ],
//               )),
//           child: const Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 8.0),
//                       child: Image(
//                         image: AssetImage('assets/vmi2.jpg'),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0, left: 8),
//                           child: Text(
//                             "ROW COST ANALYSIS BY MONTH",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 color: Colors.orangeAccent,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0, left: 8),
//                           child: Text(
//                             "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Recusandae voluptate repellendus magni illo ea animi?",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 3, 47, 97),
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.center,
//           // height: size.height * 0.55,
//           width: size.width * 0.99,
//           decoration: BoxDecoration(
//               // shape: BoxShape.circle,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Color.fromARGB(255, 3, 47, 97),
//                     blurRadius: 10,
//                     offset: Offset(2.0, 5.0))
//               ],
//               gradient: const LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 255, 255, 255),
//                   Color.fromARGB(255, 255, 255, 255),
//                 ],
//               )),
//           child: const Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 8.0),
//                       child: Image(
//                         image: AssetImage('assets/vmi3.jpg'),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0, left: 8),
//                           child: Text(
//                             "ROW COST ANALYSIS BY SEASON",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 color: Colors.orangeAccent,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0, left: 8),
//                           child: Text(
//                             "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Recusandae voluptate repellendus magni illo ea animi?",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 3, 47, 97),
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ]))),
//     );
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
//     final browser = MyChromeSafariBrowser();
//     return Drawer(
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: AppColors.lighterBaseColor,
//             ),
//             child: Column(
//               children: [
//                 menuLogo(),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 6.0),
//                   child: Text(
//                     userName,
//                     style: const TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.computer,
//             ),
//             title: const Text('Row Maintenance Plan'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const RowMaintenanceView()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.compare,
//             ),
//             title: const Text('Inspection'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const InspectionZielies()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.pending,
//             ),
//             title: const Text('Service Order'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const AdmServiceOrder()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.airplane_ticket_sharp,
//             ),
//             title: const Text('Job List'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       AdminAddNewRowTable(index:'0')));
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => AddNewRowMaintenancePlan(
//               //           tokenNo: '',
//               //           index: '0',
//               //           subStation: '',
//               //           feeder: '',
//               //           nextMaintYear: '',
//               //           maintType: '',
//               //           totalMiles: '',
//               //           costPerMile: '',
//               //           totalCost: '',
//               //           budgetType: '',
//               //           contractRowYear: '',
//               //           rowCycle: '',
//               //           rowYear: '',
//               //           contractorCompany: '',
//               //           assignForeman: '',
//               //         )));
//             },
//           ),
//           // Visibility(
//           //   visible: (widget.menu.isNotEmpty &&
//           //           widget.menu.contains('Energy Audit Ticket'))
//           //       ? true
//           //       : false,
//           // child:
//               ///////////new added maps for PEMC
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
//           ListTile(
//             leading: const Icon(
//               Icons.open_in_new,
//             ),
//             title: const Text('IVM Maintenance Progress'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const RowMaintenanceProgress()));
//             },
//           ),
//           // ),
//           // ListTile(
//           //   leading: const Icon(
//           //     Icons.closed_caption_off,
//           //   ),
//           //   title: const Text('Row Analytics Dashboard'),
//           //   textColor: AppColors.baseColor,
//           //   iconColor: AppColors.baseColor,
//           //   onTap: () {
//           //     Navigator.pop(context);
//           //   },
//           // ),
//                   ListTile(
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
//           ListTile(
//             leading: const Icon(
//               Icons.data_usage,
//             ),
//             title: const Text('Budget Planning'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const BudgetPlanning()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.location_on,
//             ),
//             title: const Text('Live IVM System Map'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               provider.getLocation();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const MapScreenLeafLat()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.check,
//             ),
//             title: const Text('Approve CIVM Access'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ApproveCIVMAccess()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.add,
//             ),
//             title: const Text('Add Crew Member'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const AddCrewMember()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.logout,
//             ),
//             title: const Text('Logout'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               // Constants.prefs.setBool("LoggedIn", false);
//               userPreferences.remove().then((value) {
//                 // ignore: use_build_context_synchronously
//                 // Navigator.pushReplacement(context, RoutesName.login);
//                 // Navigator.pushNamed(
//                 //     context, RoutesName.login);
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) => const LoginPagePemc()));
//               });
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => const LoginPage()));
//             },
//           ),
//         ],
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
